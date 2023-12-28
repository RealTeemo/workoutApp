// import 'dart:async';

// import 'package:everyday_timer/features/cd_timer/data/models/cd_timer.dart';

// class DetailScreenPresenter {
//   late CdTimer timerInfo;
//   late Timer timer;
//   bool isRunning = false;
//   late int tempSeconds;
//   int currentIndex = 1;
//   int currentSets = 0;
//   bool reset = false;

//   DetailScreenPresenter(this.timerInfo) {
//     tempSeconds = timerInfo.setsOfTimer[0].time;
//   }

//   Route _createRoute() {
//     return PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) =>
//           TimerFinishedScreen(title: timerInfo.title,),// DetailScreen(cdTimer: timer),
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         return child;
//       },
//     );
//   }

//   void onTick(Timer timer) {
//     //update to next timer
//     if (tempSeconds <= 0) {
//       if (currentIndex < timerInfo.setsOfTimer.length) {
//         tempSeconds = timerInfo.setsOfTimer[currentIndex].time;
//         workoutName = timerInfo.setsOfTimer[currentIndex].title;
//         currentIndex++;
//       } else {
//         currentIndex = 0;
//         reset = true;
//       }
//     }

//     //check if timer is completed
//     if (currentSets+1 > timerInfo.sets) {
//       Navigator.of(context).push(_createRoute());
//       setState(() {
//         timer.cancel();
//         isRunning = false;
//       });
//     } else {
//       setState(() {
//         tempSeconds--;
//       });
      
//       if(tempSeconds<3){

//       }
//     }

//     // Update the sets if the timer has reset
//     updateSetsIfResetting();
//   }

//   void updateSetsIfResetting() {
//     if (reset) {
//       if (currentSets < timerInfo.sets) {
//         print("update sets called");
//         currentSets++;
//       }
//       reset = false;
//     }
//   }

//   void onNext() {
//     // setState(() {
//       if (currentIndex < widget.cdTimer.setsOfTimer.length + 1) {
//         currentIndex++;
//       }
//     // });
//   }

//   void onPrev() {
//     // setState(() {
//       if (currentIndex > 0) {
//         currentIndex--;
//       }
//     // });
//   }

//   void onResetPressed() {
//     // setState(() {
//       tempSeconds = widget.cdTimer.setsOfTimer[currentIndex].time;
//     // });
//   }

//   String format(int seconds) {
//     var duration = Duration(seconds: seconds);
//     var dispTime = duration.toString().split(".").first.substring(2, 7);
//     return dispTime;
//   }

//   void onPausePressed() {
//     timer.cancel();
//     // setState(() {
//       isRunning = false;
//     // });
//   }

//   void onStartPressed() {
//     timer = Timer.periodic(const Duration(seconds: 1), onTick);
//     // setState(() {
//       isRunning = true;
//     // });
//   }
// }
