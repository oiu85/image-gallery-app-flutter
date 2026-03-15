import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../gen/assets.gen.dart';

class GalleryErrorState extends StatelessWidget {
  const GalleryErrorState({super.key, required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80.r,
              height: 80.r,
              decoration: BoxDecoration(color: colorScheme.error.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: Center(
                child: SvgPicture.asset(
                  Assets.images.icons.dangerTriangle.path,
                  width: 36.r,
                  height: 36.r,
                  colorFilter: ColorFilter.mode(colorScheme.error.withValues(alpha: 0.7), BlendMode.srcIn),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text('Something went wrong', style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600)),
            SizedBox(height: 8.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(color: colorScheme.outline, height: 1.5),
            ),
            SizedBox(height: 28.h),
            SizedBox(
              height: 48.h,
              child: ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      Assets.images.icons.swap.path,
                      width: 18.r,
                      height: 18.r,
                      colorFilter: ColorFilter.mode(colorScheme.onPrimary, BlendMode.srcIn),
                    ),
                    SizedBox(width: 8.w),
                    Text('Try Again', style: textTheme.labelLarge?.copyWith(color: colorScheme.onPrimary)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
