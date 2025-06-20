import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
// 앱 돌리기


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );// 여기서 여러페이지가 있다면 라우팅을 설정해서 사용함.
  }
}
// 메터리얼 앱 돌리기

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.blue,
  //       // 여태껏 배웟던 것들 다 합해서 영역을 잡아놓고 포함시키는 위젯임. 사각 영역에 영향을 주는 것을
  //       //모아놓은 것이 컨테이너. 그렇지만 모든 것을 다 적용하기에는 비용이 무거운 경향이 있다. 제일 많이 씀.
  //       // 그냥 쓰면 위의 영역에 침범이 감.
  //     body: SafeArea(// 시스템 영역이다.(노란색 눌르고 랩 윗 위젯)
  //       child: Container(
  //         width: 200,
  //         height: 200,// 에지 인 셋은 안의 변에 간격에 영향
  //         // padding: EdgeInsets.all(20),
  //         margin: EdgeInsets.all(20),
  //         decoration: BoxDecoration(//박스 데코레이션 위젯
  //           color: Colors.red,// 클래스에 설정한다는 식으로 두번씀
  //           border: Border.all(
  //             color: Colors.black,
  //             width: 3.0,
  //           ),
  //           boxShadow: [// 박스 그림자인데 여러개 넣을 수 있기 때문에 배열로 넣어야 함.
  //             BoxShadow(
  //               color: Colors.black.withAlpha(200),//투명도, (0~255),(불투명-투명)까지
  //               blurRadius: 10,// 퍼진 정도
  //               offset: Offset(5, 5) //틀어져서 보여주는 정도
  //             ),
  //             BoxShadow(
  //               color: Colors.redAccent.withAlpha(200),
  //               blurRadius: 10,
  //               offset: Offset(-5, -5)
  //             ),
  //           ],
  //           borderRadius: BorderRadius.circular(30)
  //         ),
  //         child: ClipRRect(
  //           borderRadius: BorderRadius.circular(30),
  //           child: Image.asset("assets/KakaoTalk_20250620_131620581.jpg",// 패딩 없애면 자식이 자기 걸 가지고 밖으로 표출됨.
  //             // width: 300,
  //             // height: 300, 숫자를 지정해도 컨테이너의 크기에 맞춰져 버림
  //             fit: BoxFit.cover
  //           ),
  //         )
  //       ),
  //     )
  //   );
  // }

  // @override
  // Widget build(BuildContext context) {//자체 크기를 안넣으면 컨테이너의 크기가 차일드에 맞춰지고, 반대로하면 컨테이너의 크기에 맞춰짐
  //   return Scaffold(
  //       backgroundColor: Colors.teal,
  //       body: SafeArea(
  //           child: Center(
  //             child: Column( //가로 세로의 정가운데에 놓음// 자기부모의 세로 영역을 다 차지함.
  //               mainAxisAlignment: MainAxisAlignment.center,//자기가 차지하고 있는 영역 안에서 정렬.(해당 축 안에서 )
  //               crossAxisAlignment: CrossAxisAlignment.center,// 가로영역은 컬럼의 가장 큰 것에 맞춰짐.
  //                 children: [
  //                   Container(
  //                       width: 200,
  //                       height: 200,
  //                       color: Colors.white,
  //                       child: Text("Container 1")
  //                   ),
  //                   Container(
  //                       width: 200,
  //                       height: 200,
  //                       color: Colors.white,
  //                       child: Text("Container 2")
  //                   ),
  //                   Container(
  //                       width: 200,
  //                       height: 200,
  //                       color: Colors.white,
  //                       child: Text("Container 3")
  //                   ),
  //                 ]
  //             ),
  //           ))
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    //자체 크기를 안넣으면 컨테이너의 크기가 차일드에 맞춰지고, 반대로하면 컨테이너의 크기에 맞춰짐
    return Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          child: Center(
            child: Row(// 자기 이름의 영역은 다 차지한것으로 간주해져서 보조축은 이동이 안됨.
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end, // 세로 영역은 다 자신의 영역이여서 헤이트가 같으면 센터는 의미가 없음.
                children: [
                  Container(
                      width: 100,
                      height: 100,
                      color: Colors.white,
                      child: Text("Container 1")
                  ),
                  Container(
                      width: 100,
                      height: 100,
                      color: Colors.white,
                      child: Text("Container 2")
                  ),
                  Container(
                      width: 100,
                      height: 100,
                      color: Colors.white,
                      child: Text("Container 3")
                  ),
                ]
            ),
          ),
        )
    );
  }



}
// 홈 돌리기

