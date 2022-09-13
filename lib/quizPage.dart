import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hunt/finalPage.dart';
import 'package:hunt/main.dart';
import 'package:http/http.dart' as http;
import 'data.dart' as Data;

// unused imports
// import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
// import 'package:flutter_countdown_timer/current_remaining_time.dart';
// import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';



class quizPage extends StatefulWidget {
  String otp;
  quizPage({@required this.otp});


  @override
  _quizPageState createState() => _quizPageState();
}

class _quizPageState extends State<quizPage> {
  // Clues indexing
  int index = 0;
  int noQuiz = 8; //length -1
  int quizIndex;


  //timer
  int mainSec = 600;
  int sec = 600;
  Timer timer;

  //Snackbar
  void showSnackBar(BuildContext context, text) {
    final snackBar = SnackBar(
      content: Text(
        text,
        style: TextStyle(
            color: Color(0xff181920),
            fontFamily: GoogleFonts.varela().fontFamily),
      ),
      backgroundColor: Color(0xff64E54C),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(50),
      elevation: 20,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  //Countdown timer to display on Appbar
  formatedTime(time) {
    int sec = time % 60;
    int min = (time / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute min $second sec   $widget.otp";
  }

  // Time to return for API post
  returnTime(time) {
    int sec = time % 60;
    int min = (time / 60).floor();
    return [sec, min];
  }

  // countdown timer function
  void countTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {

      if(sec==1){
        timer.cancel();
        test2();
        Navigator.of(context).pop();
        showSnackBar(context,"Time over !");
      }
      setState(() {
        sec--;
      });
    });
  }

  // BarCode scanning Function
  Future<void> scanBarCode() async {
    print(widget.otp);
    try {
      final ScanResult = await FlutterBarcodeScanner.scanBarcode(
          '#FFF44336', "Cancel", true, ScanMode.BARCODE);
      if (!mounted) return;
      if (ScanResult == Data.quizItems[0][index + 1].answer) {
        showSnackBar(context, 'Clue Obtained !');

        setState(() {
          index += 1;
        });

        if (index == noQuiz) {
          timer.cancel();
          // Navigator.of(context).pop();
          print(returnTime(mainSec - sec));
          http.Response resp = await http.post(
            Uri.parse('https://alphaprotocol.herokuapp.com/ap/addscr'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode([
              {
                "otp": widget.otp,
                "level": index,
                "minute": returnTime(mainSec - sec)[1],
                "second": returnTime(mainSec - sec)[0]
              }
            ]),
          );

          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  finalPage(img: Data.quizItems[0][index].link)));
        }
      } else {
        print('no');
        showSnackBar(context, 'Wrong Lead !');
      }
    } on PlatformException {
      print("error");
    }
  }

  // testing function nothing imp
  Future<void> test2() async {
    print('hi func');
    http.Response resp = await http.post(
      Uri.parse('https://alphaprotocol.herokuapp.com/ap/addscr'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode([
        {
          "otp": widget.otp,
          "level": index,
          "minute": returnTime(mainSec - sec)[1],
          "second": returnTime(mainSec - sec)[0]
        }
      ]),
    );

    print(resp.statusCode);
  }

  // actual app code
  @override
  void initState() {
    countTimer();
    // quizIndex = int.parse(widget.otp[3]) -1 ;
    quizIndex =1;
    print('here');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.qr_code_scanner),
            onPressed: scanBarCode,
            // onPressed: test2,
          ),
          appBar: AppBar(
            leading: Icon(
              Icons.timer,
            ),
            title: Text(formatedTime(sec)),
          ),
          body: Center(
            child: SingleChildScrollView(
                child: Container(
                    child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('Vector has sent you a lead...'),
                ),
                InteractiveViewer(
                    child: Padding(
                  padding: EdgeInsets.all(12.0),
                  // child : Image.network(Data.quizItems[0][index].link)
                  child: CachedNetworkImage(
                    imageUrl: Data.quizItems[quizIndex][index].link,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                )),
                SizedBox(height: 75)
              ],
            ))),
          )),
    );
  }
}
