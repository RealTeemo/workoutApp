import 'package:flutter/material.dart';
import 'dart:async';

class StopWatchTimer extends StatefulWidget {
  const StopWatchTimer({super.key});

  @override
  State<StopWatchTimer> createState() => _StopWatchTimerState();
}

class _StopWatchTimerState extends State<StopWatchTimer> {
  late int seconds = 0;
  late Timer timer;
  List laps = [];
  bool isRunning= false, havLaps = false;

  void onTick(Timer timer){
    if(mounted){
      setState(() {
      seconds = seconds+1;
    });
    }
  }

  String format(int seconds){
    var duration = Duration(seconds: seconds);
    if(seconds< 3600){
      var dispTime = duration.toString().split(".").first.substring(2,7);
      return dispTime;
    }
    var dispTime = duration.toString().split(".").first;
    return dispTime;
  }

  void onPausePressed(){
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onStartPressed(){
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
    setState(() {
      isRunning = true;
    });
  }

  void onResetPressed(){
    setState(() {
      havLaps = false;
      seconds = 0;
      laps = [];
    });
  }

  void onLapPressed(){
    String lap = format(seconds);
    laps.add(lap);
    setState(() {
      havLaps= true;
    });
  }
 
  @override
  Widget build( context) {
    return Scaffold(
      
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 30,),
            Flexible(
            flex: 1, 
            child: Column(
              children: [
                const SizedBox(height: 5,),
                Container(
                  alignment: Alignment.center,
                  child: Text(format(seconds),
                  style: TextStyle(
                    color: Theme.of(context).cardColor, 
                    fontSize: 80,
                    fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),),
      
            Flexible(
              flex: 4,
              child: Container(
               decoration:  BoxDecoration(color: const Color(0xFF323F68), borderRadius: BorderRadius.circular(13)),
                child: ListView.builder(
                  itemCount: laps.length, //laps.length,
                  itemBuilder: (context, index){
                    return Padding(padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Lap ${index + 1}: ",
                          style: TextStyle(
                            color: Theme.of(context).cardColor,
                          ),),
                          Text("${laps[index]}", 
                            style: TextStyle(
                            color: Theme.of(context).cardColor
                            ),),
                      ]),
                    );
                  }),
              ),
            ),
            Flexible(
              flex: 1,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: RawMaterialButton(onPressed: isRunning? onPausePressed: onStartPressed,
                    shape: const StadiumBorder(side: BorderSide(color: Colors.blue)),
                    child: Text(isRunning? "Pause": "Start", style: TextStyle(color: Theme.of(context).cardColor),),
                    
                    ),
                    
                    ),
                    Expanded(child: RawMaterialButton(onPressed: isRunning? onLapPressed: onResetPressed,
                    shape: const StadiumBorder(side: BorderSide(color: Colors.blue)),
                    child: Text(isRunning? "Lap":"Reset", style: TextStyle(color: Theme.of(context).cardColor),),
                    
                    ),),
                  ],
                ),
                   
            ),),
         ],
        ),
      ),
    );
  }
}