import 'package:flutter/material.dart';
import 'package:everyday_timer/model/cd_timer.dart';

class DropdownIntSelector extends StatelessWidget {
  final int? value;
  final int maxValue;
  final ValueChanged<int?> onChanged;
  final bool isSets;
  final Type selectorType;

  const DropdownIntSelector({
    Key? key,
    required this.value, //
    required this.maxValue, //set maximum value
    required this.onChanged, //
    required this.isSets, //check if this is for set
    required this.selectorType
  }) : super(key: key);

  String formatTime(int value) {
    int minutes = value ~/ 60;
    int seconds = value % 60;
    String formattedTime = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black54),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButton<int>(
        value: value,
        onChanged: onChanged,
        underline: const SizedBox(),
        items: List.generate(maxValue, (index) {
          if(selectorType == Type.sets){
            return index +1;
          }else if(selectorType == Type.emom){
            return index*15;
          } else if (selectorType == Type.rest){
            return index * 10;
          }
          return index;
        }).map((int value) {
          return DropdownMenuItem<int>(
            value: value,
            child: Center(
              child: Text(selectorType == Type.amrap || selectorType == Type.sets || selectorType == Type.dValue ? '$value' : formatTime(value),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }).toList(),
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}

/*
class CardDropdown<T> extends StatefulWidget {
  final List<T> items;
  final T? value;
  final void Function(T?) onChanged;
  final String labelText;

  const CardDropdown({super.key, 
    required this.items,
    required this.value,
    required this.onChanged,
    required this.labelText,
  });

  @override
  _CardDropdownState<T> createState() => _CardDropdownState<T>();
}

class _CardDropdownState<T> extends State<CardDropdown<T>> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButton<T>(
          value: widget.value,
          onChanged: widget.onChanged,
          underline: const SizedBox(),
          items: widget.items.map((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text('$item'),
            );
          }).toList(),
          isExpanded: true,
        ),
      ),
    );
  }
}
*/