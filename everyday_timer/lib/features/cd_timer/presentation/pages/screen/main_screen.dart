import 'package:everyday_timer/features/cd_timer/data/models/cd_timer.dart';
import 'package:everyday_timer/features/cd_timer/presentation/pages/screen/cd_timer/timer_cr_setting/option_setting.dart';
import 'package:everyday_timer/features/cd_timer/presentation/widgets/drawer/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:everyday_timer/features/cd_timer/presentation/pages/screen/stopwatch/stopwatch.dart';
import 'package:everyday_timer/features/cd_timer/presentation/pages/screen/cd_timer/cd_timer_list.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  
  //shows different widget at the center depending on which bottom navbar icon widget is selected
  int _selectedIndex = 0;
  late final  List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const StopWatchTimer(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

