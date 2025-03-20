import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../consttants/constants.dart';

class AppThemes {
  static final light = ThemeData(
    brightness: Brightness.light,
    // primarySwatch: Colors.blue,
    primaryColor: ConstColors.orange,
    primaryColorDark: ConstColors.black,
    scaffoldBackgroundColor: ConstColors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: ConstColors.orange,
      centerTitle: true,
      foregroundColor: Colors.black,
      titleTextStyle: GoogleFonts.cairo(
        fontWeight: FontWeight.bold,
        fontSize: 24,
        color: ConstColors.white,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ConstColors.orange,
    ),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.telex(color: Colors.black),
      bodyMedium: GoogleFonts.telex(color: Colors.black),
    ),
    inputDecorationTheme: InputDecorationTheme(
      // focusColor: ConstColors.orange,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ConstColors.black),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ConstColors.orange),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ConstColors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ConstColors.red),
      ),
    ),
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    // primarySwatch: Colors.blue,
    primaryColor: ConstColors.background_2,
    primaryColorDark: ConstColors.white,
    scaffoldBackgroundColor: ConstColors.background,
    appBarTheme: AppBarTheme(
      backgroundColor: ConstColors.background_2,
      centerTitle: true,
      foregroundColor: Colors.white,
      titleTextStyle: GoogleFonts.cairo(
        fontWeight: FontWeight.bold,
        fontSize: 24,
        color: ConstColors.white,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ConstColors.background_2,
    ),

    textTheme: TextTheme(
      bodyLarge: GoogleFonts.telex(color: Colors.white),
      bodyMedium: GoogleFonts.telex(color: Colors.white),
    ),

    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ConstColors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ConstColors.orange),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ConstColors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ConstColors.red),
      ),
    ),
  );
}
