import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Toast Message"),
        centerTitle: true,
      ),
      body: Center(
        child: TextButton(
            onPressed: (){
              flutterToast();
            },
            child: Text("Toast",
            style: TextStyle(
              fontSize: 20
            ),
            ),
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            )
          )
        ),
      )
    );
  }

  void flutterToast(){// 중간에 띄워지는 것임.
    Fluttertoast.showToast(
      msg: "Flutter Toast",
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.redAccent,
      fontSize: 30,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT
    );
  }
}

