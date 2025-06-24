import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Kangwon FC', home: const MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[300],
      appBar: AppBar(
        title: Text(
          "LG Twins",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        backgroundColor: Colors.purple[400],
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(// 동그랗게 만들기.
              backgroundImage: AssetImage(//
                "assets/KakaoTalk_20250620_131620581.jpg",
              ),
              radius: 60.0,
            ),
            Divider(
              height: 60.0,
              color: Colors.purple[800],
              thickness: 5.0,
              endIndent: 0.0,
            ),
            Text(
              "Team Name",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 2.0,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "LG Twins",
              style: TextStyle(color: Colors.white, fontSize: 30.0),
            ),
            SizedBox(height: 20.0),
            Text(
              "창단연도",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 2.0,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "1990",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              "창단연도",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 2.0,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton.icon(
              style: TextButton.styleFrom(
                padding:EdgeInsets.zero
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text("우승할겁니다.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.amberAccent,
                          ),
                        ),
                        duration: Duration(milliseconds: 3000)
                    )
                );
              },
              label: Text("1990, 1994, 2023",
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold
                ),),
              icon: Icon(Icons.local_cafe),
            ),
            SizedBox(height: 20.0),
            Text(
              "현 감독",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 2.0,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton.icon(
                style: TextButton.styleFrom(
                    padding:EdgeInsets.zero
                ),
                onPressed: () {
                  flutterToast();
                },
                label: Text("염 경 엽",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold
                    )
                ),
                icon: Icon(Icons.local_cafe)
            )
          ],
        ),
      ),);
  }
}

void flutterToast() {
  Fluttertoast.showToast(
      msg: "경질?",
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.redAccent,
      fontSize: 30,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT
  );
}