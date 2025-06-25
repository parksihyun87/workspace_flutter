import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', home: MyPage());
  }
}

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String result = "no data";
  late Future<void> _futureData;// 레이트 퓨처에 보이드?

  @override
  void initState() {//생성될 때 한번
    // TODO: implement initState
    super.initState();
    _futureData = futureTest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Future Test"), centerTitle: true),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  futureTest();
                  print("버튼 눌림");
                },
                child: Text("Future test", style: TextStyle(fontSize: 20)),
              ),
              SizedBox(height: 20),
              Text(
                result,
                style: TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              Divider(height: 20, thickness: 2),
              FutureBuilder(
                future: _futureData,// 그냥 넣으면 흐름에 의해 계속 호출됨
                builder: (context, snapshot) {// future의 비동기 내용을 따라 스냅샷이 계속 변함.
                  if(snapshot.connectionState == ConnectionState.done) { // 진행, 완료를 계속 캐치함. 커넥션 스테이트 돈은 완료라는 의미
                    return Text(result,//스냅샷의 데이터(마이퓨처함수의 리턴이 됨)가 Object형으로 리턴되므로 스트링으로 캐스팅해서 보여주겠다.
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue
                      ),
                    );
                  }
                  return CircularProgressIndicator();// 완료 되지 않으면 얘를 리턴하겠다. 동글뱅이.
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> futureTest() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      result = "The data is fetched";
    });
  }

  Future<String> myFuture() async {
    await Future.delayed(Duration(seconds: 2));
    return 'another Future completed';
  }
}

// print("3초 경과");
// print("첫번째");
// print("두번째");
