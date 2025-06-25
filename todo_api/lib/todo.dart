import 'package:flutter/material.dart';
class Todo{//dto 맞추기
  final int? id;// 아이디는 비워넣고 보낼수 있다. 오토인크리먼트
  final String title;
  final bool completed;

  Todo({this.id, required this.title, required this.completed});

  factory Todo.fromJson(Map<String,dynamic> json){
    return Todo(
      id: json['id'],
      title: json['title'],
      completed: json['completed']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id':this.id,
      'title': this.title,
      'completed': this.completed
    };
  }

}