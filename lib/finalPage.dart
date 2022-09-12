import 'package:flutter/material.dart';
import 'themes.dart' as Theme;

class finalPage extends StatefulWidget {

  String img;

  finalPage({@required this.img}) ;

  @override
  _finalPageState createState() => _finalPageState();
}

class _finalPageState extends State<finalPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          appBar: AppBar(
            title: Text('Treasure Hunt'),
            foregroundColor: Colors.black,
          ),
          body: Center(
            child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(widget.img),
                    ],
                  ),
                )),
          ),
        );
  }
}
