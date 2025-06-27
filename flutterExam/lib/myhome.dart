import 'package:flutter/material.dart';

class Myhome extends StatelessWidget {
  const Myhome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Home"),
      ),
      drawer:MyDrawer(),
      body: Center(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 20)),
            Container(
              child: Text("Home, Home, My sweet home",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),),
            )
          ],
        ),
      ),
    );
  }
}

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.only(top: 60),
        children: [
          Column(
            children: [
              IconButton(
                  onPressed: (){
                    Navigator.pushNamed(context, "/gal");
                  },
                  icon: Icon(Icons.directions_run)),
              Text("나의 갤러리 가기"
                ,style: TextStyle(
                    fontSize: 15
                ),),
              IconButton(
                  onPressed: (){
                    Navigator.pushNamed(context, "/");
                  },
                  icon: Icon(Icons.directions_run)),
              Text("로그인 가기"
                ,style: TextStyle(
                    fontSize: 15
                ),),
              IconButton(
                  onPressed: (){
                    Navigator.pushNamed(context, "/home");
                  },
                  icon: Icon(Icons.directions_run)),
              Text("홈 가기"
                ,style: TextStyle(
                    fontSize: 15
                ),),
            ],
          ),
        ],
      ),


    );
  }
}



