import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_routes.dart';
import '../viewmodels/register_viewmodel.dart';
import '../widgets/register_form.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<RegisterFormState>(registerViewModelProvider, (prev, next) {
      if (next.isSuccess && !(prev?.isSuccess ?? false)) {
        context.go(AppRoutes.home);
      }
    });

    return Scaffold(
      body: SafeArea(
        child: RegisterForm(
          onRegister: () {
            FocusScope.of(context).unfocus();
            ref.read(registerViewModelProvider.notifier).register();
          },
          onSkip: () => context.go(AppRoutes.login),
        ),
      ),
    );
  }
}
