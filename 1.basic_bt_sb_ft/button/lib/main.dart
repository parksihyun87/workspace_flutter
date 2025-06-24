import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {// 빌드가 만들어내느 위젯
    return MaterialApp(// 첫번째 페이지 만듬
        title: 'Flutter Demo',
        home: const MyPage());
  }
}

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(// 스캐폴드는 (앱바, 바디) 2가지로 구성하게 된다. 스캐폴드가 여러가지면 화면이 여러개
      appBar: AppBar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        title: Text(
          "Buttons",
          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body:Center(// 센터는 자식을 한개만 가질 수 있다.
        child: Column(
          children: [
            TextButton(
                onPressed: (){
                  print("Text Button Clicked");
                }, //터치가 됨
              onLongPress: (){
                  print("Text 길게 누르기");
              },
                child: Text("Text Button",
                  style: TextStyle(
                    fontSize: 20.0
                  ),
                ),
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),// 텍스트버튼에 스타일 주기
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
                onPressed: (){
                  print("엘리베이트드 버튼 클릭!!!!!!!!!!!!!!");
                },
                child: Text("Elevated Button"),
            style:ElevatedButton.styleFrom(
              backgroundColor: Colors.orangeAccent,
              shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
              ),
              elevation: 10,
            ),
            ),
            SizedBox(
              height: 20.0,
            ),
            OutlinedButton(
                onPressed: (){
                  print("테두리 버튼 클릭!!!!");
                },
                child: Text("OutLinedButton"),
              style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.blue,
                side: BorderSide(
                  color: Colors.blueAccent,
                  width: 3
                )
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton.icon(
              onPressed: () {
              },
              label: Text("Text label"),
              icon: Icon(
                Icons.home,
                size: 30,
                color: Colors.orangeAccent,
              ),
              style: TextButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white
              ),
            ),
            SizedBox(height: 20.0)
            ,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: (){

                },
                child: Text("Text button"),

                ),
                ElevatedButton(
                    onPressed: (){

                    },
                    child: Text("Text button"))
              ],
            )
          ],
        ),
      ) ,
    );
  }
}
