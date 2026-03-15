abstract class AppRoutes {
  static const String splash = '/';
  static const String register = '/auth/register';
  static const String signup = '/auth/signup';
  static const String login = '/auth/login';
  static const String checkEmail = '/auth/check-email';
  static const String verifyOtp = '/auth/verify-otp';
  static const String resetPassword = '/auth/reset-password';
  static const String home = '/home';
  static const String imageDetail = '/home/image-detail';
  /// Full path for Add Level; nested under [codesMain] so push/pop works correctly.
  static const String addLevel = '/codes/levels/add';

  /// Path for Level Lessons; nested under [codesMain]. Use [levelLessonsPath].
  static const String levelLessons = '/codes/levels/lessons';

  /// Full path for a level's lessons list. Pass [levelId] from [LevelMockItem.id].
  static String levelLessonsPath(String levelId) => '$levelLessons/$levelId';

  /// Path for Add Lesson; nested under [codesMain]. Use [addLessonPath].
  static const String addLesson = '/codes/levels/lessons/add';

  /// Full path for adding a lesson to a level. Pass [levelId] from [LevelMockItem.id].
  static String addLessonPath(String levelId) => '$addLesson/$levelId';
}

