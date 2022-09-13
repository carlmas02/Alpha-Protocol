import 'package:flutter/material.dart';
import 'package:hunt/homePage.dart';
import 'package:hunt/quizPage.dart';
import 'package:hunt/startPage.dart';
import 'package:hunt/testPage.dart';
import 'themes.dart' as Theme;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theme.CommonMethod().themedata,
      debugShowCheckedModeBanner: false,
      title: 'Treasure Hunt',
      initialRoute: '/',
      routes: {
        '/': (context) => homePage(),
        '/test' : (context) => testPage(),
        '/intro': (context) => startPage(),
        '/quiz': (context) => quizPage(),
      },
    );
  }
}
