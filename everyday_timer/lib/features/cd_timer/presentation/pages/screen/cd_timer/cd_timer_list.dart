import 'package:everyday_timer/providers/timer_provider.dart';
import 'package:everyday_timer/features/cd_timer/presentation/pages/screen/cd_timer/timer_cr_setting/option_setting.dart';
import 'package:everyday_timer/features/cd_timer/presentation/widgets/drawer/navigation_drawer.dart';
import 'package:everyday_timer/features/cd_timer/presentation/widgets/cd_timer/timer_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//home screen
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late Future<void> _timerFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timerFuture = ref.read(userTimersProvider.notifier).loadTimers();
  }

  @override
  Widget build(BuildContext context) {
    final userTimers = ref.watch(userTimersProvider);

    return Scaffold(
      drawer: const NavigationDrawers(),
      appBar: AppBar(
        // title: const Text('WOK Timer', ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => OptionSettings())));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: _timerFuture, 
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : TimersList(timerList: userTimers),
          )),
    );
  }
}
