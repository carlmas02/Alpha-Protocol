import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
// import 'package:flutter_countdown_timer/current_remaining_time.dart';
// import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hunt/finalPage.dart';
import 'package:hunt/main.dart';
// import 'question.dart' as question;
import 'package:http/http.dart' as http;
import 'data.dart' as Data;


class quizPage extends StatefulWidget {
  String otp;
  quizPage({@required this.otp}) ;

  @override
  _quizPageState createState() => _quizPageState();
}

class _quizPageState extends State<quizPage> {
  List<QuizData> q_data ;

  int index = 0;
  int noQuiz = 8; //length -1

  void showSnackBar(BuildContext context,text) {
    final snackBar = SnackBar(
      content: Text(text,
                  style: TextStyle(color: Color(0xff181920),
                          fontFamily: GoogleFonts.varela().fontFamily

                  ),),
      backgroundColor: Color(0xff64E54C),

      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(50),
      elevation: 20,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> getData() async {
    print(widget.otp);
    http.Response resp = await http.post(
      Uri.parse('https://alphaprotocol.herokuapp.com/ap/verotp'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode([
        {"code":widget.otp}
      ]
      ),
    );

    if(resp.statusCode==200){
      // var jsonData = jsonDecode(resp.body);
      // print(jsonData);
      // for (var v in jsonData) {
      //   print(v['ans']);
      //   QuizData data = QuizData(v['img'], v['ans']);
      //   q_data.add(data);
      // }
      // print('yo');
      test();
      return Data.quizItems[0];

      return q_data;

    }else if(resp.statusCode==400){
      Navigator.of(context).pop();

      showSnackBar(context, 'Invalid Code');
    }

    test();
    print('ho');
    return Data.quizItems[0];
  }

  // int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 3000;
  // CountdownTimerController controller;
  //
  // CurrentRemainingTime testing;

  void onEnd() {
    Navigator.of(context).pop();
    showSnackBar(context,"Time over !");
  }

  formatedTime(time) {
    int sec = time % 60;
    int min = (time / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute min $second sec";
  }

  returnTime(time){
    int sec = time % 60;
    int min = (time / 60).floor();
    return [sec,min];
  }

  int mainSec = 600;
  int sec = 600;
  Timer timer;

  void test(){

    timer = Timer.periodic(Duration(seconds: 1), (_) {
      int a = returnTime(mainSec-sec)[0];
      // print(a);
      if(sec==1){
        timer.cancel();
        Navigator.of(context).pop();
        showSnackBar(context,"Time over !");
      }
      setState(() {
        sec--;
      });

    });
  }

  void test2(){
  print(sec);
  print(mainSec-sec);
  print(returnTime(mainSec-sec));
  print(formatedTime(mainSec-sec));
}


  Future<void> scanBarCode() async {
    try {
      final ScanResult = await FlutterBarcodeScanner.scanBarcode(
          '#FFF44336', "Cancel", true, ScanMode.BARCODE);
      if (!mounted) return;
      if (ScanResult == Data.quizItems[0][index+1].answer) {

        showSnackBar(context,'Clue Obtained !');

        setState(() {
          index +=1;
        });

        if (index == noQuiz) {
          // Navigator.of(context).pop();
          print(returnTime(mainSec-sec));
          http.Response resp = await http.post(
            Uri.parse('https://alphaprotocol.herokuapp.com/ap/addscr'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode([
              {"otp":widget.otp,
               "level" : index,
               "minute": returnTime(mainSec-sec)[1],
                "second" : returnTime(mainSec-sec)[0]
              }
            ]
            ),
          );

          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>finalPage(img : Data.quizItems[0][index].link )));

        }
      }
      else {
        print('no');
        showSnackBar(context,'Wrong Lead !');

      }
    } on PlatformException {
      print("error");
    }
  }


  Future myFuture;
  @override
  void initState() {
    // assign this variable your Future
    myFuture = getData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop : () async {
        return true;
      },
      child:  Scaffold(
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.qr_code_scanner),
              onPressed: scanBarCode,
            ),
            appBar: AppBar(
              leading: Icon(
                Icons.timer,
              ),
              title: Text(formatedTime(sec)),
              // title: CountdownTimer(
              //   controller: controller,
              //   onEnd: onEnd,
              //   endTime: endTime, //3443343
              //   widgetBuilder: (_, CurrentRemainingTime time) {
              //     return Text(
              //         '${time.min} min ${time.sec} sec ');
              //   },
              // ),
            ),
          body: Center(child : SingleChildScrollView(
              child: Container(
            child: FutureBuilder(
                future: myFuture,
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return  SpinKitFadingCircle(
                      color: Colors.green,
                      size: 50.0,
                    );
                  } else {
                    return Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text('Vector has sent you a lead...'),
                        ),
                        InteractiveViewer(child:
                              Padding(padding: EdgeInsets.all(12.0),
                                      child :Image.network(snapshot.data[index].link))),
                              SizedBox(height :75)
                        // Padding(padding: EdgeInsets.all(16.0),
                        //         child: RaisedButton(child: Text("Scan"), onPressed: scanBarCode)),

                      ],
                    ));
                  }
                }),
          )),
          )
        ),
      );
  }
}

class QuizData {
  final String link, answer;
  QuizData(this.link, this.answer);
}

