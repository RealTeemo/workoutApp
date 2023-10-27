import 'package:everyday_timer/model/cd_timer.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class DetailScreen extends StatefulWidget {
  final CdTimer cdTimer;
  const DetailScreen({required this.cdTimer, super.key});

  @override
  State<DetailScreen> createState() => _detailScreen();
}

class _detailScreen extends State<DetailScreen> {
  int currentIndex = 0;
  late int timerSize = widget.cdTimer.setsOfTimer.length;
  late int totalSeconds = widget.cdTimer.time;
  late Timer timer;
  bool isRunning = false;
  int tempSeconds = 10;
  late int maxSets = widget.cdTimer.sets;
  int currentSets = 0;
  bool reset = false, called = false;

  void onTick(Timer timer) {
    // Initialize currentTimerDuration only once when called
    if (!called) {
      tempSeconds = widget.cdTimer.setsOfTimer[currentIndex].time;
      called = true;
    }
    //update to next timer
    if (tempSeconds <= 0) {
      if (currentIndex < timerSize) {
        tempSeconds = widget.cdTimer.setsOfTimer[currentIndex].time;
        currentIndex++;
      } else {
        currentIndex = 0;
        reset = true;
      }
    }

    if (currentSets + 1 > maxSets) {
      print("cancel is called");
      currentSets--;
      setState(() {
        timer.cancel();
      });
    } else {
      setState(() {
        tempSeconds--;
        print("sets: $currentSets");
      });
    }
    // Update the sets if the timer has reset
    updateSetsIfResetting();
    if (reset) {
      if (currentSets < maxSets) {
        print("update sets called");
        currentSets++;
      }
      reset = false;
    }

    print("size of sets: $maxSets");
    print("size of timer: $timerSize");
  }

  void updateSetsIfResetting() {
  if (reset) {
    if (currentSets < maxSets) {
      print("update sets called");
      currentSets++;
    }
    reset = false;
  }
}

  void onNext() {
    setState(() {
      if (currentIndex < widget.cdTimer.setsOfTimer.length - 1) {
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

  void oTick(Timer timer) {
    if (tempSeconds == 0 && maxSets > 1) {
      setState(() {
        tempSeconds = totalSeconds;
      });
    } else if (tempSeconds == 0 && maxSets == 1) {
      setState(() {
        tempSeconds = totalSeconds;
        maxSets = widget.cdTimer.sets;
        isRunning = false;
        timer.cancel();
      });
    } else {
      if (mounted) {
        setState(() {
          tempSeconds = tempSeconds - 1;
        });
      }
    }
  }

  void onResetPressed() {
    setState(() {
      tempSeconds = widget.cdTimer.time;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    var dispTime = duration.toString().split(".").first.substring(2, 7);
    return dispTime;
  }

  void onPausePressed() {
    timer.cancel();
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
        title: const Text("Timer"),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                widget.cdTimer.title,
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
            child: Container(
              child: Text(
                format(tempSeconds),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 80,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
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
          ),
          Flexible(
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
                            Text(
                              "Sets",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .color),
                            ),
                            Text(
                              "${currentSets + 1}/${widget.cdTimer.sets}",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .color),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Rest",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .color),
                            ),
                            Text(
                              "0",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .color),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
