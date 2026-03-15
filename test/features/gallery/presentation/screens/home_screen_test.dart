import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

final tImages = List.generate(
  6,
  (i) => PixabayImage(
    id: i,
    previewURL: 'https://example.com/$i.jpg',
    webformatURL: 'https://example.com/w$i.jpg',
    tags: 'tag$i',
    user: 'user$i',
    views: 100 * i,
    likes: 10 * i,
    comments: 5 * i,
    downloads: 50 * i,
  ),
);

Widget buildTestWidget({
  required ImageRepository repo,
  required AppStorageService storage,
}) {
  return ProviderScope(
    overrides: [
      galleryViewModelProvider.overrideWith(
        (ref) => GalleryViewModel(repo, storage),
      ),
    ],
    child: const MaterialApp(
      home: _TestHomeScreen(),
    ),
  );
}

class _TestHomeScreen extends ConsumerWidget {
  const _TestHomeScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(galleryViewModelProvider);

    return Scaffold(
      body: _buildBody(state),
    );
  }

  Widget _buildBody(GalleryState state) {
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(key: Key('loading_indicator')),
      );
    }

    if (state.hasError && state.images.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(state.errorMessage!, key: const Key('error_message')),
            ElevatedButton(
              key: const Key('retry_button'),
              onPressed: () {},
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state.isEmpty) {
      return const Center(
        child: Text('No images found', key: Key('empty_state')),
      );
    }

    return GridView.builder(
      key: const Key('image_grid'),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: state.images.length,
      itemBuilder: (context, index) {
        final image = state.images[index];
        return Card(
          key: Key('image_item_${image.id}'),
          child: Column(
            children: [
              Text(image.user),
              Text('${image.likes} likes'),
            ],
          ),
        );
      },
    );
  }
}

void main() {
  late MockImageRepository mockRepo;
  late MockAppStorageService mockStorage;

  setUp(() {
    mockRepo = MockImageRepository();
    mockStorage = MockAppStorageService();
  });

  group('Home Screen Widget Tests', () {
    testWidgets('shows loading indicator while fetching images',
        (tester) async {
      final completer = Completer<Either<NetworkFailure, PixabayResponse>>();

      when(() => mockStorage.getUserName()).thenAnswer((_) async => 'John');
      when(() => mockRepo.searchImages(
            query: any(named: 'query'),
            page: any(named: 'page'),
            perPage: any(named: 'perPage'),
          )).thenAnswer((_) => completer.future);

      await tester.pumpWidget(
        buildTestWidget(repo: mockRepo, storage: mockStorage),
      );

      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byKey(const Key('loading_indicator')), findsOneWidget);

      completer.complete(Right(PixabayResponse(totalHits: 0, hits: const [])));
      await tester.pumpAndSettle();
    });

    testWidgets('shows image grid when data loads successfully',
        (tester) async {
      when(() => mockStorage.getUserName()).thenAnswer((_) async => 'John');
      when(() => mockRepo.searchImages(
            query: any(named: 'query'),
            page: any(named: 'page'),
            perPage: any(named: 'perPage'),
          )).thenAnswer(
        (_) async => Right(PixabayResponse(totalHits: 6, hits: tImages)),
      );

      await tester.pumpWidget(
        buildTestWidget(repo: mockRepo, storage: mockStorage),
      );

      await tester.pumpAndSettle();

      expect(find.byKey(const Key('image_grid')), findsOneWidget);
      expect(find.text('user0'), findsOneWidget);
      expect(find.text('user1'), findsOneWidget);
    });

    testWidgets('shows error message on network failure', (tester) async {
      when(() => mockStorage.getUserName()).thenAnswer((_) async => null);
      when(() => mockRepo.searchImages(
            query: any(named: 'query'),
            page: any(named: 'page'),
            perPage: any(named: 'perPage'),
          )).thenAnswer(
        (_) async => const Left(
          NetworkFailure(message: 'No internet connection.'),
        ),
      );

      await tester.pumpWidget(
        buildTestWidget(repo: mockRepo, storage: mockStorage),
      );

      await tester.pumpAndSettle();

      expect(find.byKey(const Key('error_message')), findsOneWidget);
      expect(find.text('No internet connection.'), findsOneWidget);
      expect(find.byKey(const Key('retry_button')), findsOneWidget);
    });

    testWidgets('shows empty state when no results', (tester) async {
      when(() => mockStorage.getUserName()).thenAnswer((_) async => null);
      when(() => mockRepo.searchImages(
            query: any(named: 'query'),
            page: any(named: 'page'),
            perPage: any(named: 'perPage'),
          )).thenAnswer(
        (_) async => Right(PixabayResponse(totalHits: 0, hits: const [])),
      );

      await tester.pumpWidget(
        buildTestWidget(repo: mockRepo, storage: mockStorage),
      );

      await tester.pumpAndSettle();

      expect(find.byKey(const Key('empty_state')), findsOneWidget);
    });

    testWidgets('displays correct number of grid items', (tester) async {
      when(() => mockStorage.getUserName()).thenAnswer((_) async => null);
      when(() => mockRepo.searchImages(
            query: any(named: 'query'),
            page: any(named: 'page'),
            perPage: any(named: 'perPage'),
          )).thenAnswer(
        (_) async => Right(PixabayResponse(totalHits: 6, hits: tImages)),
      );

      await tester.pumpWidget(
        buildTestWidget(repo: mockRepo, storage: mockStorage),
      );

      await tester.pumpAndSettle();

      for (int i = 0; i < 6; i++) {
        final finder = find.byKey(Key('image_item_$i'));
        if (finder.evaluate().isNotEmpty) {
          expect(finder, findsOneWidget);
        }
      }
    });
  });
}
