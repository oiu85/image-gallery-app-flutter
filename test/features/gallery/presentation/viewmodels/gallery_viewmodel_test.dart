import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile_image_gallery_app/core/network/network_client.dart';
import 'package:mobile_image_gallery_app/core/storage/app_storage_service.dart';
import 'package:mobile_image_gallery_app/features/gallery/data/models/pixabay_image.dart';
import 'package:mobile_image_gallery_app/features/gallery/data/models/pixabay_response.dart';
import 'package:mobile_image_gallery_app/features/gallery/domain/repositories/image_repository.dart';
import 'package:mobile_image_gallery_app/features/gallery/presentation/viewmodels/gallery_viewmodel.dart';

class MockImageRepository extends Mock implements ImageRepository {}

class MockAppStorageService extends Mock implements AppStorageService {}

void main() {
  late MockImageRepository mockRepo;
  late MockAppStorageService mockStorage;
  late GalleryViewModel viewModel;

  final tImages = [
    const PixabayImage(
      id: 1,
      previewURL: 'https://example.com/1.jpg',
      webformatURL: 'https://example.com/w1.jpg',
      tags: 'nature',
      user: 'john',
      views: 100,
      likes: 10,
      comments: 5,
      downloads: 50,
    ),
    const PixabayImage(
      id: 2,
      previewURL: 'https://example.com/2.jpg',
      webformatURL: 'https://example.com/w2.jpg',
      tags: 'city',
      user: 'jane',
      views: 200,
      likes: 20,
      comments: 10,
      downloads: 100,
    ),
  ];

  final tResponse = PixabayResponse(totalHits: 50, hits: tImages);

  void stubInitSuccess() {
    when(() => mockStorage.getUserName()).thenAnswer((_) async => 'TestUser');
    when(() => mockRepo.searchImages(
          query: any(named: 'query'),
          page: any(named: 'page'),
          perPage: any(named: 'perPage'),
        )).thenAnswer((_) async => Right(tResponse));
  }

  setUp(() {
    mockRepo = MockImageRepository();
    mockStorage = MockAppStorageService();
  });

  group('GalleryViewModel', () {
    test('loads username and default images on init', () async {
      stubInitSuccess();

      viewModel = GalleryViewModel(mockRepo, mockStorage);

      await Future<void>.delayed(const Duration(milliseconds: 600));

      expect(viewModel.state.userName, 'TestUser');
      expect(viewModel.state.images.length, 2);
      expect(viewModel.state.query, 'popular');
      expect(viewModel.state.isLoading, isFalse);
      verify(() => mockStorage.getUserName()).called(1);
    });

    test('searchImages updates state with results', () async {
      stubInitSuccess();
      viewModel = GalleryViewModel(mockRepo, mockStorage);
      await Future<void>.delayed(const Duration(milliseconds: 600));

      final searchResponse = PixabayResponse(
        totalHits: 10,
        hits: [tImages.first],
      );
      when(() => mockRepo.searchImages(
            query: 'cats',
            page: 1,
            perPage: any(named: 'perPage'),
          )).thenAnswer((_) async => Right(searchResponse));

      await viewModel.searchImages('cats');

      expect(viewModel.state.query, 'cats');
      expect(viewModel.state.images.length, 1);
      expect(viewModel.state.totalHits, 10);
      expect(viewModel.state.isLoading, isFalse);
    });

    test('searchImages handles empty query', () async {
      stubInitSuccess();
      viewModel = GalleryViewModel(mockRepo, mockStorage);
      await Future<void>.delayed(const Duration(milliseconds: 600));

      final beforeImages = viewModel.state.images.length;
      await viewModel.searchImages('   ');
      expect(viewModel.state.images.length, beforeImages);
    });

    test('searchImages sets error on failure', () async {
      stubInitSuccess();
      viewModel = GalleryViewModel(mockRepo, mockStorage);
      await Future<void>.delayed(const Duration(milliseconds: 600));

      when(() => mockRepo.searchImages(
            query: 'fail',
            page: 1,
            perPage: any(named: 'perPage'),
          )).thenAnswer(
        (_) async => const Left(
          NetworkFailure(message: 'Connection timed out.'),
        ),
      );

      await viewModel.searchImages('fail');

      expect(viewModel.state.hasError, isTrue);
      expect(viewModel.state.errorMessage, 'Connection timed out.');
      expect(viewModel.state.images, isEmpty);
    });

    test('loadNextPage appends images', () async {
      final firstPageResponse = PixabayResponse(totalHits: 50, hits: tImages);
      when(() => mockStorage.getUserName()).thenAnswer((_) async => null);
      when(() => mockRepo.searchImages(
            query: any(named: 'query'),
            page: 1,
            perPage: any(named: 'perPage'),
          )).thenAnswer((_) async => Right(firstPageResponse));

      viewModel = GalleryViewModel(mockRepo, mockStorage);
      await Future<void>.delayed(const Duration(milliseconds: 600));

      expect(viewModel.state.images.length, 2);
      expect(viewModel.state.hasMore, isTrue);

      final nextPageImage = const PixabayImage(
        id: 3,
        previewURL: 'https://example.com/3.jpg',
        webformatURL: 'https://example.com/w3.jpg',
        tags: 'sunset',
        user: 'alex',
        views: 300,
        likes: 30,
        comments: 15,
        downloads: 150,
      );

      when(() => mockRepo.searchImages(
            query: 'popular',
            page: 2,
            perPage: any(named: 'perPage'),
          )).thenAnswer(
        (_) async => Right(PixabayResponse(totalHits: 50, hits: [nextPageImage])),
      );

      await viewModel.loadNextPage();

      expect(viewModel.state.images.length, 3);
      expect(viewModel.state.currentPage, 2);
    });

    test('retry re-executes the last query', () async {
      stubInitSuccess();
      viewModel = GalleryViewModel(mockRepo, mockStorage);
      await Future<void>.delayed(const Duration(milliseconds: 600));

      when(() => mockRepo.searchImages(
            query: 'popular',
            page: 1,
            perPage: any(named: 'perPage'),
          )).thenAnswer((_) async => Right(tResponse));

      viewModel.retry();
      await Future<void>.delayed(const Duration(milliseconds: 600));

      verify(() => mockRepo.searchImages(
            query: 'popular',
            page: 1,
            perPage: any(named: 'perPage'),
          )).called(greaterThanOrEqualTo(2));
    });

    test('clearSearch resets to default "popular" query', () async {
      stubInitSuccess();
      viewModel = GalleryViewModel(mockRepo, mockStorage);
      await Future<void>.delayed(const Duration(milliseconds: 600));

      viewModel.clearSearch();
      await Future<void>.delayed(const Duration(milliseconds: 600));

      expect(viewModel.state.query, 'popular');
    });
  });
}
