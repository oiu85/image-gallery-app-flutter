import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/config/api_config.dart';
import '../../../../core/di/app_dependencies.dart';
import '../../../../core/storage/app_storage_service.dart';
import '../../data/models/pixabay_image.dart';
import '../../domain/repositories/image_repository.dart';

class GalleryState {
  const GalleryState({
    this.images = const [],
    this.query = '',
    this.currentPage = 1,
    this.totalHits = 0,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.errorMessage,
    this.userName,
  });

  final List<PixabayImage> images;
  final String query;
  final int currentPage;
  final int totalHits;
  final bool isLoading;
  final bool isLoadingMore;
  final String? errorMessage;
  final String? userName;

  bool get hasMore => images.length < totalHits;

  bool get isEmpty => !isLoading && images.isEmpty && errorMessage == null;

  bool get hasError => errorMessage != null;

  bool get hasResults => images.isNotEmpty;

  GalleryState copyWith({
    List<PixabayImage>? images,
    String? query,
    int? currentPage,
    int? totalHits,
    bool? isLoading,
    bool? isLoadingMore,
    String? errorMessage,
    String? userName,
    bool clearError = false,
  }) {
    return GalleryState(
      images: images ?? this.images,
      query: query ?? this.query,
      currentPage: currentPage ?? this.currentPage,
      totalHits: totalHits ?? this.totalHits,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      userName: userName ?? this.userName,
    );
  }
}

class GalleryViewModel extends StateNotifier<GalleryState> {
  GalleryViewModel(this._repository, this._storage)
      : super(const GalleryState()) {
    _init();
  }

  static const _defaultQuery = 'popular';

  final ImageRepository _repository;
  final AppStorageService _storage;

  Future<void> _init() async {
    final name = await _storage.getUserName();
    state = state.copyWith(userName: name);
    searchImages(_defaultQuery);
  }

  Future<void> searchImages(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;

    state = state.copyWith(
      query: trimmed,
      isLoading: true,
      images: [],
      currentPage: 1,
      totalHits: 0,
      clearError: true,
    );

    final result = await _repository.searchImages(
      query: trimmed,
      page: 1,
      perPage: ApiConfig.defaultPerPage,
    );

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, errorMessage: failure.message);
      },
      (response) {
        state = state.copyWith(
          images: response.hits,
          totalHits: response.totalHits,
          currentPage: 1,
          isLoading: false,
          clearError: true,
        );
      },
    );
  }

  Future<void> loadNextPage() async {
    if (state.isLoadingMore || state.isLoading || !state.hasMore) return;

    final nextPage = state.currentPage + 1;
    state = state.copyWith(isLoadingMore: true);

    final result = await _repository.searchImages(
      query: state.query,
      page: nextPage,
      perPage: ApiConfig.defaultPerPage,
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoadingMore: false,
          errorMessage: failure.message,
        );
      },
      (response) {
        state = state.copyWith(
          images: [...state.images, ...response.hits],
          totalHits: response.totalHits,
          currentPage: nextPage,
          isLoadingMore: false,
          clearError: true,
        );
      },
    );
  }

  void retry() {
    if (state.query.isNotEmpty) {
      searchImages(state.query);
    }
  }

  void clearSearch() {
    state = state.copyWith(
      images: [],
      currentPage: 1,
      totalHits: 0,
      clearError: true,
    );
    searchImages(_defaultQuery);
  }
}

final galleryViewModelProvider =
    StateNotifierProvider<GalleryViewModel, GalleryState>((ref) {
  return GalleryViewModel(
    getIt<ImageRepository>(),
    getIt<AppStorageService>(),
  );
});
