import 'package:everyday_timer/model/cd_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:everyday_timer/screens/screen/cd_timer/cd_timer_list.dart';
import 'package:everyday_timer/screens/screen/cd_timer/timer_cr_setting/ADVANCED_cr_setting.dart';
import 'package:everyday_timer/screens/screen/cd_timer/timer_cr_setting/AMRAP_cr_setting.dart';
import 'package:everyday_timer/screens/screen/cd_timer/timer_cr_setting/EMOM_cr_setting.dart';
import 'package:everyday_timer/screens/screen/cd_timer/timer_cr_setting/FORTIME_cr_setting.dart';
import 'package:everyday_timer/screens/screen/cd_timer/timer_cr_setting/SIMPLE_cr_setting.dart';
import 'package:everyday_timer/screens/screen/cd_timer/timer_cr_setting/TABTA_cr_setting.dart';
import 'package:everyday_timer/screens/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

final colorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 102, 6, 247),
    background: const Color.fromARGB(255, 186, 166, 209),
    primary: const Color(0xFFE7626C),
    
    );

final theme = ThemeData().copyWith(
    useMaterial3: true,
    scaffoldBackgroundColor: colorScheme.background,
    colorScheme: colorScheme,
    textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
      titleSmall: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold,),
      titleMedium: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold),
      titleLarge: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold),
      
    ));

class App extends StatelessWidget {
  void onAddList(CdTimer cdTimer) {}

  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme /*ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        secondaryHeaderColor: const Color(0xFF4CAF50),
        textTheme:
            const TextTheme(titleLarge: TextStyle(color: Color(0xFF232B55))),
        cardColor: const Color(0xFFF4EDDB),
      )*/,
      home: const Scaffold(
        // body: MainScreen(),
        body: HomeScreen(),
        // body: EmomSetting(),
        // body: TabataSetting(),
        // body: AdvancedSetting(),
      ),
    );
  }
}
