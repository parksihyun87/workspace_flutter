import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterexam/examprovider.dart';
import 'package:flutterexam/userinfo.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();

  String? username = null;
  String? password = null;

  bool validation(){
    if(_formKey.currentState!.validate()){// 다 널이야 참임
      _formKey.currentState!.save();
      return true;
    }
    return false;
  }

  Future <bool> loginRequest() async{
    ExamProvider provider = context.read<ExamProvider>();
    final url = Uri.parse("http://10.0.2.2:8080/login");
    UserInfo user =UserInfo(username: username!, password: password!);
    final body = user.toJson();

    try{
      final response= await http.post(url, body: body);
      if(response.statusCode==200){
        final token = response.headers['authorization'];
        final refresh= response.headers['set-cookie'];
        final msg = json.decode(utf8.decode(response.bodyBytes));

        provider.refreshToken= refresh!;
        provider.accessToken= token!;

        return true;
      } else if(response.statusCode==401){
        final msg = json.decode(utf8.decode(response.bodyBytes));
        showSnackBar(context, msg['result']);
      } else{
        showSnackBar(context, "Error:${response.statusCode}");
      }
    }catch (e) {
      print("Error:${e}");
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:
        Colors.blueGrey[100],
        appBar: AppBar(
          title: Text("Login page",
            style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold
            ),),
          backgroundColor: Colors.blueGrey[200],
        ),
        body: Builder(
            builder: (context){
              return GestureDetector(
                onTap: (){
                  FocusScope.of(context).unfocus();
                },
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        Form(
                          key:_formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                key: ValueKey(1),
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "can't be empty";
                                  }
                                  return null;
                                },
                                onSaved: (value){
                                  username=value!;
                                },
                                decoration:
                                InputDecoration(
                                  // enabledBorder: OutlineInputBorder(
                                  //   borderSide: BorderSide(color: Colors.blueGrey),
                                  //   borderRadius: BorderRadius.circular(30)
                                  // ),
                                    prefixIcon: Icon(Icons.face),
                                    hintText:"username",
                                    contentPadding: EdgeInsets.all(10)
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                key:ValueKey(2),
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "can't be empty";
                                  }
                                  return null;
                                },
                                onSaved: (value){
                                  password=value;
                                },
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.password),
                                    hintText: "password",
                                    contentPadding: EdgeInsets.all(10)
                                ),
                                obscureText: true,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Padding(padding: EdgeInsets.all(20)),
                                  ElevatedButton(onPressed: () async {
                                    // 여기에 로그인 및 페이지 이동, 유저정보
                                    if(validation()){
                                      final response= await loginRequest();
                                      if(response){
                                        showSnackBar(context, "성공");
                                        Navigator.pushNamed(context, "/home");
                                      }
                                    }
                                  },
                                    child: Text("로그인 제출"),
                                  ),
                                  SizedBox(width: 10),
                                  ElevatedButton(onPressed: () {
                                    Navigator.pushNamed(context, "/sign");
                                  },
                                    child: Text("회원 가입"),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            })
    );
  }
}

void showSnackBar(BuildContext context, String message){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message),
        duration: Duration(seconds: 2),
      )
  );
}