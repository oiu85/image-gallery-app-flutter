import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/util/app_cached_network_image.dart';
import '../../../../gen/assets.gen.dart';
import '../../../gallery/data/models/pixabay_image.dart';
import '../widgets/image_section.dart';
import '../widgets/stats_section.dart';

class ImageDetailScreen extends StatelessWidget {
  const ImageDetailScreen({super.key, required this.image});

  final PixabayImage image;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  ImageSection(image: image),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      SvgPicture.asset(
                        Assets.images.icons.chart.path,
                        width: 18.r,
                        height: 18.r,
                        colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
                      ),
                      SizedBox(width: 8.w),
                      Text('Statistics', style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  StatsSection(image: image),
                  SizedBox(height: 24.h),
                  _buildDownloadSection(context),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDownloadSection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorScheme.primary.withValues(alpha: 0.08), colorScheme.secondary.withValues(alpha: 0.06)],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colorScheme.primary.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Container(
            width: 44.r,
            height: 44.r,
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: SvgPicture.asset(
                Assets.images.icons.download.path,
                width: 22.r,
                height: 22.r,
                colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
              ),
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('High Resolution', style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                SizedBox(height: 2.h),
                Text('View on Pixabay for full size download', style: textTheme.bodySmall),
              ],
            ),
          ),
          SvgPicture.asset(
            Assets.images.icons.arrowRight.path,
            width: 20.r,
            height: 20.r,
            colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SliverAppBar(
      expandedHeight: 340.h,
      pinned: true,
      surfaceTintColor: Colors.transparent,
      leading: Padding(
        padding: EdgeInsets.all(8.r),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: IconButton(
            icon: SvgPicture.asset(
              Assets.images.icons.arrowLeft.path,
              width: 20.r,
              height: 20.r,
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 8.r),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: IconButton(
              icon: SvgPicture.asset(
                Assets.images.icons.heart.path,
                width: 20.r,
                height: 20.r,
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
              onPressed: () {},
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'image_${image.id}',
          child: AppCachedNetworkImage(
            imageUrl: image.webformatURL,
            formatUrl: false,
            fit: BoxFit.cover,
            placeholder: Container(
              color: colorScheme.surfaceContainerHighest,
              child: Center(child: CircularProgressIndicator(color: colorScheme.primary)),
            ),
            errorWidget: Container(
              color: colorScheme.surfaceContainerHighest,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.images.icons.image.path,
                    width: 48.r,
                    height: 48.r,
                    colorFilter: ColorFilter.mode(colorScheme.outline, BlendMode.srcIn),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Failed to load',
                    style: TextStyle(fontSize: 14.sp, color: colorScheme.outline),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
