import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../gen/assets.gen.dart';
import 'app_form_field.dart';
import '../viewmodels/login_viewmodel.dart';

class LoginForm extends ConsumerWidget {
  const LoginForm({super.key, required this.onLogin, required this.onBackToRegister});

  final VoidCallback onLogin;
  final VoidCallback onBackToRegister;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginViewModelProvider);
    final viewModel = ref.read(loginViewModelProvider.notifier);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 48.h),

          Center(
            child: Container(
              width: 80.r,
              height: 80.r,
              decoration: BoxDecoration(color: colorScheme.primaryContainer, shape: BoxShape.circle),
              child: Center(
                child: SvgPicture.asset(
                  Assets.images.icons.login.path,
                  width: 36.r,
                  height: 36.r,
                  colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),

          Text(
            'Welcome Back',
            textAlign: TextAlign.center,
            style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 6.h),
          Text(
            'Sign in to continue',
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(color: colorScheme.outline),
          ),
          SizedBox(height: 40.h),

          AppFormField(
            label: 'Email',
            hint: 'Enter email',
            error: state.emailError,
            onChanged: viewModel.setEmail,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Assets.images.icons.message.path,
          ),
          SizedBox(height: 14.h),

          AppFormField(
            label: 'Password',
            hint: 'Enter password',
            error: state.passwordError,
            onChanged: viewModel.setPassword,
            obscureText: true,
            prefixIcon: Assets.images.icons.lock.path,
          ),
          SizedBox(height: 36.h),

          SizedBox(
            height: 52.h,
            child: ElevatedButton(
              onPressed: state.isFormValid && !state.isLoading ? onLogin : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                disabledBackgroundColor: colorScheme.primary.withValues(alpha: 0.4),
                foregroundColor: colorScheme.onPrimary,
                disabledForegroundColor: colorScheme.onPrimary.withValues(alpha: 0.6),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
                elevation: 0,
              ),
              child: state.isLoading
                  ? SizedBox(
                      height: 20.r,
                      width: 20.r,
                      child: CircularProgressIndicator(strokeWidth: 2, color: colorScheme.onPrimary),
                    )
                  : Text(
                      'Login',
                      style: textTheme.labelLarge?.copyWith(fontSize: 16.sp, color: colorScheme.onPrimary),
                    ),
            ),
          ),
          SizedBox(height: 20.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account? ", style: textTheme.bodyMedium?.copyWith(color: colorScheme.outline)),
              GestureDetector(
                onTap: state.isLoading ? null : onBackToRegister,
                child: Text(
                  'Register',
                  style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600, color: colorScheme.primary),
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
