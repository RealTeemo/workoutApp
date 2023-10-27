import 'package:flutter/material.dart';
import 'package:everyday_timer/widgets/cd_timer/dropdownIntSelec.dart';
import 'package:everyday_timer/model/cd_timer.dart';


class GeneratedButtons2 extends StatefulWidget {
  int selectedSets;
  int selectedMins, selectedSecs;
  int breakMins, breakSecs;
  final Type selectorType;
  final TextEditingController titleController;
  final Function(GeneratedButtons2) onDelete;

  GeneratedButtons2(
      {super.key,

      this.selectedSets = 1,
      this.selectorType = Type.dValue,
      this.selectedMins=0,
      this.selectedSecs=0,
      this.breakMins=0,
      this.breakSecs=0,
      TextEditingController? titleController,
      required this.onDelete}): titleController = titleController?? TextEditingController();

  @override
  State<GeneratedButtons2> createState() => _generatedButtons2State();
}

class _generatedButtons2State extends State<GeneratedButtons2> {
  
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
              icon: const Icon(Icons.cancel_outlined, color: Colors.black54),
              color: Colors.blueAccent[200],
            ),
          ),
          if(widget.selectorType == Type.advanced)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                      controller: widget.titleController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                          label: const Text("Title"), border: OutlineInputBorder( borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: Colors.black54, width: 20.0))),
                    ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.selectorType == Type.amrap || widget.selectorType == Type.advanced ? 'Work' : 'Sets',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 25),
              widget.selectorType == Type.amrap || widget.selectorType == Type.advanced
                  ? Row(
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
                        const Text(":", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),),
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
                        ),
                      ],
                    )
                  : SizedBox(
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
          Row(
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