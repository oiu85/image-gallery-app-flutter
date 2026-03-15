import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../gen/assets.gen.dart';

import '../../../../core/routing/app_routes.dart';
import '../../data/models/pixabay_image.dart';
import '../viewmodels/gallery_viewmodel.dart';
import '../widgets/gallery_empty_state.dart';
import '../widgets/gallery_error_state.dart';
import '../widgets/gallery_skeleton.dart';
import '../widgets/image_grid.dart';
import '../widgets/search_bar_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _scrollController = ScrollController();

  static const _paginationThreshold = 300.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;

    if (maxScroll - currentScroll <= _paginationThreshold) {
      ref.read(galleryViewModelProvider.notifier).loadNextPage();
    }
  }

  void _onImageTap(PixabayImage image) {
    context.push(AppRoutes.imageDetail, extra: image);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(galleryViewModelProvider);
    final viewModel = ref.read(galleryViewModelProvider.notifier);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
              child: Row(
                children: [
                  Container(
                    width: 44.r,
                    height: 44.r,
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        Assets.images.icons.image.path,
                        width: 22.r,
                        height: 22.r,
                        colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state.userName != null && state.userName!.isNotEmpty)
                          Text(
                            'Hello, ${state.userName} 👋',
                            style: textTheme.bodySmall?.copyWith(color: colorScheme.outline),
                          ),
                        Text(
                          'Discover',
                          style: textTheme.titleLarge?.copyWith(fontSize: 22.sp, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 44.r,
                    height: 44.r,
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        Assets.images.icons.category.path,
                        width: 20.r,
                        height: 20.r,
                        colorFilter: ColorFilter.mode(colorScheme.onSurface, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: GallerySearchBar(onSearch: viewModel.searchImages, onClear: viewModel.clearSearch),
            ),
            SizedBox(height: 16.h),
            if (state.hasResults && !state.isLoading)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      Assets.images.icons.discovery.path,
                      width: 18.r,
                      height: 18.r,
                      colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'Results for "${state.query}"',
                      style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    Text('${state.totalHits} found', style: textTheme.bodySmall?.copyWith(color: colorScheme.outline)),
                  ],
                ),
              ),
            SizedBox(height: 12.h),
            Expanded(child: _buildBody(state, viewModel)),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(GalleryState state, GalleryViewModel viewModel) {
    if (state.isLoading) {
      return const GallerySkeleton();
    }

    if (state.hasError && state.images.isEmpty) {
      return GalleryErrorState(message: state.errorMessage!, onRetry: viewModel.retry);
    }

    if (state.isEmpty) {
      return GalleryEmptyState(hasSearched: state.query.isNotEmpty);
    }

    return ImageGrid(
      images: state.images,
      isLoadingMore: state.isLoadingMore,
      scrollController: _scrollController,
      onImageTap: _onImageTap,
    );
  }
}
