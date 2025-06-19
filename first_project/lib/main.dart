import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});// 키는 위젯들을 구분하는 용도, 키에는 객체가 들어감

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(),// 첫번째 페이지 재정의 해야 함
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {// 이제 new없고 스캐폴드로 한화면을 만듦 한화면 내용 모두가 스캐폴드에 들어가야 함. 위젯 안에 모든 내용 넣기
    return Scaffold(// 스캐폴드를 만드는 중
      backgroundColor: Colors.amber[800],//색의 진하기 정도 0-900
      appBar: AppBar(
        title: Text("Cookie Man"),
        backgroundColor: Colors.amber[700],// 앱바의 배경 색
        foregroundColor: Colors.deepPurple,
        centerTitle: true,// 글자 가운데 정렬, 지금까지 하나의 화면에서 앱바까지만 끝남
      ),// 트레일러 레이블이라고 어느 위젯의 끝인지 표현해줌
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 0.0, 0.0),//패딩은 엣지 인셋을 쓰고 먹여줌.
        child: Column( //세로로 배치하려고 이렇게 만듦
          // 주축과, 보조축 두가지의 구분을 할 수 있다. mainaxis를 center로 하면 세로로 가운데, crossaxis 가로로 나눔
          crossAxisAlignment: CrossAxisAlignment.start,// 수평축에 대하여 수평축 시작.
          children: [// 칠드런임.위젯을 배치하다 보면 차일드와 칠드런이 있음, 여러 명을 가질수 있는가의 차이다. 센터나 패딩은 자식으로 하나만 둘 수 있다.
            Center(// 뭔가를 정가운데에 넣을때에 넣는 위젯 (세로가로 모두 가운데 놓겠다.) 센터는 차일드로 하나만 가능하다.
              child: Image.asset("assets/KakaoTalk_20250619_145656382.gif",
              width: 100,
              height: 100,),
            ),
            Divider(// 분리선을 그어주는 위젯
              height: 100.0,// 위에서 얼마만큼 떨어진 자리에 이것을 놓겠다.// 헤이트는 구분선을 만들면서 일정거리 띄운다.
              color: Colors.grey[850],
              thickness: 1,
              endIndent: 30.0,
            ),
            Text("Cookie Run",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 2.0,
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(
              height: 10.0,//빈공간인데 위드, 헤이트로 가세 줌
            ),
            Text("출생연도",
            style: TextStyle(
              color: Colors.white,
              letterSpacing:  2.0,

            ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text("1875",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 2.0,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(// 가로로 늘일것이며 컬럼의 자식 중 하나
              children: [
                Icon(Icons.check_circle_outline),
                SizedBox(
                  width: 10.0,
                ),
                Text("슈렉",
                  style: TextStyle(
                    fontSize: 16.0,
                    letterSpacing: 2.0,
                  ),
                )
              ],
            ),
            Row(// 크기 지정안하면 한줄 다 먹음
              children: [
                Icon(Icons.check_circle_outline),
                SizedBox(
                  width: 10.0,
                ),
                Text("장화신은 고양이",
                  style: TextStyle(
                    fontSize: 16.0,
                    letterSpacing: 2.0,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/KakaoTalk_20250619_145657114.gif"),
                radius: 100.0,// 반지름 안에 넣음,
                backgroundColor: Colors.amber[800],
              ),//모서리가 둥근 셰잎으로 이미지를 넣어줌
            )
          ],
        ),
      ),
    );
  }
}
