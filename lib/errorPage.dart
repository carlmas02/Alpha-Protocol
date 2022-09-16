import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class errorPage extends StatefulWidget {
  String otp;
  int level;
  double time;
  errorPage(
      {@required this.otp,
      @required this.level,
      @required this.time,});

  @override
  _errorPageState createState() => _errorPageState();
}

class _errorPageState extends State<errorPage> {
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

  Future<void> test2() async {
    try {
      http.Response resp = await http.post(
        Uri.parse('https://alphaprotocol.herokuapp.com/ap/addscr'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode([
          {
            "otp": widget.otp,
            "level": widget.level,
            "time" : widget.time
          }
        ]),
      );

      showSnackBar(context, "Response Saved !");
      Navigator.of(context).pop();
    } on SocketException catch (e) {
      showSnackBar(context, "Please be connected to the network");
    } on Error catch (e) {
      showSnackBar(context,e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Please Connect to Network to submit responses !",
              textAlign: TextAlign.center),
            Center(
                child: ElevatedButton(
                    child: Text('Submit score details !'),
                    onPressed: () {
                      test2();
                    })),
          ],
        ),
      ),
    );
  }
}
