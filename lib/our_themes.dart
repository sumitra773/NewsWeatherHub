import 'package:flutter/material.dart';
import 'const/colors.dart';

class CustomThemes {
  static final lightTheme = ThemeData(
    cardColor: Colors.white,
    fontFamily: "poppins",
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Color(0xFF1f2937),
    iconTheme: const IconThemeData(
      color: Color(0xFF4b5563),
    ),
  );
  static final DarkTheme = ThemeData(
    cardColor: bgColor.withOpacity(0.6),
    fontFamily: "poppins",
    scaffoldBackgroundColor: bgColor,
    primaryColor: Colors.white,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  );
}
