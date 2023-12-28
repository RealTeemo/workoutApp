import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 102, 6, 247),
  background: const Color.fromARGB(255, 186, 166, 209),
  primary: const Color(0xFFE7626C),
  tertiary: Colors.black54,
  secondary: const Color.fromRGBO(45, 45, 45, 1)
);

final theme = ThemeData().copyWith(
  useMaterial3: true,
  scaffoldBackgroundColor: colorScheme.background,
  colorScheme: colorScheme,
  textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
    titleSmall: GoogleFonts.ubuntuCondensed(
        fontWeight: FontWeight.bold, fontSize: 12),
    titleMedium: GoogleFonts.ubuntuCondensed(
        fontWeight: FontWeight.bold, fontSize: 20),
    titleLarge: GoogleFonts.ubuntuCondensed(
        fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 30),
  )
);

/*ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        secondaryHeaderColor: const Color(0xFF4CAF50),
        textTheme:
            const TextTheme(titleLarge: TextStyle(color: Color(0xFF232B55))),
        cardColor: const Color(0xFFF4EDDB),
      )*/