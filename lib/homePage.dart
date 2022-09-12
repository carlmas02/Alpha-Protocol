import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
import 'package:hunt/quizPage.dart';
import 'themes.dart' as Theme;

// ignore: camel_case_types
class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  String resp;
  final otp = TextEditingController();

  int startGame() {
    // print(otp.text);
    // Navigator.pushNamed(context, '/quiz');
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
                      startGame();

                    },
                  )
                ],
              ),
            )),
          ),
        );
  }
}
