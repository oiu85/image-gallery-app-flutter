import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../gen/assets.gen.dart';
import '../../../gallery/data/models/pixabay_image.dart';

class ImageSection extends StatelessWidget {
  const ImageSection({super.key, required this.image});

  final PixabayImage image;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildUserRow(context),
        SizedBox(height: 20.h),
        _buildTags(context),
      ],
    );
  }

  Widget _buildUserRow(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Container(
          width: 48.r,
          height: 48.r,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colorScheme.primary, colorScheme.secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Center(
            child: Text(
              image.user.isNotEmpty ? image.user[0].toUpperCase() : '?',
              style: textTheme.headlineSmall?.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(image.user, style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
              SizedBox(height: 2.h),
              Row(
                children: [
                  SvgPicture.asset(
                    Assets.images.icons.camera.path,
                    width: 14.r,
                    height: 14.r,
                    colorFilter: ColorFilter.mode(colorScheme.outline, BlendMode.srcIn),
                  ),
                  SizedBox(width: 4.w),
                  Text('Photographer', style: textTheme.bodySmall),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTags(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final tags = image.tagList;
    if (tags.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              Assets.images.icons.bookmark.path,
              width: 16.r,
              height: 16.r,
              colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
            ),
            SizedBox(width: 6.w),
            Text('Tags', style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
          ],
        ),
        SizedBox(height: 10.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: tags.map((tag) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
              decoration: BoxDecoration(color: colorScheme.primaryContainer, borderRadius: BorderRadius.circular(24.r)),
              child: Text(
                '#$tag',
                style: textTheme.labelSmall?.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
