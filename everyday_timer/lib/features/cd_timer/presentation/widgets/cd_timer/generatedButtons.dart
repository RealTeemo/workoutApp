import 'package:flutter/material.dart';
import 'package:everyday_timer/features/cd_timer/presentation/widgets/cd_timer/dropdownIntSelec.dart';
import 'package:everyday_timer/features/cd_timer/data/models/cd_timer.dart';

class GeneratedButton extends StatefulWidget {
  int selectedSets;
  int selectedMins, selectedSecs;
  int breakMins, breakSecs;
  final Type selectorType;
  final Function(int) updateValue;
  final Function(GeneratedButton) onDelete;

  GeneratedButton(
      {super.key,
      this.selectedSets = 1,
      this.selectedMins =0,
      this.selectedSecs = 0,
      this.breakMins = 0,
      this.breakSecs = 0,
      this.selectorType = Type.dValue,
      required this.updateValue,
      required this.onDelete});

  @override
  State<GeneratedButton> createState() => _GeneratedButtonState();
}

class _GeneratedButtonState extends State<GeneratedButton> {
 final titleController = TextEditingController(text: "");

  @override
  void dispose(){
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueAccent[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              child: IconButton(
            onPressed: () {
              widget.onDelete(widget);
            },
            iconSize: 30,
            icon: const Icon(Icons.cancel_outlined),
            color: Colors.blueAccent[200],
          )),
          //sets or work
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.selectorType == Type.amrap ? 'Work' : 'Sets',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 25),
              widget.selectorType == Type.amrap ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                SizedBox(
                width: 65.0,
                child: DropdownIntSelector(
                  selectorType: Type.dValue,
                  isSets: true,
                  value: widget.breakMins,
                  maxValue: 10,
                  onChanged: (newValue) {
                    setState(() {
                      widget.breakMins =
                          newValue!; // Update the selected value
                    });
                  },
                ),
              ),
              const Text(":"),
              SizedBox(
                width: 65.0,
                child: DropdownIntSelector(
                  selectorType: Type.dValue,
                  isSets: true,
                  value: widget.breakSecs,
                  maxValue: 10,
                  onChanged: (newValue) {
                    setState(() {
                      widget.breakSecs =
                          newValue!; // Update the selected value
                    });
                  },
                ),
              )],)
               :
              SizedBox(
                width: 65.0,
                child: DropdownIntSelector(
                  selectorType: Type.sets,
                  isSets: true,
                  value: widget.selectedSets,
                  maxValue: 10,
                  onChanged: (newValue) {
                    setState(() {
                      widget.selectedSets =
                          newValue!; // Update the selected value
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          //timer
          Row(
            //inserting value for mins
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Rest",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 25,
              ),
              SizedBox(
                width: 65.0,
                child: DropdownIntSelector(
                  selectorType: Type.dValue,
                  value: widget.selectedMins,
                  isSets: false,
                  maxValue: 59,
                  onChanged: (newValue) {
                    setState(() {
                      widget.selectedMins =
                          newValue!; // Update the selected value
                    });
                  },
                ),
              ),
              const Text(
                ":",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                //inserting value for secs
                width: 65.0,
                child: DropdownIntSelector(
                  selectorType: Type.dValue,
                  value: widget.selectedSecs,
                  isSets: false,
                  maxValue: 59,
                  onChanged: (newValue) {
                    setState(() {
                      widget.selectedSecs =
                          newValue!; // Update the selected value
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
