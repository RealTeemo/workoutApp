import 'package:everyday_timer/features/cd_timer/presentation/pages/screen/chatGPT/chat_screen.dart';
import 'package:everyday_timer/features/cd_timer/presentation/pages/screen/main_screen.dart';
import 'package:flutter/material.dart';

class NavigationDrawers extends StatelessWidget {
  const NavigationDrawers({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ),
      );

  Widget buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      );
  Widget buildMenuItems(BuildContext context) => Wrap(
        runSpacing: 5,
        children: [
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text("Home"),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const MainScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.book_online_outlined),
            title: const Text("Chat Bot"),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const ChatScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.calendar_month_outlined),
            title: const Text("Notes"),
            onTap: (){},
          ),
        ],
      );
}
