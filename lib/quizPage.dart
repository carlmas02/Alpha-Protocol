import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'themes.dart' as Theme;
import 'question.dart' as question;


class quizPage extends StatefulWidget {
  @override
  _quizPageState createState() => _quizPageState();
}

class _quizPageState extends State<quizPage> {

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
  CountdownTimerController controller;
  void onEnd() {
    Navigator.of(context).pop();
  }

  int index = 0;
  int noQuiz = question.noQuiz;

  List<Map> myList = question.myList;

  String ques = question.ques;
  String answ = question.answ;


  Future<void> scanBarCode() async{

    try {
      final ScanResult = await FlutterBarcodeScanner.scanBarcode(
          '#FFF44336',
          "Cancel",
          true,
          ScanMode.BARCODE
      );
      if (!mounted) return;
      if(ScanResult==myList[index]['answer']){
        print('yes');
        index+=1;
        if(index == noQuiz){
          Navigator.of(context).pop();

        }
        else{

          setState(() {
            ques = myList[index]['question'];
            answ = myList[index]['answer'];
          });

        }
      }else{
        print('no');
      }

    } on PlatformException{

      print("error");

    }

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theme.CommonMethod().themedata,
      home: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(ques),
              CountdownTimer(
                controller: controller,
                onEnd: onEnd,
                endTime: endTime,
              ),
              RaisedButton(child:Text("Scan"),onPressed: scanBarCode,)

            ],
          ),

        ),


      ),


    );
  }

}
