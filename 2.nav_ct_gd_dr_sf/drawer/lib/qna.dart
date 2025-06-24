import 'package:flutter/material.dart';

class Qna extends StatelessWidget {
  const Qna({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.purple[300],
      appBar: AppBar(
        // backgroundColor: Colors.purple[200],
        title: Text("큐앤에입니다."),

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
                  backgroundImage: AssetImage("assets/monday.gif"),
                  radius: 70,
                ),
              ),
              Text("큐앤에입니다.",
                // style: TextStyle(
                    // fontSize: 50,
                    // fontWeight: FontWeight.bold
                // ),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        )
    );
  }
}
