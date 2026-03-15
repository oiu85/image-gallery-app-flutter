import 'package:flutter/material.dart';


class AppColors {

  AppColors._();

  //* ==================== Common Colors ====================

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);

  //* ==================== Brand Palette ====================
  //? Primary: main accent, buttons, active states (#6366F1 — Indigo)
  static const Color primary = Color(0xFF6366F1);
  //? Secondary: supporting accent, links, info (#06B6D4 — Cyan)
  static const Color secondary = Color(0xFF06B6D4);
  //? Accent: highlights, badges, CTAs (#F59E0B — Amber)
  static const Color accent = Color(0xFFF59E0B);
  //? Primary dark: hover/active, text on light primary surfaces (#4F46E5)
  static const Color primaryDark = Color(0xFF4F46E5);
  //? Deep indigo: overlays, dark backgrounds (#312E81)
  static const Color primaryDeep = Color(0xFF312E81);
  //? Primary shadow tint
  static const Color primaryShadow = Color(0x666366F1);
  //? Gradient start/mid for primary gradients
  static const Color primaryGradientStart = Color(0xFF4F46E5);
  static const Color primaryGradientMid = Color(0xFF6366F1);
  //? Light indigo tint — secondary buttons, tinted surfaces (#E0E7FF)
  static const Color primaryLight = Color(0xFFE0E7FF);
  //? Foreground on primaryLight — text, icons (#312E81)
  static const Color onPrimaryLight = Color(0xFF312E81);

  //* ==================== Light Theme — Surfaces & Background ====================
  //? Page background (#F8FAFC — Slate)
  static const Color lightBackground = Color(0xFFF8FAFC);
  //? Elevated surfaces — cards, badges (#F1F5F9)
  static const Color lightSurfaceVariant = Color(0xFFF1F5F9);
  //? Card/list surface (#FFFFFF)
  static const Color lightSurface = Color(0xFFFFFFFF);
  //? Pure surface for dialogs/sheets
  static const Color lightSurfacePure = Color(0xFFFFFFFF);

  //* ==================== Light Theme — Text ====================
  //? Headings, primary text (#0F172A)
  static const Color lightOnSurface = Color(0xFF0F172A);
  //? Secondary/muted text (#64748B)
  static const Color lightOnSurfaceMuted = Color(0xFF64748B);
  //? Form hint/placeholder text
  static const Color formHint = Color(0xFF64748B);
  //? Softer validation error for form fields (lighter than lightError)
  static const Color validationErrorLight = Color.fromARGB(255, 220, 121, 124);

  //* ==================== Light Theme — Borders & Dividers ====================
  //? Card border (#E2E8F0)
  static const Color lightBorder = Color(0xFFE2E8F0);
  //? Subtle border (#E2E8F0)
  static const Color lightBorderSubtle = Color(0xFFE2E8F0);
  //? Dashed border for selection boxes, upload areas (design: #AAAAAA)
  static const Color dashedBorder = Color(0xFFAAAAAA);

  //* ==================== Light Theme — Error ====================
  static const Color lightError = Color(0xFFB00020);
  static const Color lightOnError = Color(0xFFFFFFFF);

  //* ==================== Light Theme — Shadow & Scrim ====================
  static const Color lightShadow = Color(0x0D000000);
  static const Color lightScrim = Color(0x66000000);

  //* ==================== Dark Theme ====================
  static const Color darkError = Color(0xFFEF5350);
  static const Color darkOnError = Color(0xFFFFFFFF);
  static const Color darkSurfacePanel = Color(0xFF1C1B1F);
  static const Color darkBackground = Color(0xFF0D0A10);
  static const Color darkSurface = Color(0xFF1A1620);
  static const Color darkSurfaceVariant = Color(0xFF252030);
  static const Color darkOnSurface = Color(0xFFE8E4EC);
  static const Color darkOnSurfaceMuted = Color(0xFF9E98A8);
  static const Color darkBorder = Color(0xFF2E2A38);
  static const Color darkBorderSubtle = Color(0xFF3A3545);
  static const Color darkFormFieldBackground = Color(0xFF1F1B28);
  static const Color darkSurfaceCard = Color(0xFF221E2A);
  static const Color darkLevelCardSurface = Color(0xFF1E1A26);
  static const Color darkLevelCardDivider = Color(0xFF2A2635);
  static const Color darkSurfaceSection = Color(0xFF16131C);
  static const Color darkStatusChipActivatedBg = Color(0xFF1A3D28);
  static const Color darkStatusChipActivatedText = Color(0xFF4ADE80);
  static const Color darkStatusChipNeutralBg = Color(0xFF2E2D35);
  static const Color darkStatusChipNeutralText = Color(0xFF94A3B8);
  static const Color darkShadow = Color(0x88000000);
  static const Color darkScrim = Color(0x99000000);


  //* ==================== Grey Scale ====================
  static const Color greyLight = Color(0xFFEBE8EB);
  static const Color greyLightHover = Color(0xFFE1E1E1);
  static const Color greyLightActive = Color(0xFFC0C0C0);
  static const Color greyNormal = Color(0xFF353535);
  static const Color greyNormalHover = Color(0xFF303030);
  static const Color greyNormalActive = Color(0xFF2A2A2A);
  static const Color greyDark = Color(0xFF282828);
  static const Color greyDarkHover = Color(0xFF202020);
  static const Color greyDarkActive = Color(0xFF181818);
  static const Color greyDarker = Color(0xFF131313);

  //* ==================== Component & Semantic ====================
  //? Input/card fill
  static const Color componentsBackground = Color(0xFFF1F5F9);
  //? Form field fill
  static const Color formFieldBackground = Color(0xFFF8FAFC);
  static const Color borderColor = Color(0xFFE2E8F0);

  //* ==================== Status Colors ====================
  static const Color successGreen = Color(0xFF26D368);
  static const Color successGreenLight = Color(0xFFE8F8EE);
  static const Color warningAmber = Color(0xFFB3A41D);
  static const Color warningAmberLight = Color(0xFFFDF8E8);
  //? Optional semantic set (Figma / design-system)
  static const Color statusPending = Color(0xFFFFC107);
  static const Color statusActive = Color(0xFF4CAF50);
  static const Color statusDenied = Color(0xFFF44336);

  //* ==================== Reusable palette (chips, cards, sections) ====================
  //? Medium blue — e.g. pending chip bg, primary blue surfaces
  static const Color blueMedium = Color(0xFF2196F3);
  //? Light blue — e.g. text on blueMedium
  static const Color blueLight = Color(0xFFBBDEFB);
  //? Light green — e.g. success/sent chip bg, green surfaces
  static const Color greenLight = Color(0xFFE8F5E9);
  //? Dark green — e.g. text on greenLight
  static const Color greenDark = Color(0xFF2E7D32);
  //* Status chip — Activated (user/card status, Figma)
  //? Light green bg for "Activated" chip (#E0F4E8)
  static const Color statusChipActivatedBg = Color(0xFFE0F4E8);
  //? Dark green text on Activated chip (#1C8E5E)
  static const Color statusChipActivatedText = Color(0xFF1C8E5E);
  //* Status chip — Not Activated (neutral, Figma)
  //? Light grey bg for "Not Activated" chip (#E7E9ED)
  static const Color statusChipNeutralBg = Color(0xFFE7E9ED);
  //? Slate text on Not Activated chip (#617289)
  static const Color statusChipNeutralText = Color(0xFF617289);
  //? Muted surface — e.g. cards, list items
  static const Color surfaceCard = Color(0xFFF1F5F9);
  //? Level card surface
  static const Color levelCardSurface = Color(0xFFFFFFFF);
  //? Level card divider
  static const Color levelCardDivider = Color(0xFFE2E8F0);
  //? Subtle border — e.g. card borders (#F1F5F9)
  static const Color borderSubtle = Color(0xFFF1F5F9);
  //? Section surface — e.g. form sections, grouped blocks (#F9F7FB)
  static const Color surfaceSection = Color(0xFFF9F7FB);
  //? Field surface — e.g. input fill, white panels (#FFFFFF)
  static const Color surfaceField = Color(0xFFFFFFFF);
  //? Danger action — e.g. disable, remove, destructive outline/icon/text (#EF4444)
  static const Color actionDanger = Color(0xFFEF4444);
  //? Success action — e.g. enable, confirm, positive outline/icon/text (#10B981)
  static const Color actionSuccess = Color(0xFF10B981);

  //* ==================== Bottom Nav Bar ====================
  static const Color bottomNavBarInactive = Color(0xFF94A3B8);
}
