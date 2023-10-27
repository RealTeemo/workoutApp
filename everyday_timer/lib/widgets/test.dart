import 'package:everyday_timer/model/cd_timer.dart';
import 'package:everyday_timer/screens/screen/cd_timer/timer_cr_setting/option_setting.dart';
import 'package:flutter/material.dart';
import 'package:everyday_timer/screens/screen/cd_timer/timer_cr_setting/SIMPLE_cr_setting.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  void onAddList(CdTimer cdTimer){
    print("hi");
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2, // Change this to the number of buttons you want
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Timer Creations'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'SIMPLE'),
                Tab(text: 'MORE OPTIONS'),
                // Add more Tab widgets for additional buttons
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // Add the content for Tab 1
              const CountdownTimerSetting(),
              // Add the content for Tab 2
              OptionSettings(),
              // Add the content for Tab 3
            ],
          ),
        ),
      ),
    );
  }
}
