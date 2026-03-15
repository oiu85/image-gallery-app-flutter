import 'package:flutter/material.dart';

class AppSnackBar {
  AppSnackBar._();

  static void showComingSoon(BuildContext context, {String feature = ''}) {
    final message = feature.isNotEmpty ? '$feature coming soon!' : 'Coming soon!';
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          duration: const Duration(seconds: 2),
        ),
      );
  }
}
