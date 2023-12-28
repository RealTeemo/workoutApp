import 'package:everyday_timer/providers/timer_provider.dart';
import 'package:everyday_timer/features/cd_timer/presentation/pages/screen/main_screen.dart';
import 'package:everyday_timer/features/cd_timer/presentation/widgets/cd_timer/dropdownIntSelec.dart';
import 'package:flutter/material.dart';
import 'package:everyday_timer/features/cd_timer/presentation/widgets/cd_timer/generatedButtons.dart';
import 'package:everyday_timer/features/cd_timer/presentation/widgets/cd_timer/generatedButtons2.dart';
import 'package:everyday_timer/features/cd_timer/data/models/cd_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvancedSetting extends ConsumerStatefulWidget {
  const AdvancedSetting({super.key});
  @override
  ConsumerState<AdvancedSetting> createState() => AdvancedSettingState();
}

class AdvancedSettingState extends ConsumerState<AdvancedSetting> {
  List<GeneratedButtons2> generatedButtons = [];
  int selectedSeconds = 0;
  int selectedSets = 1;
  int breakSecs = 0;
  final presetTitleController = TextEditingController(text: "Workout");
  final titleController = TextEditingController();
  //callback function to update

  void generateButtons() {
    setState(() {
      generatedButtons.add(GeneratedButtons2(
        selectorType: Type.advanced,
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
    presetTitleController.dispose();
    titleController.dispose();
    super.dispose();
  }

  void submitNewTimerData() {
    //send
    bool checkEmpty = false;
    int enteredTotalTime = selectedSeconds;
    int enteredtotalRestTime = breakSecs;
    int totalworkoutTime = 0;
    final valueIsInvalid = enteredTotalTime <= 0;
    CdTimer sendData;
    StoredTimer temp2;

    for(final timer in generatedButtons){
      totalworkoutTime += timer.breakMins*60 +timer.breakSecs + timer.selectedMins*60+ timer.selectedSecs;
    }
    totalworkoutTime = totalworkoutTime*selectedSets;

    sendData = CdTimer(
      time: totalworkoutTime,
      title: presetTitleController.text,
      subtitle: "advanced",
      sets: selectedSets
    );


    temp2 = StoredTimer(time: enteredTotalTime, title: titleController.text, type: WorkType.work.toString(),);
    sendData.addTimer(temp2);
    if (breakSecs != 0) {
      temp2 = StoredTimer(time: breakSecs, title: "Break", type: WorkType.rest.toString());
      sendData.addTimer(temp2);
    }

    if (generatedButtons.isNotEmpty) {
      for (int i = 0; i < generatedButtons.length; i++) {
        enteredTotalTime = generatedButtons[i].selectedSecs;
        temp2 = StoredTimer(time: enteredTotalTime, title: generatedButtons[i].titleController.text, type: WorkType.work.toString());
        sendData.addTimer(temp2);

        enteredtotalRestTime = generatedButtons[i].breakSecs;
        if (enteredtotalRestTime != 0) {
          temp2 = StoredTimer(
              time: enteredtotalRestTime,
              title: "Break",
              type: WorkType.rest.toString());
          sendData.addTimer(temp2);
        }

        if (enteredTotalTime == 0) {
          checkEmpty = true;
        }
        print("array: $i, time: ${generatedButtons[i].titleController.text}");
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
          title: const Text('ADVANCED'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                onPressed: submitNewTimerData, icon: const Icon(Icons.check))
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
                    controller: presetTitleController,
                    decoration: const InputDecoration(
                        label: Text("Preset Title"),
                        border: OutlineInputBorder()),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Card(
                  color: Colors.blueAccent[100],
                  elevation: 5, // Adjust the elevation as needed
                  margin: const EdgeInsets.all(10), // Add margin as needed
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        Center(child: 
                        TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                          label: const Text("Title"), border: OutlineInputBorder( borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: Colors.black54, width: 20.0))),
                    ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text("Sets"),
                        Center(
                          child: DropdownIntSelector(
                            selectorType: Type.sets,
                            isSets: false,
                            value: selectedSets,
                            maxValue: 10,
                            onChanged: (newValue) {
                              setState(() {
                                selectedSets =
                                    newValue!; // Update the selected value
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text("Time Cap"),
                        Center(
                          child: DropdownIntSelector(
                            selectorType: Type.rest,
                            isSets: false,
                            value: selectedSeconds,
                            maxValue: 31,
                            onChanged: (newValue) {
                              setState(() {
                                selectedSeconds =
                                    newValue!; // Update the selected value
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text("Break"),
                        Center(
                          child: DropdownIntSelector(
                            selectorType: Type.rest,
                            isSets: false,
                            value: breakSecs,
                            maxValue: 31,
                            onChanged: (newValue) {
                              setState(() {
                                breakSecs =
                                    newValue!; // Update the selected value
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
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
