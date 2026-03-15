import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../gen/assets.gen.dart';

class GalleryEmptyState extends StatelessWidget {
  const GalleryEmptyState({super.key, this.hasSearched = false});

  final bool hasSearched;

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
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  hasSearched ? Assets.images.icons.search.path : Assets.images.icons.image2.path,
                  width: 36.r,
                  height: 36.r,
                  colorFilter: ColorFilter.mode(colorScheme.primary.withValues(alpha: 0.6), BlendMode.srcIn),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              hasSearched ? 'No results found' : 'Search for images',
              style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8.h),
            Text(
              hasSearched
                  ? 'Try a different keyword or check your spelling.'
                  : 'Type a keyword above to discover amazing images.',
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(color: colorScheme.outline, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
