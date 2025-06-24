import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.purple[300],
      appBar: AppBar(
        // backgroundColor: Colors.purple[200],
        title: Text("홈입니다."),

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/gif5.gif"),
                radius: 70,
              ),
            ),
            Text("홈 화면 입니다.",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),
            ),
          ],
        ),
      )
    );
  }
}
