import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_api/todo.dart';
import 'package:http/http.dart' as http;
//투ㅌ두

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
  List<Todo>? todoList = null; // 투두를 받을 변수 준비.// 안들어왔으면 렝스가 없음
  String? errorMessage = null;
  late final Future<void> _fetchData;//강사님은 ?없는데 있어야 오류가 안남.

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData = fetchData();
  }

  Future<void> fetchData() async {
    final url = Uri.parse(
      "http://10.0.2.2:8080/todo-list",
    ); //플러터 에뮬레이터가 돌고 있음. 근데 이건 이 기계 안에 보인다는 뜻이 됨. 바깥 호스트를 지칭해야 함.10.0.2.2
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(
          utf8.decode(response.bodyBytes),
        ); // 전달이 모두 영문이나 숫자면 이게 괜찮은데, 한글이 들어가면 한단계 더 적용해야 함. 자료형은 안써도 자동 형변해줌. 바이트 스트링을
        // 유니코드 중 utf8로 해석하겠다는 뜻임.
        //final List<Map<String, dynamic>>,final List<dynmamic>, final 세개 다 표시는 맞지만 List 다이나믹으로 해야 리스트로 인식
        setState(() {
          todoList = responseData
              .map((json) => Todo.fromJson(json))
              .toList(); // 맵은 투두객체들의 이터러블영향을 받은 배열을 리턴함. 이터러블한 투두를 리턴 리스트는 이터라블을 상속받음. Iterable<Todo> map은 이터러블에서 받은거임. 근데 완전 리스트는 아님.toLIst해야 바뀜
        }); // 이래야 해당 리스트가 렌더링이 다시 됨
      } else {
        setState(() {
          errorMessage = "Error:${response.statusCode}";
        });
      }
    } catch (e) {
      print("error: ${e}");
    }
  }

  Future<void> sendData() async{
    final url = Uri.parse("http://10.0.2.2:8080/todo");
    final headers = {"Content-Type": "application/json"};
    // final body = json.encode(Todo(title: "달리기", completed: false).toJson());
    final body = {"title":"달리기", "completed":false};

    try{
      final response = await http.post(url, headers: headers, body: json.encode(body));
      if(response.statusCode == 200) {
        final responseData = json.decode(utf8.decode(response
            .bodyBytes)); // 맵객체가 넘어감 Map<String, dynamic>해도 되고, 지워도 됨, 리스트면 리스트라는건 명시해야 함.

        Todo todo = Todo.fromJson(responseData);
        setState(() {
          todoList?.add(todo);
        });

      }else{
        setState(() {
          errorMessage="error:"+response.statusCode.toString();
        });
      }
    }catch(e){
      print("Error:${e}");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todo list")),
      body: FutureBuilder(
        future: _fetchData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return Center(
              child: Column(
                //리스트뷰는 다 차지하려고 함.
                children: [
                  Expanded(
                    //엘리버튼 들어가고, 익스팬디는 남는 자리를 들어가겟다.
                    child: ListView.builder(
                      //
                      itemCount: todoList!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(todoList![index].title),
                          trailing: Icon(
                            todoList![index].completed
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            color: todoList![index].completed
                                ? Colors.green
                                : Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(onPressed: () {
                    sendData();
                  }, child: Text("TODO 추가")),
                ],
              ),
            );
          }
        }
      )
    );
  }
}




// @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: Text("Get Request Example")),
  //     body: Center(
  //       child: Column(
  //          else
  //         //리스트뷰는 다 차지하려고 함.
  //         children: [
  //           Expanded(
  //             //엘리버튼 들어가고, 익스팬디는 남는 자리를 들어가겟다.
  //             child: ListView.builder(
  //               //
  //               itemCount: todoList!.length,
  //               itemBuilder: (context, index) {
  //                 return ListTile(
  //                   title: Text(todoList![index].title),
  //                   trailing: Icon(
  //                     todoList![index].completed
  //                         ? Icons.check_circle
  //                         : Icons.radio_button_unchecked,
  //                     color: todoList![index].completed
  //                         ? Colors.green
  //                         : Colors.grey,
  //                   ),
  //                 );
  //               },
  //             ),
  //           ),
  //           ElevatedButton(onPressed: () {},
  //               child: Text("TODO 추가")),
  //           if(errorMessage !=null)
  //             Text(errorMessage!,
  //               style: TextStyle(
  //                 fontSize: 20
  //               ),
  //             )
  //         ],
  //       ),
  //     ),
  //   );
  // }

