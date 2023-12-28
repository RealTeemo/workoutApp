import 'package:everyday_timer/features/cd_timer/data/models/cd_timer.dart';
import 'package:everyday_timer/features/cd_timer/presentation/pages/screen/cd_timer/timer_detail/cd_timer_details.dart';
import 'package:flutter/material.dart';

class CountdownTimer extends StatelessWidget {

  const CountdownTimer({super.key, required this.cdTimers});
  
  final CdTimer cdTimers;


  String format(int seconds){
    var duration = Duration(seconds: seconds);
    var dispTime = duration.toString().split(".").first.substring(2,7);
    return dispTime;
  }
    
  @override
  Widget build(BuildContext context) {
    //timer card 
    return GestureDetector(
      //navigate to detail view of timer
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: ((context) => DetailScreen(cdTimer: cdTimers)),
        fullscreenDialog: true,
        ));
      },
      child: Container(
            padding: const EdgeInsets.all(10.0),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: const Color(0xFF323F68), 
              borderRadius: BorderRadius.circular(8),
              boxShadow: [BoxShadow(
                blurRadius: 5,
                offset: const Offset(0, 0),
                color: Colors.black.withOpacity(0.5),
              )]
              ) ,
             child: Column(
               children: [
                const SizedBox(height: 10,),
                //title
                Text(cdTimers.title, style: TextStyle(color: Theme.of(context).cardColor, fontSize: 22, fontWeight: FontWeight.w500),),
                //sets
                Row(children: [
                  Text("SETS: ${cdTimers.sets}",  style: TextStyle(color: Theme.of(context).cardColor, fontSize: 22, fontWeight: FontWeight.w500)),
                ],),
                //work
                Row(children: [
                  Text("WORK: ${format(cdTimers.time)}",  style: TextStyle(color: Theme.of(context).cardColor, fontSize: 22, fontWeight: FontWeight.w500)),
                ],),
                //rest
                Row(children: [
                  Text("REST:",  style: TextStyle(color: Theme.of(context).cardColor, fontSize: 22, fontWeight: FontWeight.w500)),
                ],),
                const SizedBox(height: 10,)
               ],
             ),
           ),
    );
  }
}