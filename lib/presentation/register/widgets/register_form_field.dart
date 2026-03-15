import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_colors.dart';

/// Reusable form field for register form.
class RegisterFormField extends StatelessWidget {
  const RegisterFormField({
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.lightOnSurface,
          ),
        ),
        SizedBox(height: 6.h),
        TextFormField(
          onChanged: onChanged,
          keyboardType: keyboardType,
          obscureText: obscureText,
          textCapitalization: textCapitalization,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.lightOnSurface,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 14.sp,
              color: AppColors.formHint,
            ),
            errorText: error,
            errorStyle: TextStyle(
              fontSize: 11.sp,
              color: AppColors.lightError,
            ),
            prefixIcon: prefixIcon != null
                ? Padding(
                    padding: EdgeInsets.only(left: 14.w, right: 10.w),
                    child: SvgPicture.asset(
                      prefixIcon!,
                      width: 20.r,
                      height: 20.r,
                      colorFilter: const ColorFilter.mode(
                        AppColors.lightOnSurfaceMuted,
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
            fillColor: AppColors.white,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.lightBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.lightBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.lightError),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: AppColors.lightError,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
