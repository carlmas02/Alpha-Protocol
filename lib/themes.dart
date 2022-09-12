import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonMethod {
  ThemeData themedata = ThemeData(
      primaryColor: Color(0xff64E54C),
      fontFamily: GoogleFonts.varela().fontFamily,
      appBarTheme: AppBarTheme(
        color: Color(0xff64E54C),
      ),
      primarySwatch: Colors.green,
      scaffoldBackgroundColor: Color(0xff181920),
      textTheme: TextTheme(
        bodyText1: TextStyle(fontSize: 24.0),
        bodyText2: TextStyle(fontSize: 24.0),
      ).apply(
        bodyColor:Color(0xff64E54C),)
      );
}

final ButtonStyle button1 = ElevatedButton.styleFrom(
    primary: Color(0xff64E54C),
    onPrimary: Color(0xff181920),
    minimumSize: Size(140, 50),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    textStyle: TextStyle(fontSize: 19));

