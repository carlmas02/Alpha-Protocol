import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'themes.dart' as Theme;

// ignore: camel_case_types
class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {

  String resp;
  final codeController = TextEditingController();

  Future<void> test() async{
    http.Response resp = await http.get(Uri.parse('https://reqres.in/api/users/2'));

    if(resp.statusCode==200){
      print(resp.body);
    }

  }

  int startGame(){
    print(codeController.text);
    Navigator.pushNamed(context, '/quiz');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.CommonMethod().themedata,
      home : Scaffold(
        appBar: AppBar(title: Text('Treasure Hunt'),foregroundColor: Colors.black,),
        body: Center(
            child: Container(
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(image: AssetImage('assets/codex.jpg')),
               SizedBox(height: 10),
               TextFormField(
            decoration: new InputDecoration(
              labelText: "Enter Code",
              fillColor: Colors.grey,
              enabledBorder: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                  color: Colors.blue,
                ),
              ),

            ),

          ),




              ElevatedButton(
                  style: Theme.button1,
                  child:Text("Start"),
                  onPressed:() {
                    startGame();
                  },

              )
            ],
            ),
          )
        ),
      )
    );
  }
}
