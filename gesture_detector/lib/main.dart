import 'package:flutter/material.dart';
import '';
import 'second_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        initialRoute: "/", //처음 시작 경로
        routes: {
          "/": (context) => GestureDetectorApp(),
          "/second": (context) => SecondPage(),
        }
    );
  }
}

class GestureDetectorApp extends StatelessWidget {
  const GestureDetectorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GestureDetectorApp"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      backgroundColor: Colors.amber[600],
      body: Center(
        child: GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, "/second");
          },
          child: Container(
            width: 200,
            height: 200,
            alignment: Alignment.center,
            child: Text("Click me",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.pink,
                  fontWeight: FontWeight.bold
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              border: Border.all(
                color: Colors.white,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withAlpha(200),
                    blurRadius: 10,
                    offset: Offset(5, 5)
                )
              ],
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
