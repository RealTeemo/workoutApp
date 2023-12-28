// import 'package:everyday_timer/features/cd_timer/data/models/cd_timer.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';

// class Countdown extends StatefulWidget {
//   Countdown({super.key, required this.timer, required this.isReset, required this.isRunning});
//   CdTimer timer;
//   bool isReset;
//   bool isRunning;
//   @override
//   State<Countdown> createState() => _CountdownState();
// }

// class _CountdownState extends State<Countdown> {
//   late CdTimer timerInfo = widget.timer;
//   late Timer timer;
//   late bool isReset = widget.isReset, isRunning = widget.isRunning, called = false;
//   int currentSets = 0, currentIndex = 0, totalSeconds = 0;

//   String format(int seconds) {
//     var duration = Duration(seconds: seconds);
//     var dispTime = duration.toString().split(".").first.substring(2, 7);
//     return dispTime;
//   }

//   void onTick(Timer timer) {
//     // Initialize currentTimerDuration only once when called
//     if (!called) {
//       totalSeconds = timerInfo.setsOfTimer[currentIndex].time;
//       called = true;
//     }
//     //update to next timer
//     if (totalSeconds <= 0) {
//       if (currentIndex < timerInfo.setsOfTimer.length) {
//         totalSeconds = timerInfo.setsOfTimer[currentIndex].time;
//         workoutName = timerInfo.setsOfTimer[currentIndex].title;
//         currentIndex++;
//       } else {
//         currentIndex = 0;
//         isReset = true;
//       }
//     }

//     if (currentSets + 1 > timerInfo.sets) {
//       print("cancel is called");
//       currentSets--;
//       setState(() {
//         timer.cancel();
//         isRunning = false;
//       });
//     } else {
//       setState(() {
//         totalSeconds--;
//         print("sets: $currentSets");
//       });
//     }

//     // Update the sets if the timer has reset
//     updateSetsIfResetting();
//     updateSets();

//     print("size of sets: ${timerInfo.sets}");
//   }

//   void updateSets(){
//     if (isReset) {
//       if (currentSets < timerInfo.sets) {
//         currentSets++;
//       }
//       isReset = false;
//     }
//   }

//   void updateSetsIfResetting() {
//   if (isReset) {
//     if (currentSets < timerInfo.sets) {
//       print("update sets called");
//       currentSets++;
//     }
//     isReset = false;
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text(
//           format(totalSeconds),
//           style: TextStyle(
//             color: Theme.of(context).cardColor,
//             fontSize: 80,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     );
//   }
// }

