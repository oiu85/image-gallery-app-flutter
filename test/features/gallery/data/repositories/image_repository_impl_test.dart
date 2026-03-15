import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile_image_gallery_app/core/network/network_client.dart';
import 'package:mobile_image_gallery_app/features/gallery/data/datasource/pixabay_api_service.dart';
import 'package:mobile_image_gallery_app/features/gallery/data/models/pixabay_image.dart';
import 'package:mobile_image_gallery_app/features/gallery/data/models/pixabay_response.dart';
import 'package:mobile_image_gallery_app/features/gallery/data/repositories/image_repository_impl.dart';

class MockPixabayApiService extends Mock implements PixabayApiService {}

void main() {
  late MockPixabayApiService mockApiService;
  late ImageRepositoryImpl repository;

  setUp(() {
    mockApiService = MockPixabayApiService();
    repository = ImageRepositoryImpl(mockApiService);
  });

  group('ImageRepositoryImpl', () {
    final tImages = [
      const PixabayImage(
        id: 1,
        previewURL: 'https://example.com/preview1.jpg',
        webformatURL: 'https://example.com/web1.jpg',
        tags: 'nature, sky',
        user: 'photographer1',
        views: 1000,
        likes: 50,
        comments: 10,
        downloads: 200,
      ),
      const PixabayImage(
        id: 2,
        previewURL: 'https://example.com/preview2.jpg',
        webformatURL: 'https://example.com/web2.jpg',
        tags: 'city, night',
        user: 'photographer2',
        views: 2000,
        likes: 100,
        comments: 20,
        downloads: 400,
      ),
    ];

    final tResponse = PixabayResponse(totalHits: 100, hits: tImages);

    test('returns PixabayResponse on successful search', () async {
      when(() => mockApiService.searchImages(
            query: any(named: 'query'),
            page: any(named: 'page'),
            perPage: any(named: 'perPage'),
          )).thenAnswer((_) async => Right(tResponse));

      final result = await repository.searchImages(query: 'nature', page: 1);

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (response) {
          expect(response.totalHits, 100);
          expect(response.hits.length, 2);
          expect(response.hits.first.user, 'photographer1');
        },
      );

      verify(() => mockApiService.searchImages(
            query: 'nature',
            page: 1,
            perPage: 20,
          )).called(1);
    });

    test('returns NetworkFailure on API error', () async {
      when(() => mockApiService.searchImages(
            query: any(named: 'query'),
            page: any(named: 'page'),
            perPage: any(named: 'perPage'),
          )).thenAnswer(
        (_) async => const Left(
          NetworkFailure(message: 'No internet connection.'),
        ),
      );

      final result = await repository.searchImages(query: 'cats');

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure.message, 'No internet connection.'),
        (_) => fail('Expected Left'),
      );
    });

    test('passes correct pagination parameters', () async {
      when(() => mockApiService.searchImages(
            query: any(named: 'query'),
            page: any(named: 'page'),
            perPage: any(named: 'perPage'),
          )).thenAnswer(
        (_) async => Right(PixabayResponse(totalHits: 0, hits: const [])),
      );

      await repository.searchImages(query: 'dogs', page: 3, perPage: 10);

      verify(() => mockApiService.searchImages(
            query: 'dogs',
            page: 3,
            perPage: 10,
          )).called(1);
    });
  });
}
