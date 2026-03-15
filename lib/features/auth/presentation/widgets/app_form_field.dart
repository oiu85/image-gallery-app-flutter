import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Reusable form field shared across auth screens.
class AppFormField extends StatelessWidget {
  const AppFormField({
    super.key,
    required this.label,
    required this.hint,
    required this.error,
    required this.onChanged,
    this.keyboardType,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.sentences,
    this.prefixIcon,
  });

  final String label;
  final String hint;
  final String? error;
  final ValueChanged<String> onChanged;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final String? prefixIcon;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.titleSmall?.copyWith(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 6.h),
        TextFormField(
          onChanged: onChanged,
          keyboardType: keyboardType,
          obscureText: obscureText,
          textCapitalization: textCapitalization,
          style: textTheme.bodyMedium,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: textTheme.bodyMedium?.copyWith(
              color: colorScheme.outline,
            ),
            errorText: error,
            errorStyle: textTheme.bodySmall?.copyWith(
              fontSize: 11.sp,
              color: colorScheme.error,
            ),
            prefixIcon: prefixIcon != null
                ? Padding(
                    padding: EdgeInsets.only(left: 14.w, right: 10.w),
                    child: SvgPicture.asset(
                      prefixIcon!,
                      width: 20.r,
                      height: 20.r,
                      colorFilter: ColorFilter.mode(
                        colorScheme.outline,
                        BlendMode.srcIn,
                      ),
                    ),
                  )
                : null,
            prefixIconConstraints: BoxConstraints(
              minWidth: 44.w,
              minHeight: 20.h,
            ),
            filled: true,
            fillColor: colorScheme.surface,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: colorScheme.outline.withValues(alpha: 0.3),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: colorScheme.outline.withValues(alpha: 0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: colorScheme.primary,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: colorScheme.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: colorScheme.error,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
