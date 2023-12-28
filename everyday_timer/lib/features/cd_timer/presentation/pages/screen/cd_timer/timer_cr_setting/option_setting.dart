import 'package:everyday_timer/features/cd_timer/data/models/cd_timer.dart';
import 'package:everyday_timer/features/cd_timer/presentation/pages/screen/cd_timer/timer_cr_setting/ADVANCED_cr_setting.dart';
import 'package:everyday_timer/features/cd_timer/presentation/pages/screen/cd_timer/timer_cr_setting/AMRAP_cr_setting.dart';
import 'package:everyday_timer/features/cd_timer/presentation/pages/screen/cd_timer/timer_cr_setting/EMOM_cr_setting.dart';
import 'package:everyday_timer/features/cd_timer/presentation/pages/screen/cd_timer/timer_cr_setting/FORTIME_cr_setting.dart';
import 'package:everyday_timer/features/cd_timer/presentation/pages/screen/cd_timer/timer_cr_setting/SIMPLE_cr_setting.dart';
import 'package:everyday_timer/features/cd_timer/presentation/pages/screen/cd_timer/timer_cr_setting/TABTA_cr_setting.dart';
import 'package:everyday_timer/features/cd_timer/presentation/widgets/cd_timer/cd_timer_widget.dart';
import 'package:everyday_timer/test.dart';
import 'package:flutter/material.dart';

class OptionSettings extends StatelessWidget {
  OptionSettings({Key? key}) : super(key: key);
  int currentIndex = 0;

  Widget buildButton(BuildContext context, String text, route, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: 250, // Set the width of the button
        height: 60, // Set the height of the button
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => route));
          },
          style: ElevatedButton.styleFrom(backgroundColor: color),
          child: Text(text),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
              //content for tab1
              const CountdownTimerSetting(),
              //content for tab 2
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    buildButton(
                        context, "AMRAP", const AmrapSetting(), Colors.orange),
                    buildButton(context, "FOR TIME", const ForTimeSetting(),
                        Colors.blue.shade300),
                    buildButton(context, "TABATA", const TabataSetting(),
                        Colors.purple.shade400),
                    buildButton(context, "EMOM", const EmomSetting(),
                        Colors.lime.shade400),
                    buildButton(
                        context, "ADVANCED", const AdvancedSetting(), Colors.black38),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
