import 'package:flutter/material.dart';

class UserInfo{
  final String username;
  final String password;

  UserInfo({required this.username, required this.password});

  factory UserInfo.fromJson(Map<String, dynamic> json){
    return UserInfo(
        username: json['username'],
        password: json['password']
    );
  }
  // 서버 데이터로 맵 json으로 객체 만들기(폼 데이터 전송등에 사용)

  Map<String, dynamic> toJson(){
    return{
      "username":this.username,
      "password":this.password
    };
  }
  // api보낼 다음 단계 준비 위해 객체로 맵을 만드는 함수.
}