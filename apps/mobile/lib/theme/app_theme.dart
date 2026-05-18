import 'package:flutter/cupertino.dart';

class AppTheme {
  static const Color brandGreen = Color(0xFF07C160);
  static const Color pageBackground = Color(0xFFF2F2F7);
  static const Color surface = CupertinoColors.white;
  static const Color divider = Color(0xFFE5E5EA);
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color danger = Color(0xFFFF3B30);

  static CupertinoThemeData light() {
    return const CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: brandGreen,
      primaryContrastingColor: CupertinoColors.white,
      scaffoldBackgroundColor: pageBackground,
      barBackgroundColor: Color(0xCCF8F8F8),
      textTheme: CupertinoTextThemeData(
        textStyle: TextStyle(
          color: textPrimary,
          fontSize: 16,
          height: 1.4,
        ),
        navTitleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
        navLargeTitleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 34,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
