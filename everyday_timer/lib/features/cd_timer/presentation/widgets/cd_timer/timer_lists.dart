import 'package:everyday_timer/providers/timer_provider.dart';
import 'package:everyday_timer/features/cd_timer/presentation/pages/screen/cd_timer/timer_detail/cd_timer_details.dart';
import 'package:everyday_timer/features/cd_timer/presentation/pages/screen/cd_timer/timer_detail/cd_timer_info.dart';
import 'package:flutter/material.dart';
import 'package:everyday_timer/features/cd_timer/data/models/cd_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimersList extends ConsumerWidget {
  TimersList({super.key, required this.timerList});
  
  List<CdTimer> timerList;
  @override
  // create list of timers created
  Widget build(BuildContext context, WidgetRef ref) {
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
                subtitle: Text("- ${timerList[index].subtitle}",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                trailing: IconButton(onPressed: (){
                  ref.read(userTimersProvider.notifier).deleteTimer(timerList[index]);
                }, icon: const Icon(Icons.delete_forever)),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> TimerInfoScreen(timer: timerList[index]) /*DetailScreen(cdTimer: timerList[index])*/));
                },
                onLongPress: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> DetailScreen(cdTimer: timerList[index])));
                },
              ),
        ),);
  }
}
