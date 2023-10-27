import 'package:everyday_timer/model/cd_timer.dart';
import 'package:everyday_timer/providers/timer_provider.dart';
import 'package:everyday_timer/widgets/cd_timer/dropdownIntSelec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CountdownTimerSetting extends ConsumerStatefulWidget {
  const CountdownTimerSetting({super.key});
  @override
  ConsumerState<CountdownTimerSetting> createState() => _CountdownTimerSettingState();
}

class _CountdownTimerSettingState extends ConsumerState<CountdownTimerSetting> {
  int selectedMinutes = 0, selectedSeconds = 0;
  int selectedSets = 1;
  int breakMins = 0, breakSecs = 0;

  final titleController = TextEditingController(text:"Workout");


  @override
  void dispose(){
    titleController.dispose();
    super.dispose();
  }

  void submitNewTimerData(){
    StoredTimer temp;
    CdTimer sendData;
    final enteredTotalTime = selectedMinutes*60 + selectedSeconds;
    final enteredtotalRestTime = breakMins*60 + breakSecs;
    final valueIsInvalid = enteredTotalTime <= 0;
    if(titleController.text.trim().isEmpty || valueIsInvalid){
      showDialog(context: context, builder: (ctx)=> AlertDialog(
        title: const Text("Invalid input"),
        content: const Text("please enter the correct value or name."),
        actions: [
          TextButton(
            onPressed: (){
            Navigator.pop(ctx);
          },
            child: const Text("okay")
             ,)
        ],
      ));
      return;
    }

    sendData = CdTimer(time: 0, title: titleController.text);
    temp = StoredTimer(time: enteredTotalTime, title: "Work");
    sendData.addTimer(temp);
    if(enteredtotalRestTime>0){
      temp = StoredTimer(time: enteredtotalRestTime, title: "Rest");
      sendData.addTimer(temp);
    }

    ref.read(userTimersProvider.notifier).insertTimer(sendData);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('SIMPLE'),
      //   actions: <Widget>[
      //     IconButton(onPressed: submitNewTimerData, icon: const Icon(Icons.check))
      //   ],
      // ),
      body: Center(
        
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 30,),
              Container(alignment: Alignment.topLeft,
              child:TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  label: Text("Title"),
                  border: OutlineInputBorder()
                ),
            
            ),
              ),
            const SizedBox(height: 50),
            const Text("SETS"),
            SizedBox(
                width: 65.0,
                child: DropdownIntSelector(
                      selectorType: Type.sets,
                      isSets: true,
                      value: selectedSets,
                      maxValue: 10,
                      onChanged: (newValue) {
                setState(() {
                  selectedSets = newValue!; // Update the selected value
                });
              },
                    ),
              ),
              
            const SizedBox(height: 40,),
            const Text("WORK"),
            Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownIntSelector(
                      selectorType: Type.dValue,
                      isSets: false,
                      value: selectedMinutes,
                      maxValue: 59,
                      onChanged: (newValue) {
                        setState(() {
                          selectedMinutes =
                              newValue!; // Update the selected value
                          print(breakMins);
                          print(breakSecs);
                        });
                      },
                    ),
                    const Text(
                      ":",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                    ),
                    DropdownIntSelector(
                      selectorType: Type.dValue,
                      isSets: false,
                      value: selectedSeconds,
                      maxValue: 59,
                      onChanged: (newValue) {
                        setState(() {
                          selectedSeconds =
                              newValue!; // Update the selected value
                          print("time $breakMins");
                        });
                      },
                    ),
                  ],
                ),
              
            const SizedBox(height: 40,),
            const Text("REST"),
            Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownIntSelector(
                      selectorType: Type.dValue,
                      isSets: false,
                      value: breakMins,
                      maxValue: 59,
                      onChanged: (newValue) {
                        setState(() {
                          breakMins = newValue!; // Update the selected value
                        });
                      },
                    ),
                    const Text(
                      ":",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                    ),
                    DropdownIntSelector(
                      selectorType: Type.dValue,
                      isSets: false,
                      value: breakSecs,
                      maxValue: 59,
                      onChanged: (newValue) {
                        setState(() {
                          breakSecs = newValue!; // Update the selected value
                        });
                      },
                    ),
                  ],
                ),
          
          ],),
        ),
      )
    );
  }

}