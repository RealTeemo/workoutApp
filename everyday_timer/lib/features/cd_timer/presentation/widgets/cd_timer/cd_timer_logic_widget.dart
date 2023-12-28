import 'package:everyday_timer/features/cd_timer/data/models/cd_timer.dart';
import 'package:flutter/material.dart';

class TimerCountdown extends StatefulWidget {
  TimerCountdown({super.key, required this.cdTimer});

  CdTimer cdTimer;

  @override
  State<TimerCountdown> createState() => _TimerCountdownState();
}

class _TimerCountdownState extends State<TimerCountdown> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}