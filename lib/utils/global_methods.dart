import 'package:flutter/material.dart';

class GlobalMethodes {
  static Size getScreenSize(BuildContext context) =>
      MediaQuery.of(context).size;
  static ThemeData getThemeData() => ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFF4E4FF),
            primary: const Color(0Xff4B0082),
            secondary: const Color(0XffDAA520),
            background: const Color(0XffF7F9F8),
            tertiary: const Color(0xff8FBC8F)),
        useMaterial3: true,
      );
}
