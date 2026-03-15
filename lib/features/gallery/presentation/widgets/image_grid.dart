import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/pixabay_image.dart';
import 'image_grid_item.dart';

class ImageGrid extends StatelessWidget {
  const ImageGrid({
    super.key,
    required this.images,
    required this.isLoadingMore,
    required this.scrollController,
    required this.onImageTap,
  });

  final List<PixabayImage> images;
  final bool isLoadingMore;
  final ScrollController scrollController;
  final ValueChanged<PixabayImage> onImageTap;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12.h,
              crossAxisSpacing: 12.w,
              childAspectRatio: 0.85,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => ImageGridItem(image: images[index], onTap: () => onImageTap(images[index])),
              childCount: images.length,
            ),
          ),
        ),
        if (isLoadingMore)
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary)),
            ),
          ),
      ],
    );
  }
}
