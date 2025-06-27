import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loginjwt/dice.dart';
import 'package:loginjwt/token.dart';
import 'package:loginjwt/userinfo.dart';
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';
import './token.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      //전체적인 context를 넘김.여기선 watch 못 씀.
      create: (context) => Token(),
      child: const MyApp(),
    ),
  );
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? username = null;
  String? password = null;

  bool tryValidation() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      return true;
    }
    return false;
  }

  Future<bool> loginRequest() async {
    Token provider = context.read<Token>(); // watch를 쓰면 안됨. watch는 빌드가 가능한 환경에서 써야 함. 현재 위젯의 빌드가 다시 일어날 경우 씀. 위젯을 다시 빌드하는
    // 용도로 씀. 빌드와 관계없으면 read를 씀.

    final url = Uri.parse("http://10.0.2.2:8080/login");//(유,파) 2가지
    UserInfo user = UserInfo(username: username!, password: password!);
    // final headers= {"Content-Type" : "application/json"};
    final body = user.toJson(); // 이렇게만 하면 폼 데이터 형식으로 전달이 됨. "ㅁㅁ=bb",이런 형식으로 됨.

    try {
      final response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        final token = response.headers['authorization']; // 토큰 옮겨 담음
        final refresh = response.headers['set-cookie'];
        final msg = json.decode(utf8.decode(response.bodyBytes));

        provider.refreshToken = refresh!;
        provider.accessToken = token!;
        return true;
      } else if (response.statusCode == 401) {
        final msg = json.decode(utf8.decode(response.bodyBytes));
        showSnackBar(context, msg['result']);
      } else {
        showSnackBar(context, "Error:${response.statusCode}");
      }
    } catch (e) {
      print("Error: ${e}");
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // 여기에서야 빌드되는 특정 context가 있어야 watch 사용 가능
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: Builder(
        builder: (context) {
          //이 위치에 맞는 새로운 컨텍스트를 만드는 함수.
          return GestureDetector(
            onTap: () {
              FocusScope.of(
                context,
              ).unfocus(); // 이렇게 하면 바깥을 클릭하면 포커스를 없애주는 기능인데, 센터에 디텍터를 해도
              // 자기 영역이 없어서 인식을 못함.// 얘가 mypagestate의 컨텍스트임. 최소한 scaffold의 context여야(하위의) 인식을 함.
            },
            child: SingleChildScrollView(
              //센터 해놓으면 자기 자식만큼만인데 컬럼이 다 센터를 차지함.다 차지해도 포커스를 인식함.
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  // 컬럼이 세로를 다 차지하고 있음
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(30),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              key: ValueKey(1),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "input username!!";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                username = value!;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.account_circle,
                                  color: Colors.grey,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                hintText: "username",
                                contentPadding: EdgeInsets.all(10),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              key: ValueKey(2),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "input password!!";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                password = value!;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock, color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                hintText: "password",
                                contentPadding: EdgeInsets.all(10),
                              ),
                              obscureText: true,
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                if (tryValidation()) {
                                  loginRequest().then((data) {
                                    // 변수로 어떤것이 만들어져서 넘어감. async는 안씀.
                                    if (data) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Dice(),
                                        ),
                                      );
                                    }
                                  });
                                } else {
                                  showSnackBar(context, "계정정보를 입력하세요");
                                }
                              },
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 35,
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

void showSnackBar(BuildContext context, String message) {
  // buildcontext, string 안써도 추정을 함
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, textAlign: TextAlign.center),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.green,
    ),
  );
}
