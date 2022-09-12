import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class testPage extends StatefulWidget {
  @override
  _testPageState createState() => _testPageState();
}



class _testPageState extends State<testPage> {

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 900;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        home : Scaffold(
          body: Center( child :
            CountdownTimer(
              endTime: endTime,
              widgetBuilder: (_, CurrentRemainingTime time) {
                if (time == null) {
                  return Text('Game over');
                }
                return Text(
                    'min: ${time.min} , sec: ${time.sec}');
              },
            ),
          ),

        )

    );
  }
}
