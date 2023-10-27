import 'package:everyday_timer/model/cd_timer.dart';
import 'package:everyday_timer/screens/screen/cd_timer/timer_cr_setting/AMRAP_cr_setting.dart';
import 'package:everyday_timer/screens/screen/cd_timer/timer_cr_setting/FORTIME_cr_setting.dart';
import 'package:everyday_timer/screens/screen/cd_timer/timer_cr_setting/option_setting.dart';
import 'package:flutter/material.dart';
import 'package:everyday_timer/screens/screen/stopwatch/stopwatch.dart';
import 'package:everyday_timer/widgets/cd_timer/cd_timer_widget.dart';
import 'package:everyday_timer/screens/screen/cd_timer/timer_cr_setting/SIMPLE_cr_setting.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

/*class _MainScreenStatess extends State<MainScreen> {
  final List<CdTimer> _registeredTimer= [
    CdTimer(time: 10, title: "test1"),
    CdTimer(time: 5, rest: 3, title: "hiphop",lap: 2, restTime: 3),
    CdTimer(time: 8, title: "test3", rest: 1, restTime: 2, lap: 1)
  ];

}*/

class _MainScreenState extends State<MainScreen> {
  
  final List<CdTimer> _registeredTimer= [
    CdTimer(time: 10, title: "test1"),
    CdTimer(time: 5, title: "hiphop",sets: 2,),
    CdTimer(time: 8, title: "test3", sets: 1)
  ];

  void _addNewTimer(CdTimer cdtimer){
    setState(() {
      _registeredTimer.add(cdtimer);
    });
    
  }
  
  //shows different widget at the center depending on which bottom navbar icon widget is selected
  int _selectedIndex = 0;
  late final  List<Widget> _widgetOptions = <Widget>[
    Column(children: [
      const SizedBox(height: 20,),
      Expanded(child: makeList(registeredTimer: _registeredTimer,)),
    ]),
    const StopWatchTimer(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // void openAddNewTimer(){
  //   showModalBottomSheet(context: context, builder: (ctx)=>  CountdownTimerSetting( onAddList: _addNewTimer));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar showing title and new timer creation button
      appBar: AppBar(
        title: const Text("Workout"),
        actions: <Widget>[
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: ((context) => OptionSettings()),
            fullscreenDialog: true,
        ));
          }, 
          icon:  const Icon(Icons.add, size: 30,))
        ],        
      ),
    //widget page
    body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    //bottom navigation bar
    bottomNavigationBar:BottomNavigationBar(items:  const <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      BottomNavigationBarItem(icon: Icon(Icons.timer), label: "Stopwatch"),
    ],
    currentIndex: _selectedIndex,
    selectedItemColor: Colors.amber[800],
    onTap: _onItemTapped,
    ),


    );
  }
}

class makeList extends StatefulWidget {
  final List<CdTimer> registeredTimer;
  const makeList({
    super.key,
    required this.registeredTimer,
  });

  @override
  State<makeList> createState() => _makeListState();
}

class _makeListState extends State<makeList> {
  //temp database

  @override
  Widget build(BuildContext context) {
    //show the list of timers on home widget
    return ListView.separated(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemCount: widget.registeredTimer.length,
      itemBuilder: (context, index){
         return CountdownTimer(cdTimers: widget.registeredTimer[index]);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 15),
    );
  }
}

