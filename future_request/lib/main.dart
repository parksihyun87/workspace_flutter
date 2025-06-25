import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './info.dart';
import 'dart:async';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyPage(),
    );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  late Future<Info> _fetchData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData=fetchInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("계좌정보 확인하기"),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder(
            future: _fetchData,
            builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.done){// 정상적이아니여도 끝나면 밑을 렌더링 시키므로 하나더 묻는게 필요
                if(snapshot.hasData){
                  // 스냅샷에 데이터가 잇는지 물어봄
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("고객번호:" + snapshot.data!.id.toString(),//info 객체가 넘어가므로
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                      Text("고객명:" + snapshot.data!.userName,
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                      Text("계좌번호:" + snapshot.data!.account.toString(),
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                      Text("잔액:" + snapshot.data!.balance.toString(),
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                    ],
                  );
                } else if(snapshot.hasError){
                  return Text("${snapshot.error}");
                }
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }

  Future<Info> fetchInfo() async{
    Uri url= Uri.parse("https://my.api.mockaroo.com/bank.json?key=fea24270");// 먼저 uri객체로 만든 후에 실행.
    final response = await http.get(url);//자료형 안쓰면 var로 인식함.
    if(response.statusCode == 200) {
      return Info.fromJson(json.decode(response.body));//응답이 여기서는 response.body에 들어있음, 지금은 바이트스트림 형태이며 맵형태가 원형이여서 거기에 맞추는게 필요하며 맵형식으로 만들어서 fromjson에 넘김
    }
    else{
      throw Exception("계좌정보를 불러오는데 실패하였습니다.");
    }
  }
}

