import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  static final darkTheme = ThemeData(
    textTheme: TextTheme(
        titleLarge: GoogleFonts.notoSansArabic(
            color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
        bodySmall:
            GoogleFonts.notoSansArabic(color: Colors.white, fontSize: 15),
        labelSmall:
            GoogleFonts.notoSansArabic(color: Colors.white54, fontSize: 13),
        titleSmall:
            GoogleFonts.notoSansArabic(color: Colors.black, fontSize: 12)),
    appBarTheme: AppBarTheme(
        color: Colors.blue.shade900,
        foregroundColor: Colors.white,
        centerTitle: true,
        actionsIconTheme: const IconThemeData(color: Colors.amber)),
    unselectedWidgetColor: Colors.white70,
    primaryColorLight: Colors.black,
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.blue.shade900,
    secondaryHeaderColor: Colors.white,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  );

  static final lightTheme = ThemeData(
    textTheme: TextTheme(
        titleLarge: GoogleFonts.notoSansArabic(
            color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        bodySmall:
            GoogleFonts.notoSansArabic(color: Colors.black, fontSize: 15),
        labelSmall:
            GoogleFonts.notoSansArabic(color: Colors.black38, fontSize: 13),
        titleSmall:
            GoogleFonts.notoSansArabic(color: Colors.black, fontSize: 12)),
    appBarTheme: AppBarTheme(
        color: Colors.blueAccent.shade700,
        foregroundColor: Colors.white,
        centerTitle: true,
        actionsIconTheme: const IconThemeData(color: Colors.amber)),
    unselectedWidgetColor: Colors.black,
    primaryColorLight: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.blueAccent.shade700,
    secondaryHeaderColor: Colors.black,
    iconTheme: const IconThemeData(color: Colors.white),
  );
}
