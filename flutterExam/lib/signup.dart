import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterexam/examprovider.dart';
import 'package:flutterexam/userinfo.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? username = null;
  String? password = null;


  @override
  Widget build(BuildContext context) {
    ExamProvider provider = context.read<ExamProvider>();
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        title: Text(
          "SingUp page",
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey[200],
      ),
      body: Builder(
        builder: (context) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Form(
                      key: provider.formKey_sign,
                      child: Column(
                        children: [
                          TextFormField(
                            key: ValueKey(1),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "can't be empty";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              username = value!;
                            },
                            decoration: InputDecoration(
                              // enabledBorder: OutlineInputBorder(
                              //   borderSide: BorderSide(color: Colors.blueGrey),
                              //   borderRadius: BorderRadius.circular(30)
                              // ),
                              prefixIcon: Icon(Icons.face),
                              hintText: "username",
                              contentPadding: EdgeInsets.all(10),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            key: ValueKey(2),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "can't be empty";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              password = value;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.password),
                              hintText: "password",
                              contentPadding: EdgeInsets.all(10),
                            ),
                            obscureText: true,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Padding(padding: EdgeInsets.all(20)),
                              ElevatedButton(
                                onPressed: () async {
                                  // 여기에 로그인 및 페이지 이동, 유저정보
                                  if (validation()) {
                                    final response = await signInRequest();
                                    if (response) {
                                      Navigator.pushNamed(context, "/home");
                                    }
                                  }
                                },
                                child: Text("회원가입 제출"),
                              ),
                            ],
                          ),
                        ],
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

  bool validation() {
    ExamProvider provider = context.read<ExamProvider>();
    if (provider.formKey_sign.currentState!.validate()) {
      
      provider.formKey_sign.currentState!.save();
      return true;
    }
    return false;
  }

  Future <bool> signInRequest() async {
    ExamProvider provider = context.read<ExamProvider>();
    final url = Uri.parse("http://10.0.2.2:8080/join");
    UserInfo user = UserInfo(username: username!, password: password!);
    final headers = {"Content-Type": "application/json"};
    final body = json.encode(user.toJson());

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
        // final msg = json.decode(utf8.decode(response.bodyBytes));
         showSnackBar(context, "가입 성공 하였습니다.");
        return true;
      }else if(response.statusCode == 409){
        showSnackBar(context, "이미 가입한 유저입니다.");
      }
      else {
        showSnackBar(context, "${response.statusCode}");

      }
    } catch (e) {
      print("Error:${e}");
    }
    return false;
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message),
          duration: Duration(seconds: 2),
        )
    );
  }
}
