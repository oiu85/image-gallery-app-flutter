import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../shared/widgets/app_snackbar.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LoginForm(
          onLogin: () {
            FocusScope.of(context).unfocus();
            AppSnackBar.showComingSoon(context, feature: 'Login');
          },
          onBackToRegister: () => context.go(AppRoutes.register),
        ),
      ),
    );
  }
}
