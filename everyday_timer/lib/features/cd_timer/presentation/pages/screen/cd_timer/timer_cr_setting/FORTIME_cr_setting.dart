import 'package:everyday_timer/features/cd_timer/data/models/cd_timer.dart';
import 'package:everyday_timer/providers/timer_provider.dart';
import 'package:everyday_timer/features/cd_timer/presentation/widgets/cd_timer/dropdownIntSelec.dart';
import 'package:flutter/material.dart';
import 'package:everyday_timer/features/cd_timer/presentation/widgets/cd_timer/generatedButtons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForTimeSetting extends ConsumerStatefulWidget {
  const ForTimeSetting({
    super.key,
  });

  @override
  ConsumerState<ForTimeSetting> createState() => _ForTimeSettingState();
}

class _ForTimeSettingState extends ConsumerState<ForTimeSetting> {
  List<GeneratedButton> generatedButtons = [];
  bool isOn = false;
  int selectedMinutes = 0, selectedSeconds = 0;
  int selectedSets = 1;
  int breakMins = 0, breakSecs = 0;
  int buttonIndex = 0;
  final titleController = TextEditingController();

  void updateValue(int inputSets) {
    selectedSets = inputSets;
  }

  void generateButtons() {
    setState(() {
      isOn = true;
      generatedButtons.add(GeneratedButton(
          selectedMins: breakMins,
          selectedSecs: breakMins,
          selectedSets: selectedSets,
          updateValue: updateValue,
          onDelete: deleteCreatedButtons));
      buttonIndex++;
    });
  }

  //callback function to delete
  void deleteCreatedButtons(index) {
    setState(() {
      isOn = false;
      generatedButtons.remove(index);
      selectedSets = 1;
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  void submitNewTimerData() {
    final enteredTotalTime = selectedMinutes * 60 + selectedSeconds;
    final enteredtotalRestTime = breakMins * 60 + breakSecs;

    final valueIsInvalid = enteredTotalTime <= 0;
    CdTimer temp =
        CdTimer(time: 0, title: titleController.text, sets: selectedSets);
    StoredTimer temp2;

    temp2 = StoredTimer(time: enteredTotalTime, title: "Work", type: WorkType.work.toString());
    temp.addTimer(temp2);
    if (generatedButtons.isNotEmpty) {
      if (enteredtotalRestTime != 0) {
        temp2 = StoredTimer(time: enteredtotalRestTime, title: "Rest", type: WorkType.rest.toString());
        temp.addTimer(temp2);
      }
    }

    if (titleController.text.trim().isEmpty || valueIsInvalid) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("Invalid input"),
                content: const Text("please enter the correct value or name."),
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

    ref.read(userTimersProvider.notifier).insertTimer(temp);
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('FOR TIME'),
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
                !isOn
                    ? ElevatedButton(
                        onPressed: generateButtons,
                        child: const Text('Add sets (optionals)'),
                      )
                    : const SizedBox(height: 10),
              ],
            ),
          ),
        ));
  }
}
