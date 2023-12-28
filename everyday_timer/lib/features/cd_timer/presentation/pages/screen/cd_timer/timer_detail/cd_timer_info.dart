import 'package:everyday_timer/main.dart';
import 'package:everyday_timer/features/cd_timer/data/models/cd_timer.dart';
import 'package:everyday_timer/features/cd_timer/presentation/pages/screen/cd_timer/timer_detail/cd_timer_details.dart';
import 'package:everyday_timer/features/cd_timer/presentation/widgets/timer_detail/timer_finished_screen.dart';
import 'package:flutter/material.dart';

class TimerInfoScreen extends StatelessWidget {
  TimerInfoScreen({super.key, required this.timer});
  CdTimer timer;
  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    var dispTime = duration.toString().split(".").first.substring(2, 7);
    return dispTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: timerTitle(context, timer.title),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
             Flexible(
            flex: 8,
            child: Card(
              child: workoutName(context),
            ),
          ),
          Flexible(
            flex: 2,
            child: Card(
              child: infoSection(context, timer.time, timer.sets),
            ),
          ),
          ],
        ),
      ),
    );
  }

  //display number of sets and total workout time & start button
  Widget infoSection(BuildContext context, int totalTime, int sets) => Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Total Time: ${format(totalTime)}",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.background),
                ),
                Text(
                  "Sets: $sets",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.background),
                )
              ],
            ),
            const Spacer(),
            FilledButton(
              onPressed: () {
                Navigator.of(context).push(_createRoute());
              },
              style: FilledButton.styleFrom(
                  fixedSize: Size.fromWidth(MediaQuery.sizeOf(context).width)),
              child: Text(
                "Start",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(),
              ),
            ),
          ],
        ),
      );

  //route to detail screen
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => DetailScreen(cdTimer: timer),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }

  //display title
  Widget timerTitle(BuildContext context, String title) => Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Theme.of(context).colorScheme.background),
      );

  //display contents of workout
  Widget workoutName(BuildContext context) => ListView.builder(
      itemCount: timer.setsOfTimer.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            timer.setsOfTimer[index].title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.background),
          ),
          subtitle: Text(
            format(timer.setsOfTimer[index].time),
            style: Theme.of(context).textTheme.titleMedium!.copyWith(),
          ),
          trailing:
              categoryIcons(timer.setsOfTimer[index].type.toString()),
          leading: Text(
            '${index + 1}',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(),
          ),
        );
      });
}

 //display icons for content of workout
  Widget categoryIcons(String type) {
    switch (type) {
      case 'WorkType.work':
        return const Icon(Icons.fitness_center);
      case 'WorkType.rest':
        return const Icon(Icons.local_drink_outlined);
      default:
        return const Icon(Icons.add);
    }
  }