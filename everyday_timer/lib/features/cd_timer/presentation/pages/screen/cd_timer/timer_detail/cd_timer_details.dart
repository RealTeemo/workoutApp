import 'package:everyday_timer/features/cd_timer/data/models/cd_timer.dart';
import 'package:everyday_timer/features/cd_timer/presentation/widgets/timer_detail/timer_finished_screen.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'dart:async';
import 'dart:math';

class DetailScreen extends StatefulWidget {
  final CdTimer cdTimer;
  const DetailScreen({required this.cdTimer, super.key});

  @override
  State<DetailScreen> createState() => _detailScreen();
}

class _detailScreen extends State<DetailScreen> {
  int currentIndex = 0;
  late CdTimer timerInfo = widget.cdTimer;
  late String workoutName = widget.cdTimer.setsOfTimer[0].title;
  late Timer? timer;
  bool isRunning = false;
  late int tempSeconds = widget.cdTimer.setsOfTimer[0].time;
  int currentSets = 0;
  bool reset = false;

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          TimerFinishedScreen(
        timer: timerInfo,
      ), // DetailScreen(cdTimer: timer),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void onTick(Timer timer) {
    //update to next timer
    if (tempSeconds <= 0) {
      if (currentIndex+1 < timerInfo.setsOfTimer.length) {
        currentIndex++;
      } else {
        currentIndex = 0;
        reset = true;
      }
      if(currentSets<timerInfo.sets){
        tempSeconds = timerInfo.setsOfTimer[currentIndex].time;
        workoutName = timerInfo.setsOfTimer[currentIndex].title;
      }
    }

    //check if timer is completed
    if (currentSets + 1 > timerInfo.sets) {
      Navigator.of(context).push(_createRoute());
      setState(() {
        timer.cancel();
        isRunning = false;
      });
    } else {
      setState(() {
        tempSeconds--;
      });

      if (tempSeconds < 3) {}
    }

    // Update the sets if the timer has reset
    updateSetsIfResetting();
  }

  void updateSetsIfResetting() {
    if (reset) {
      if (currentSets < timerInfo.sets) {
        print("update sets called");
        currentSets++;
      }
      reset = false;
    }
  }

  void onNext() {
    setState(() {
      if (currentIndex < widget.cdTimer.setsOfTimer.length + 1) {
        currentIndex++;
      }
    });
  }

  void onPrev() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
      }
    });
  }

  void onResetPressed() {
    print(currentIndex);
    setState(() {
      
      tempSeconds = timerInfo.setsOfTimer[currentIndex-1].time;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    var dispTime = duration.toString().split(".").first.substring(2, 7);
    return dispTime;
  }

  void onPausePressed() {
    timer?.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onStartPressed() {
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
    setState(() {
      isRunning = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          timerInfo.title,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.background),
        ),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              if(isRunning){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Stop the workout?"),
                      content:
                          const Text("Do you really want to quit the workout"),
                      actions: <Widget>[
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("CANCEL")),
                        TextButton(
                            onPressed: () {
                             Navigator.of(context).pop();
                             Navigator.of(context).pop();
                            },
                            child: const Text("OK"))
                      ],
                    );
                  });
              }else{
                Navigator.pop(context);
              }
            }),
      ),
      body: Column(
        children: [
          //title
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                workoutName,
                style: TextStyle(
                  fontSize: 80,
                  color: Theme.of(context).cardColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          //time
          Flexible(
            flex: 1,
            child: Center(
              child: Column(
                children: [
                  Text(
                    format(tempSeconds),
                    style: TextStyle(
                      color: Theme.of(context).cardColor,
                      fontSize: 80,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // LinearPercentIndicator(
                  //   animation: true,
                  //   lineHeight: 20,
                  // )
                ],
              ),
            ),
          ),
          //buttons
          ButtonDisplay(context),
          // num of sets display
          setsDisplay(context, currentSets, timerInfo.sets)
        ],
      ),
    );
  }

  Widget ButtonDisplay(context) => Flexible(
        flex: 3,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                color: Theme.of(context).cardColor,
                iconSize: 120,
                onPressed: isRunning ? onPausePressed : onStartPressed,
                icon: Icon(isRunning
                    ? Icons.pause_circle_outline
                    : Icons.play_circle_outline_outlined),
              ),
              IconButton(
                color: Theme.of(context).cardColor,
                iconSize: 120,
                onPressed: onResetPressed,
                icon: const Icon(Icons.stop_circle_outlined),
              ),
            ],
          ),
        ),
      );
}

Widget setsDisplay(context, int currentSets, int totalSets) => Flexible(
      flex: 1,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: Theme.of(context).cardColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Sets",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.tertiary)),
                      Text(
                        "${currentSets + 1}/$totalSets",
                        style: TextStyle(
                            fontSize: 20,
                            color:
                                Theme.of(context).textTheme.titleLarge!.color),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
