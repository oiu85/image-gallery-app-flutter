import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../gen/fonts.gen.dart';
import 'app_colors.dart';

//* Light theme for the app

ThemeData appTheme(BuildContext context) {
  final fontFamily = FontFamily.cairo;
  return ThemeData(
    useMaterial3: true,
    fontFamily: fontFamily,
    brightness: Brightness.light,
    
    //* Color Scheme (Light) — Indigo / Cyan / Amber palette
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      tertiary: AppColors.accent,
      surface: AppColors.lightSurface,
      surfaceContainerHighest: AppColors.lightSurfaceVariant,
      background: AppColors.lightBackground,
      onPrimary: AppColors.white,
      onSecondary: AppColors.white,
      onSurface: AppColors.lightOnSurface,
      onBackground: AppColors.lightOnSurface,
      error: AppColors.lightError,
      onError: AppColors.lightOnError,
      surfaceVariant: AppColors.lightSurfaceVariant,
      outline: AppColors.lightOnSurfaceMuted,
      primaryContainer: AppColors.primaryLight,
      onPrimaryContainer: AppColors.primaryDark,
    ),
    scaffoldBackgroundColor: AppColors.lightBackground,
    

    //* Text Theme (Light) — onSurface / muted from Figma
    textTheme: TextTheme(
      displayLarge: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold, fontFamily: fontFamily, color: AppColors.lightOnSurface),
      displayMedium: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w600, fontFamily: fontFamily, color: AppColors.lightOnSurface),
      displaySmall: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500, fontFamily: fontFamily, color: AppColors.lightOnSurface),
      headlineMedium: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600, fontFamily: fontFamily, color: AppColors.lightOnSurface),
      headlineSmall: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, fontFamily: fontFamily, color: AppColors.lightOnSurface),
      titleLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, fontFamily: fontFamily, color: AppColors.lightOnSurface),
      titleMedium: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, fontFamily: fontFamily, color: AppColors.lightOnSurface),
      titleSmall: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700, fontFamily: fontFamily, color: AppColors.lightOnSurface),
      bodyLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, fontFamily: fontFamily, color: AppColors.lightOnSurface),
      bodyMedium: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, fontFamily: fontFamily, color: AppColors.lightOnSurface),
      bodySmall: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w300, fontFamily: fontFamily, color: AppColors.lightOnSurfaceMuted),
      labelLarge: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, fontFamily: fontFamily, color: AppColors.lightOnSurface),
      labelSmall: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400, fontFamily: fontFamily, color: AppColors.lightOnSurfaceMuted),
    ).apply(fontSizeFactor: 1),
    
    //* Button Theme (Light) — KBCL primary accent
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),
        textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, fontFamily: fontFamily),
        elevation: 0,
      ),
    ),
    //* Filled Button Theme (Light) — primaryLight / onPrimaryLight
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: AppColors.onPrimaryLight,
        side: const BorderSide(color: AppColors.lightBorderSubtle),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        padding: EdgeInsets.all(20.r),
        minimumSize: Size(0, 52.h),
        textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, fontFamily: fontFamily, height: 1.5),
        elevation: 0,
      ),
    ),
    
    //* AppBar Theme (Light) — KBCL onSurface for title
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.lightSurface,
      foregroundColor: AppColors.lightOnSurface,
      surfaceTintColor: AppColors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.lightOnSurface,
      ),
    ),
    
    //* Card Theme (Light) — KBCL surface
    cardTheme: CardThemeData(
      color: AppColors.lightSurface,
      shadowColor: AppColors.lightShadow,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
    ),
    
    //* Input Decoration Theme (Light) — KBCL fill & focus
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightSurfaceVariant,
      contentPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11.r),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11.r),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11.r),
        borderSide: BorderSide(color: AppColors.primary, width: 1.w),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11.r),
        borderSide: BorderSide(color: AppColors.lightError, width: 1.w),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11.r),
        borderSide: BorderSide(color: AppColors.lightError, width: 1.w),
      ),
      hintStyle: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
        color: AppColors.lightOnSurfaceMuted,
      ),
      labelStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
        color: AppColors.lightOnSurface,
      ),
    ),
  );
}

ThemeData appDarkTheme(BuildContext context) {
  final fontFamily = FontFamily.cairo;
  return ThemeData(
    useMaterial3: true,
    fontFamily: fontFamily,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      tertiary: AppColors.accent,
      surface: AppColors.darkSurface,
      surfaceContainerHighest: AppColors.darkSurfaceVariant,
      background: AppColors.darkBackground,
      onPrimary: AppColors.white,
      onSecondary: AppColors.white,
      onSurface: AppColors.darkOnSurface,
      onBackground: AppColors.darkOnSurface,
      error: AppColors.darkError,
      onError: AppColors.darkOnError,
      surfaceVariant: AppColors.darkSurfaceVariant,
      outline: AppColors.darkOnSurfaceMuted,
      primaryContainer: AppColors.darkSurfaceVariant,
      onPrimaryContainer: AppColors.darkOnSurface,
    ),
    scaffoldBackgroundColor: AppColors.darkBackground,
    textTheme: TextTheme(
      displayLarge: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold, fontFamily: fontFamily, color: AppColors.darkOnSurface),
      displayMedium: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w600, fontFamily: fontFamily, color: AppColors.darkOnSurface),
      displaySmall: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500, fontFamily: fontFamily, color: AppColors.darkOnSurface),
      headlineMedium: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600, fontFamily: fontFamily, color: AppColors.darkOnSurface),
      headlineSmall: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, fontFamily: fontFamily, color: AppColors.darkOnSurface),
      titleLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, fontFamily: fontFamily, color: AppColors.darkOnSurface),
      titleMedium: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, fontFamily: fontFamily, color: AppColors.darkOnSurface),
      titleSmall: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700, fontFamily: fontFamily, color: AppColors.darkOnSurface),
      bodyLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, fontFamily: fontFamily, color: AppColors.darkOnSurface),
      bodyMedium: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, fontFamily: fontFamily, color: AppColors.darkOnSurface),
      bodySmall: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w300, fontFamily: fontFamily, color: AppColors.darkOnSurfaceMuted),
      labelLarge: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, fontFamily: fontFamily, color: AppColors.darkOnSurface),
      labelSmall: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400, fontFamily: fontFamily, color: AppColors.darkOnSurfaceMuted),
    ).apply(fontSizeFactor: 1),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),
        textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, fontFamily: fontFamily),
        elevation: 0,
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: AppColors.onPrimaryLight,
        side: const BorderSide(color: AppColors.darkBorderSubtle),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        padding: EdgeInsets.all(20.r),
        minimumSize: Size(0, 52.h),
        textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, fontFamily: fontFamily, height: 1.5),
        elevation: 0,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkSurface,
      foregroundColor: AppColors.darkOnSurface,
      surfaceTintColor: AppColors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.darkOnSurface,
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.darkSurfaceCard,
      shadowColor: AppColors.darkShadow,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkFormFieldBackground,
      contentPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11.r),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11.r),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11.r),
        borderSide: BorderSide(color: AppColors.primary, width: 1.w),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11.r),
        borderSide: BorderSide(color: AppColors.darkError, width: 1.w),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11.r),
        borderSide: BorderSide(color: AppColors.darkError, width: 1.w),
      ),
      hintStyle: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
        color: AppColors.darkOnSurfaceMuted,
      ),
      labelStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
        color: AppColors.darkOnSurface,
      ),
    ),
  );
}
