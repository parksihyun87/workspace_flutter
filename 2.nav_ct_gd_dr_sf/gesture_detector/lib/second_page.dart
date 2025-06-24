import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Page"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: Colors.purple,
      body: Center(
        child: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/KakaoTalk_20250620_131620581.jpg"),
            radius: 100,
          ),
        ),
      )
    );
  }
}
