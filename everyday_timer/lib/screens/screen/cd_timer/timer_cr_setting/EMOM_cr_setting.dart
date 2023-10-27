import 'package:everyday_timer/providers/timer_provider.dart';
import 'package:everyday_timer/widgets/cd_timer/dropdownIntSelec.dart';
import 'package:flutter/material.dart';
import 'package:everyday_timer/widgets/cd_timer/generatedButtons.dart';
import 'package:everyday_timer/model/cd_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class EmomSetting extends ConsumerStatefulWidget {
  const EmomSetting({super.key});
  @override
  ConsumerState<EmomSetting> createState() => _EmomSettingState();
}

class _EmomSettingState extends ConsumerState<EmomSetting> {
  List<GeneratedButton> generatedButtons = [];
  bool isOn = false;
  int selectedMinutes = 0;
  int selectedSets = 1;
  int breakMins = 0, breakSecs = 0;
  int forVal = 1;
  int timeValue = 59, setValue = 10;
  final titleController = TextEditingController();

  void generateButtons() {
    setState(() {
      isOn = true;
      generatedButtons.add(GeneratedButton(
        selectedMins: breakMins,
        selectedSecs: breakSecs,
        selectedSets: selectedSets,
        updateValue: updateSets,  
        onDelete: deleteCreatedButtons
      ));
    });
  }

  void updateSets(int inputSets){
    selectedSets = inputSets;
  }

  //callback function to delete
  void deleteCreatedButtons(GeneratedButton generatedButton) {
    setState(() {
      isOn = false;
      selectedSets = 1;
      generatedButtons.remove(generatedButton);
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  void submitNewTimerData(){
    final enteredTotalTime = selectedMinutes;
    final valueIsInvalid = enteredTotalTime <= 0;
    CdTimer sendTimer= CdTimer(time: 0, title: titleController.text, sets: selectedSets);
    StoredTimer temp2;
    
    for(int i = 0; i<forVal;i++){
      temp2 = StoredTimer(time: enteredTotalTime, title: "Work${i+1}");
      sendTimer.addTimer(temp2);
    }

    if (generatedButtons.isNotEmpty) {
      final enteredtotalRestTime = generatedButtons[0].selectedMins *60+ generatedButtons[0].selectedSecs; 
      print("break time: $enteredtotalRestTime");
      if(enteredtotalRestTime!=0){
        temp2 = StoredTimer(time: enteredtotalRestTime, title: "Rest");
        sendTimer.addTimer(temp2);
      }  
    }

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
    
    ref.read(userTimersProvider.notifier).insertTimer(sendTimer);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('EMOM'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(onPressed: submitNewTimerData, icon: const Icon(Icons.check))
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
                        label: Text("Title"), border: OutlineInputBorder()),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Every", style: TextStyle(fontWeight: FontWeight.bold),),
                    const SizedBox(width: 10,),
                    DropdownIntSelector(
                      selectorType: Type.emom, // future update not completed!!
                      isSets: false,
                      value: selectedMinutes,
                      maxValue: 20,
                      onChanged: (newValue) {
                        setState(() {
                          selectedMinutes =
                              newValue!; // Update the selected value
                          print(breakMins);
                          print(breakSecs);
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("For", style: TextStyle(fontWeight: FontWeight.bold),),
                    const SizedBox(width: 10,),
                    DropdownIntSelector(
                          selectorType: Type.sets,
                          isSets: true,
                          value: forVal,
                          maxValue: setValue,
                          onChanged: (newValue) {
                            setState(() {
                              forVal =
                                  newValue!; // Update the selected value
                              print(breakMins);
                              print(breakSecs);
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