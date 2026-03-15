import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routing/app_routes.dart';
import '../viewmodel/login_view_model.dart';
import '../widgets/login_form.dart';

/// Login page with email + password and navigation back to register.
class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: LoginForm(
          onLogin: () => _handleLogin(context, ref),
          onBackToRegister: () => context.go(AppRoutes.register),
        ),
      ),
    );
  }

  Future<void> _handleLogin(BuildContext context, WidgetRef ref) async {
    FocusScope.of(context).unfocus();
    final viewModel = ref.read(loginViewModelProvider.notifier);
    final success = await viewModel.login();
    if (success && context.mounted) {
      context.go(AppRoutes.home);
    }
  }
}
