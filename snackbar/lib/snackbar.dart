import 'package:flutter/material.dart';

class MySnackBar extends StatelessWidget {//위젯 클래스를 새로 만든 것임. 바
  const MySnackBar({super.key});

  @override
  Widget build(BuildContext context) {// 빌드해서 컨텍스트 가 넘어옴,.
    // 플러터는 전부 빌드 트리로 되어있음.
    // 앱바에 들어가는 위젯, 바디에 들어가는 위젯,
    // 이 위젯이 어느 트리에 담겨있나 정보를 담은게 컨텍스트
    // 빌드가 호출이 되면 현재의 위젯이 어느 위치 정보에 담겨있는지가 전달이 됨.
    // 현재 위젯에 대한 정보가 담겨있는 정보. 객체. 마이 스낵바라는 위젯에 대한 것임.
    // 부모인 스캣 폴드안쪽에 위치했다는 위치정보를 담고 잇다. 자기 자신의 정체 정보를 담고 있음.
    // 빌드 함수가 호출될 때 자신의 정보가 컨텍스트로 넘어온다. 제일 중요한 것은 위젯트리상 위치.
    return Center(
      child: ElevatedButton(
        onPressed: (){
          ScaffoldMessenger.of(context).showSnackBar(// 정보를 넘겨주면 스캣폴드메신저가 스낵바를 만들어서 보여라. 이 위젯의 소속된 스캐폴드의 스낵바를 보여라.(소속을 연동시켜야 함)
            SnackBar(
                backgroundColor: Colors.teal,
                content: Text("Hello",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                  ),
                ),
              duration: Duration(milliseconds: 3000),// 버튼을 누르면 3초 있다가 내려감.
              action: SnackBarAction(// 액션안눌러도 닫히지만 부가 액션을 연동하고 싶으면 여기에 적으며, 부가 상품을 구매하겠습니까 같은 내용을 넣음.
                  label: "Close",
                  onPressed: (){
                    print("스낵바 닫힘");
                  }),
            )
          );
        },
        child: Text("Show me",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.orangeAccent
        ),
      ),
    );
  }
}