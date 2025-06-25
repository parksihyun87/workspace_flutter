import 'package:flutter/material.dart';
import 'package:stack_practice/background.dart';
import 'package:stack_practice/config/oauth2.dart';
import 'package:stack_practice/config/palette.dart';
import 'package:stack_practice/singin_signup.dart';
import 'package:stack_practice/submit.dart';
import 'package:provider/provider.dart';
import './signin_signup_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (context)=> SigninProvider(),
      child: MyApp(),)
    );// 프로바이더로 임포트해서 등록시키는 과정임.
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', home: MyHome());
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(),
          SigninSignup(),
          Submit(),
          Oauth2()
        ],
      ),
    );
  }
}
