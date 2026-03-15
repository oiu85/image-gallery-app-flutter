import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/util/app_cached_network_image.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../shared/widgets/app_snackbar.dart';
import '../../data/models/pixabay_image.dart';

class ImageGridItem extends StatelessWidget {
  const ImageGridItem({super.key, required this.image, required this.onTap});

  final PixabayImage image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(color: colorScheme.onSurface.withValues(alpha: 0.08), blurRadius: 12, offset: const Offset(0, 4)),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Hero(
                tag: 'image_${image.id}',
                child: AppCachedNetworkImage(
                  imageUrl: image.previewURL,
                  formatUrl: false,
                  fit: BoxFit.cover,
                  placeholder: Container(
                    color: colorScheme.surfaceContainerHighest,
                    child: Center(
                      child: SizedBox(
                        width: 24.r,
                        height: 24.r,
                        child: CircularProgressIndicator(strokeWidth: 2, color: colorScheme.primary),
                      ),
                    ),
                  ),
                  errorWidget: Container(
                    color: colorScheme.surfaceContainerHighest,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          Assets.images.icons.image.path,
                          width: 28.r,
                          height: 28.r,
                          colorFilter: ColorFilter.mode(colorScheme.outline, BlendMode.srcIn),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'No preview',
                          style: TextStyle(fontSize: 10.sp, color: colorScheme.outline),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 8.r,
                right: 8.r,
                child: GestureDetector(
                  onTap: () => AppSnackBar.showComingSoon(context, feature: 'Favorites'),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          Assets.images.icons.heart.path,
                          width: 12.r,
                          height: 12.r,
                          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                        ),
                        SizedBox(width: 3.w),
                        Text(
                          _formatCount(image.likes),
                          style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black.withValues(alpha: 0.7), Colors.black.withValues(alpha: 0.0)],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10.w, 20.h, 10.w, 8.h),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          Assets.images.icons.profile.path,
                          width: 14.r,
                          height: 14.r,
                          colorFilter: ColorFilter.mode(Colors.white.withValues(alpha: 0.9), BlendMode.srcIn),
                        ),
                        SizedBox(width: 5.w),
                        Expanded(
                          child: Text(
                            image.user,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withValues(alpha: 0.95),
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatCount(int value) {
    if (value >= 1000000) return '${(value / 1000000).toStringAsFixed(1)}M';
    if (value >= 1000) return '${(value / 1000).toStringAsFixed(1)}K';
    return value.toString();
  }
}
