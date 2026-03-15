import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class Env {
  static String get pixabayKey => dotenv.env['PIXABAY_KEY'] ?? '';

  static bool get hasPixabayKey => pixabayKey.isNotEmpty;
}
