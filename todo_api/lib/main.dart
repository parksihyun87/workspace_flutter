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
  List<Todo>? todoList=null;// 투두를 받을 변수 준비.


  Future<void> fetchData() async{
    final url = Uri.parse("http://10.0.2.2:8080/todo-list");//플러터 에뮬레이터가 돌고 있음. 근데 이건 이 기계 안에 보인다는 뜻이 됨. 바깥 호스트를 지칭해야 함.10.0.2.2
    try{
      final response= await http.get(url);
      if(response.statusCode==200){
        final List<Map<String, dynamic>> responseData = json.decode(utf8.decode(response.bodyBytes));// 전달이 모두 영문이나 숫자면 이게 괜찮은데, 한글이 들어가면 한단계 더 적용해야 함. 자료형은 안써도 자동 형변해줌.
        //final List<Map<String, dynamic>>,final List<dynmamic>, final 세개 다 됨

        todoList = responseData.map((json)=>Todo.fromJson(json)).toList();// 맵은 투두객체들의 배열을 리턴함. 이터러블한 투두를 리턴 리스트는 이터라블을 상속받음. Iterable<Todo> map은 이터러블에서 받은거임. 근데 완전 리스트는 아님.
      }
    }catch(e){
      print("error: ${e}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get Request Example"),
      ),
      body: Center(
        child: Column(//리스트뷰는 다 차지하려고 함.
          children: [
            Expanded(//엘리버튼 들어가고, 익스팬디는 남는 자리를 들어가겟다.
                child: ListView.builder(//
                    itemCount: todoList!.length,
                    itemBuilder: (context,index){
                      return ListTile(
                        title: Text(todoList![index].title),
                        trailing: Icon(
                          todoList![index].completed?
                              Icons.check_circle:
                              Icons.radio_button_unchecked,
                          color: todoList![index].completed?
                            Colors.green: Colors.grey
                        ),
                      );
                    })
            ),
            ElevatedButton(
                onPressed: (){

                },
                child: Text("TODO 추가"))
          ],
        ),
      ),
    );
  }
}

