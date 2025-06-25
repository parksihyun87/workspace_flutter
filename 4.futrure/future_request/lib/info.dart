import 'package:flutter/material.dart';

class Info{
  final int id;
  final String userName;
  final int account;
  final int balance;

  Info({required this.id, required this.userName,
  required this.account, required this.balance});

  factory Info.fromJson(Map<dynamic, dynamic> json ){// 맵형식의 json을 전달받을 때 씀. 팩토리가 붙으면 현재 클래스의 인스턴스를 리턴해야 함. (만든
    return Info(id: json['id'],
        userName: json['userName'],
      account: json['account'],
      balance: json['balance']
    );
  }// 팩토리는 info 클래스의 객체를 붙여 리턴함, 프롬 제슨에는 맵형태 제슨이 들어가고, 융통성 있는 var랑 dynamic이 있음. static은 컴파일 에 하고,
// 다이나믹은 실행시각에 영향을 받음. 다이나믹이 여러 자료를 받는 것은 이렇게 실시간으로 넣는 개념이기때문이며, var는 한번 자료형이 정해지면 계속 이어서 그 자료형만 들어갈 수 있다.
}