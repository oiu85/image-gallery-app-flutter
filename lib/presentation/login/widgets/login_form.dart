import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_colors.dart';
import '../../register/widgets/register_form_field.dart';
import '../viewmodel/login_view_model.dart';

/// Form widget for the login page.
class LoginForm extends ConsumerWidget {
  const LoginForm({
    super.key,
    required this.onLogin,
    required this.onBackToRegister,
  });

  final VoidCallback onLogin;
  final VoidCallback onBackToRegister;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginViewModelProvider);
    final viewModel = ref.read(loginViewModelProvider.notifier);

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 48.h),

          // Header icon
          Center(
            child: Container(
              width: 80.r,
              height: 80.r,
              decoration: const BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/icons/Login.svg',
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
            'Welcome Back',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.lightOnSurface,
                ),
          ),
          SizedBox(height: 6.h),
          Text(
            'Sign in to continue',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.lightOnSurfaceMuted,
                ),
          ),
          SizedBox(height: 40.h),

          // Email field
          RegisterFormField(
            label: 'Email',
            hint: 'Enter email',
            error: state.emailError,
            onChanged: viewModel.setEmail,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: 'assets/images/icons/Message.svg',
          ),
          SizedBox(height: 14.h),

          // Password field
          RegisterFormField(
            label: 'Password',
            hint: 'Enter password',
            error: state.passwordError,
            onChanged: viewModel.setPassword,
            obscureText: true,
            prefixIcon: 'assets/images/icons/Lock.svg',
          ),
          SizedBox(height: 36.h),

          // Login button
          SizedBox(
            height: 52.h,
            child: ElevatedButton(
              onPressed:
                  state.isFormValid && !state.isLoading ? onLogin : null,
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
                      'Login',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
          SizedBox(height: 20.h),

          // Back to register
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account? ",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.lightOnSurfaceMuted,
                ),
              ),
              GestureDetector(
                onTap: state.isLoading ? null : onBackToRegister,
                child: Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
