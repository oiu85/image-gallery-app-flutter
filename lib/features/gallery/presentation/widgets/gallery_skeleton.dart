import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class GallerySkeleton extends StatelessWidget {
  const GallerySkeleton({super.key});

  static const _itemCount = 6;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Skeletonizer(
      enabled: true,
      effect: ShimmerEffect(
        baseColor: colorScheme.surfaceContainerHighest,
        highlightColor: colorScheme.surface,
        duration: const Duration(milliseconds: 1500),
      ),
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
          childAspectRatio: 0.85,
        ),
        itemCount: _itemCount,
        itemBuilder: (context, index) => const _SkeletonGridItem(),
      ),
    );
  }
}

class _SkeletonGridItem extends StatelessWidget {
  const _SkeletonGridItem();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: Row(
              children: [
                Container(
                  width: 14.r,
                  height: 14.r,
                  decoration: BoxDecoration(color: Colors.grey[300], shape: BoxShape.circle),
                ),
                SizedBox(width: 6.w),
                Container(
                  width: 70.w,
                  height: 10.h,
                  decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(4.r)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
