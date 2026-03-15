import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../gen/assets.gen.dart';
import '../../../gallery/data/models/pixabay_image.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key, required this.image});

  final PixabayImage image;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(color: colorScheme.onSurface.withValues(alpha: 0.04), blurRadius: 16, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _StatTile(
                  svgPath: Assets.images.icons.show.path,
                  label: 'Views',
                  value: _formatNumber(image.views),
                  iconColor: colorScheme.primary,
                  bgColor: colorScheme.primary.withValues(alpha: 0.1),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _StatTile(
                  svgPath: Assets.images.icons.heart.path,
                  label: 'Likes',
                  value: _formatNumber(image.likes),
                  iconColor: colorScheme.error,
                  bgColor: colorScheme.error.withValues(alpha: 0.1),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _StatTile(
                  svgPath: Assets.images.icons.chat.path,
                  label: 'Comments',
                  value: _formatNumber(image.comments),
                  iconColor: colorScheme.secondary,
                  bgColor: colorScheme.secondary.withValues(alpha: 0.1),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _StatTile(
                  svgPath: Assets.images.icons.download.path,
                  label: 'Downloads',
                  value: _formatNumber(image.downloads),
                  iconColor: colorScheme.tertiary,
                  bgColor: colorScheme.tertiary.withValues(alpha: 0.1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatNumber(int value) {
    if (value >= 1000000) return '${(value / 1000000).toStringAsFixed(1)}M';
    if (value >= 1000) return '${(value / 1000).toStringAsFixed(1)}K';
    return value.toString();
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.svgPath,
    required this.label,
    required this.value,
    required this.iconColor,
    required this.bgColor,
  });

  final String svgPath;
  final String label;
  final String value;
  final Color iconColor;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      decoration: BoxDecoration(color: bgColor.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(12.r)),
      child: Column(
        children: [
          Container(
            width: 36.r,
            height: 36.r,
            decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(10.r)),
            child: Center(
              child: SvgPicture.asset(
                svgPath,
                width: 18.r,
                height: 18.r,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(value, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          SizedBox(height: 2.h),
          Text(label, style: textTheme.bodySmall),
        ],
      ),
    );
  }
}
