import 'package:everyday_timer/features/cd_timer/data/models/cd_timer.dart';
import 'package:everyday_timer/features/cd_timer/presentation/pages/screen/cd_timer/timer_detail/cd_timer_details.dart';
import 'package:flutter/material.dart';

class TimerFinishedScreen extends StatelessWidget {
  TimerFinishedScreen({super.key, required this.timer});
  CdTimer timer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(timer.title,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Theme.of(context).colorScheme.background),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "Finished",
                style: TextStyle(
                  fontSize: 80,
                  color: Theme.of(context).cardColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: TextButton.styleFrom(),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: const Text("Restart")),
                  ElevatedButton(
                      style: TextButton.styleFrom(),
                      onPressed: () {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                      child: const Text("Exit"))
                ],
              )),
        ],
      ),
    );
  }
}
