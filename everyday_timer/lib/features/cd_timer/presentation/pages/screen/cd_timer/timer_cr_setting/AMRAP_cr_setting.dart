import 'package:everyday_timer/providers/timer_provider.dart';
import 'package:everyday_timer/features/cd_timer/presentation/pages/screen/main_screen.dart';
import 'package:everyday_timer/features/cd_timer/presentation/widgets/cd_timer/dropdownIntSelec.dart';
import 'package:flutter/material.dart';
import 'package:everyday_timer/features/cd_timer/presentation/widgets/cd_timer/generatedButtons.dart';
import 'package:everyday_timer/features/cd_timer/presentation/widgets/cd_timer/generatedButtons2.dart';
import 'package:everyday_timer/features/cd_timer/data/models/cd_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AmrapSetting extends ConsumerStatefulWidget {
  const AmrapSetting({super.key});
  @override
  ConsumerState<AmrapSetting> createState() => _AmrapSettingState();
}

class _AmrapSettingState extends ConsumerState<AmrapSetting> {
  List<GeneratedButtons2> generatedButtons = [];
  int selectedMinutes = 0, selectedSeconds = 0;
  int selectedSets = 1;
  int breakMins = 0, breakSecs = 0;
  final titleController = TextEditingController();
  //callback function to update

  void generateButtons() {
    setState(() {
      generatedButtons.add(GeneratedButtons2(
        selectorType: Type.amrap,
        selectedSets: selectedSets,
        titleController: TextEditingController(),
        onDelete: deleteCreatedButtons,
      ));
      print("listNum: ${generatedButtons.length}");
    });
  }

  //callback function to delete
  void deleteCreatedButtons(GeneratedButtons2 generatedButton2) {
    setState(() {
      generatedButtons.remove(generatedButton2);
    });

    print("listnum size updated: ${generatedButtons.length}");
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  void submitNewTimerData() {
    //send
    bool checkEmpty = false;
    int enteredTotalTime = selectedMinutes * 60 + selectedSeconds;
    int enteredtotalRestTime = breakMins * 60 + breakSecs, totalworkoutTime = 0;
    final valueIsInvalid = enteredTotalTime <= 0;
    CdTimer sendData;
    StoredTimer temp2;

    for(final timer in generatedButtons){
      totalworkoutTime += timer.breakMins*60 +timer.breakSecs + timer.selectedMins*60+ timer.selectedSecs;
    }

    sendData = CdTimer(time: totalworkoutTime, title: titleController.text,);
    temp2 = StoredTimer(time: enteredTotalTime, type: WorkType.work.toString());
    sendData.addTimer(temp2);
    
    if (generatedButtons.isNotEmpty) {
      for (GeneratedButtons2 gButtons in generatedButtons) {
        enteredTotalTime = gButtons.selectedMins * 60 +
            gButtons.selectedSecs;
        enteredtotalRestTime =
            gButtons.breakMins * 60 + gButtons.breakSecs;
        if (enteredTotalTime == 0) {
          checkEmpty = true;
        }
        temp2 = StoredTimer(time: enteredTotalTime, type: WorkType.work.toString());
        sendData.addTimer(temp2);
      }
    }

    if (titleController.text.trim().isEmpty || valueIsInvalid || checkEmpty) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("Invalid input"),
                content: const Text("please enter the value."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text("okay"),
                  )
                ],
              ));
      return;
    }

    ref.read(userTimersProvider.notifier).insertTimer(sendData);
   Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('AMRAP'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  submitNewTimerData();
                },
                icon: const Icon(Icons.check))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      label: Text("Title"),
                      border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                const Text("Time Cap"),
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
                const SizedBox(
                  height: 65,
                ),
                Column(
                  children: generatedButtons,
                ),
                ElevatedButton(
                  onPressed: generateButtons,
                  child: const Text('Add sets (optionals)'),
                )
              ],
            ),
          ),
        ));
  }
}
