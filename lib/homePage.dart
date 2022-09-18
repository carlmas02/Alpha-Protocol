import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:hunt/quizPage.dart';
import 'themes.dart' as Theme;

// ignore: camel_case_types
class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {

  // variables
  String resp;
  final otp = TextEditingController();
  bool isLoading  = false;

  //Snackbar
  void showSnackBar(BuildContext context,text) {
    final snackBar = SnackBar(
      content: Text(text,
        style: TextStyle(color: Color(0xff181920),
            fontFamily: GoogleFonts.varela().fontFamily),
      ),
      backgroundColor: Color(0xff64E54C),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(50),
      elevation: 20,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> logUser() async {
    http.Response resp = await http.post(
      Uri.parse('https://alphaprotocol.herokuapp.com/ap/verotp'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode([
        {"code":otp.text}
      ]),
    );

    if(resp.statusCode==200){
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>quizPage(otp : otp.text)));

    }else if(resp.statusCode==400){
      otp.clear();
      Navigator.of(context).pop();
      print('here');
      showSnackBar(context, 'Invalid Code');
    }
    // otp.clear();
  }

  int startGame() {

    showDialog(context: context, builder: (context){
      return Center(child: CircularProgressIndicator());
    });

    //logUser();
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>quizPage(otp : otp.text)));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Center(
            child: SingleChildScrollView(
                child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(height:180,image: AssetImage('assets/codex.png')),
                  Text('ALPHA PROTOCOL',style: TextStyle(color: Color(0xff656b7c))),
                  AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [

                      TypewriterAnimatedText('Into the shoes of a sleeper agent...',
                        textStyle: TextStyle(fontSize:20),
                        cursor: '|',
                        speed :Duration(milliseconds: 90)
                      ),
                    ],
                  ),
                  SizedBox(height: 55),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: 300,
                      height: 50,
                      decoration: BoxDecoration(
                        color : Color(0xff282c34),
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: TextField(
                        style: TextStyle(color: Colors.green,fontSize: 18),
                        controller: otp,
                        decoration: new InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          hintText: "Enter Code",
                          hintStyle: TextStyle(color: Color(0xff656b7c)),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),

                  ElevatedButton(
                    style: Theme.button1,
                    child: Text("Start"),

                    onPressed: () {
                      setState(() {
                        isLoading = true;
                      });
                      startGame();
                      setState(() {
                        isLoading = false;
                      });

                    },
                  )
                ],
              ),
            )),
          ),
        );
  }
}
