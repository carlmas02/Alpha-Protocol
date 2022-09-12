import 'dart:convert';

import 'package:flutter/material.dart';
import 'themes.dart' as Theme;
import 'package:http/http.dart' as http;

class startPage extends StatefulWidget {
  @override
  _startPageState createState() => _startPageState();
}

class _startPageState extends State<startPage> {

  Future<void> getData() async {
    http.Response resp = await http
        .get(Uri.parse('https://alphaprotocol.herokuapp.com/ap/getintro'));
    var jsonData = jsonDecode(resp.body);

    return (jsonData[0]);
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theme.CommonMethod().themedata,
      home: Scaffold(
        body: Center(
            child: SingleChildScrollView(child: Container(
              child: FutureBuilder(
                  future: getData(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return Container(child: Text('Loading...'));
                    } else {
                      return Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(snapshot.data),

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
