import 'package:everyday_timer/features/cd_timer/data/models/cd_timer.dart';
import 'package:flutter/material.dart';
import 'package:everyday_timer/features/cd_timer/presentation/widgets/cd_timer/dropdownIntSelec.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabataSetting extends ConsumerStatefulWidget {
  const TabataSetting({super.key});

  @override
  ConsumerState<TabataSetting> createState() => _TabataSettingState();
}

class _TabataSettingState extends ConsumerState<TabataSetting> {
  int selectedMinutes = 0, selectedSeconds = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('TABATA'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(onPressed: () {}, icon: const Icon(Icons.check))
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
                  child: const TextField(
                    decoration: InputDecoration(
                        label: Text("Title"), border: OutlineInputBorder(),  fillColor: Colors.white,
                  filled: true,),
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
                          print(selectedMinutes);
                        });
                      },
                    ),
                    const Text(
                      ":",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                    ),
                    DropdownIntSelector(
                      value: selectedSeconds,
                      selectorType: Type.dValue,
                      isSets: false,
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
                /*Column(
                  children: generatedButtons,
                ),
                !isOn
                    ? ElevatedButton(
                        onPressed: generateButtons,
                        child: const Text('Add sets (optionals)'),
                      )
                    : const SizedBox(height: 10),*/
              ],
            ),
          ),
        ));
  }
}
