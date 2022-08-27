import 'package:flutter/material.dart';
import 'package:hunt/homePage.dart';
import 'package:hunt/quizPage.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Treasure Hunt',
      theme: ThemeData(
        primaryColor: Colors.green
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => homePage(),
        '/quiz' : (context) => quizPage(),

      },
    );
  }
}

