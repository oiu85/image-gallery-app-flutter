import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_image_gallery_app/gen/assets.gen.dart';

import 'app_form_field.dart';
import '../viewmodels/register_viewmodel.dart';

class RegisterForm extends ConsumerWidget {
  const RegisterForm({super.key, required this.onRegister, required this.onSkip});

  final VoidCallback onRegister;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registerViewModelProvider);
    final viewModel = ref.read(registerViewModelProvider.notifier);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 24.h),

          Center(
            child: Container(
              width: 80.r,
              height: 80.r,
              decoration: BoxDecoration(color: colorScheme.primaryContainer, shape: BoxShape.circle),
              child: Center(
                child: SvgPicture.asset(
                  Assets.images.icons.addUser.path,
                  width: 36.r,
                  height: 36.r,
                  colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),

          Text(
            'Create Account',
            textAlign: TextAlign.center,
            style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 6.h),
          Text(
            'Fill in your details to get started',
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(color: colorScheme.outline),
          ),
          SizedBox(height: 32.h),

          AutofillGroup(
            child: Column(
              children: [
                AppFormField(
                  label: 'Username',
                  hint: 'Enter username',
                  error: state.usernameError,
                  onChanged: viewModel.setUsername,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.none,
                  autofillHints: const [AutofillHints.username],
                  prefixIcon: Assets.images.icons.profile.path,
                ),
                SizedBox(height: 14.h),
                AppFormField(
                  label: 'Email',
                  hint: 'Enter email',
                  error: state.emailError,
                  onChanged: viewModel.setEmail,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  prefixIcon: Assets.images.icons.message.path,
                ),
                SizedBox(height: 14.h),
                AppFormField(
                  label: 'Password',
                  hint: 'Enter password',
                  error: state.passwordError,
                  onChanged: viewModel.setPassword,
                  obscureText: true,
                  autofillHints: const [AutofillHints.newPassword],
                  prefixIcon: Assets.images.icons.lock.path,
                ),
                SizedBox(height: 14.h),
                AppFormField(
                  label: 'Age',
                  hint: 'Enter age (18-99)',
                  error: state.ageError,
                  onChanged: viewModel.setAge,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  prefixIcon: Assets.images.icons.calendar.path,
                ),
              ],
            ),
          ),
          SizedBox(height: 32.h),

          SizedBox(
            height: 52.h,
            child: ElevatedButton(
              onPressed: state.isFormValid && !state.isLoading ? onRegister : null,
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
                      'Register',
                      style: textTheme.labelLarge?.copyWith(fontSize: 16.sp, color: colorScheme.onPrimary),
                    ),
            ),
          ),
          SizedBox(height: 14.h),

          TextButton(
            onPressed: state.isLoading ? null : onSkip,
            child: Text(
              'Skip',
              style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500, color: colorScheme.outline),
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
