import 'package:flutter/material.dart';
import 'package:flutterexam/examprovider.dart';
import 'package:flutterexam/gallery.dart';
import 'package:flutterexam/login.dart';
import 'package:flutterexam/myhome.dart';
import 'package:flutterexam/signup.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      ChangeNotifierProvider(
        create: (context) => ExamProvider(),
        child: const RouteTree(),
      )
  );
}

class RouteTree extends StatelessWidget {
  const RouteTree({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Total Page',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueGrey[200],
        ),
      scaffoldBackgroundColor: Colors.blueGrey[100],//여러 페이지 걸친 색상
      ),
      initialRoute: "/",
      routes: {//루,비,콘
        "/" : (context)=>Login(),
        "/home": (context)=>Myhome(),
        "/sign": (context)=>SignUp(),
        "/gal":(context)=>Gallery()
      },
    );
  }
}



