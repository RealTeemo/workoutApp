import 'package:everyday_timer/config/theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:everyday_timer/features/cd_timer/presentation/pages/screen/main_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {

  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const Scaffold(
        body: MainScreen(),
      ),
    );
  }
}
