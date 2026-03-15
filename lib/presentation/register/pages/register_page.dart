import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routing/app_routes.dart';
import '../viewmodel/register_view_model.dart';
import '../widgets/register_form.dart';

/// Register page with form validation and mock register flow.
class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: RegisterForm(
          onRegister: () => _handleRegister(context, ref),
          onSkip: () => context.go(AppRoutes.login),
        ),
      ),
    );
  }

  Future<void> _handleRegister(BuildContext context, WidgetRef ref) async {
    FocusScope.of(context).unfocus();
    final viewModel = ref.read(registerViewModelProvider.notifier);
    final success = await viewModel.register();
    if (success && context.mounted) {
      context.go(AppRoutes.home);
    }
  }
}
