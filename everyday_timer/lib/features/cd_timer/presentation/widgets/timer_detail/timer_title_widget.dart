import 'package:flutter/material.dart';

class TimerTitleWidget extends StatelessWidget {
  final String title;

  const TimerTitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 80,
          color: Theme.of(context).cardColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}