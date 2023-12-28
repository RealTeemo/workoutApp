import 'package:flutter/material.dart';
//button update widget
class TimerControlsWidget extends StatelessWidget {
  final bool isRunning;
  final VoidCallback onPausePressed;
  final VoidCallback onStartPressed;
  final VoidCallback onResetPressed;

  const TimerControlsWidget({super.key, 
    required this.isRunning,
    required this.onPausePressed,
    required this.onStartPressed,
    required this.onResetPressed,
  });

  @override
  Widget build(BuildContext context) {
    //updates the button when it is clicked
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            color: Theme.of(context).cardColor,
            iconSize: 120,
            onPressed: isRunning ? onPausePressed : onStartPressed,
            icon: Icon(
              isRunning
                  ? Icons.pause_circle_outline
                  : Icons.play_circle_outline_outlined,
            ),
          ),
          IconButton(
            color: Theme.of(context).cardColor,
            iconSize: 120,
            onPressed: onResetPressed,
            icon: const Icon(Icons.stop_circle_outlined),
          ),
        ],
      ),
    );
  }
}