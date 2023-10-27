import 'package:flutter/material.dart';

class TimerFinishedScreen extends StatelessWidget {
  const TimerFinishedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppBar(

    );
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
              child: Text(
               "Finished",
                style: TextStyle(
                  fontSize: 80,
                  color: Theme.of(context).cardColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  
                ),
                onPressed: (){}, child: const Text("Restart"))
            ],
          )
        ],
      ),
    );
  }
}