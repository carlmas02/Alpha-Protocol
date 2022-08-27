import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonMethod {

  ThemeData themedata = ThemeData(
      primaryColor: Colors.black,
      fontFamily: GoogleFonts.lato().fontFamily,
      appBarTheme: AppBarTheme(
        color: Color(0xff52ad45),
      ),
      // textButtonTheme: TextButtonThemeData(
      //   style: TextButton.styleFrom(
      //     primary: Colors.teal,
      //   ),
      //  ),
      scaffoldBackgroundColor: Colors.black,
      textTheme: TextTheme(
        bodyText1: TextStyle(fontSize: 24.0),
        bodyText2: TextStyle(fontSize: 24.0),
      ).apply(
        bodyColor: Color(0xff52ad45),
      ));
}

final ButtonStyle button1 = ElevatedButton.styleFrom(
  primary: Color(0xff52ad45),
  onPrimary: Colors.black,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
  textStyle: TextStyle(fontSize: 19)
);

// final InputDecoration decor1 =  ;