import 'package:everyday_timer/main.dart';
import 'package:everyday_timer/features/cd_timer/presentation/widgets/drawer/navigation_drawer.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawers(),
      appBar: AppBar(
        title: const Text("Help Bot"),
      ),
    );
  }
}