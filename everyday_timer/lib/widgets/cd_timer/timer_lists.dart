import 'package:everyday_timer/screens/screen/cd_timer/cd_timer_details.dart';
import 'package:flutter/material.dart';
import 'package:everyday_timer/model/cd_timer.dart';

class TimersList extends StatelessWidget {
  TimersList({super.key, required this.timerList});

  List<CdTimer> timerList;
  @override
  Widget build(BuildContext context) {
    if (timerList.isEmpty) {
      return Center(
        child: Text("No timer added yet", 
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Theme.of(context).colorScheme.onBackground,
        ),),
      );
    }

    return ListView.builder(
        itemCount: timerList.length,
        itemBuilder: (ctx, index) => Card(
          child: ListTile(
                title: Text(
                  timerList[index].title,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> DetailScreen(cdTimer: timerList[index])));
                },
              ),
        ),);
  }
}
