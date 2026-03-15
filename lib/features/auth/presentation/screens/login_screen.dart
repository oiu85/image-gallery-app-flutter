import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_routes.dart';
import '../viewmodels/login_viewmodel.dart';
import '../widgets/login_form.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<LoginFormState>(loginViewModelProvider, (prev, next) {
      if (next.isSuccess && !(prev?.isSuccess ?? false)) {
        context.go(AppRoutes.home);
      }
    });

    return Scaffold(
      body: SafeArea(
        child: LoginForm(
          onLogin: () {
            FocusScope.of(context).unfocus();
            ref.read(loginViewModelProvider.notifier).login();
          },
          onBackToRegister: () => context.go(AppRoutes.register),
        ),
      ),
    );
  }
}
