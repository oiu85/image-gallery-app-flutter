import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_image_gallery_app/gen/assets.gen.dart';

import '../../../core/theme/app_colors.dart';
import '../viewmodel/register_view_model.dart';
import 'register_form_field.dart';

/// Form widget for the register page.
class RegisterForm extends ConsumerWidget {
  const RegisterForm({
    super.key,
    required this.onRegister,
    required this.onSkip,
  });

  final VoidCallback onRegister;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registerViewModelProvider);
    final viewModel = ref.read(registerViewModelProvider.notifier);

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 24.h),

          // Header icon
          Center(
            child: Container(
              width: 80.r,
              height: 80.r,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  Assets.images.icons.addUser.path,
                  width: 36.r,
                  height: 36.r,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),

          // Title
          Text(
            'Create Account',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.lightOnSurface,
                ),
          ),
          SizedBox(height: 6.h),
          Text(
            'Fill in your details to get started',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.lightOnSurfaceMuted,
                ),
          ),
          SizedBox(height: 32.h),

          // Form fields
          RegisterFormField(
            label: 'Username',
            hint: 'Enter username',
            error: state.usernameError,
            onChanged: viewModel.setUsername,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.none,
            prefixIcon: 'assets/images/icons/Profile.svg',
          ),
          SizedBox(height: 14.h),
          RegisterFormField(
            label: 'Email',
            hint: 'Enter email',
            error: state.emailError,
            onChanged: viewModel.setEmail,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: 'assets/images/icons/Message.svg',
          ),
          SizedBox(height: 14.h),
          RegisterFormField(
            label: 'Password',
            hint: 'Enter password',
            error: state.passwordError,
            onChanged: viewModel.setPassword,
            obscureText: true,
            prefixIcon: 'assets/images/icons/Lock.svg',
          ),
          SizedBox(height: 14.h),
          RegisterFormField(
            label: 'Age',
            hint: 'Enter age (18-99)',
            error: state.ageError,
            onChanged: viewModel.setAge,
            keyboardType: TextInputType.number,
            prefixIcon: 'assets/images/icons/Calendar.svg',
          ),
          SizedBox(height: 32.h),

          // Register button
          SizedBox(
            height: 52.h,
            child: ElevatedButton(
              onPressed:
                  state.isFormValid && !state.isLoading ? onRegister : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                disabledBackgroundColor:
                    AppColors.primary.withValues(alpha: 0.4),
                foregroundColor: AppColors.white,
                disabledForegroundColor:
                    AppColors.white.withValues(alpha: 0.6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
                elevation: 0,
              ),
              child: state.isLoading
                  ? SizedBox(
                      height: 20.r,
                      width: 20.r,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.white,
                      ),
                    )
                  : Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
          SizedBox(height: 14.h),

          // Skip button
          TextButton(
            onPressed: state.isLoading ? null : onSkip,
            child: Text(
              'Skip',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.lightOnSurfaceMuted,
              ),
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
