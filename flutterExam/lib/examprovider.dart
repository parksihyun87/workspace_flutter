import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExamProvider extends ChangeNotifier{
  final GlobalKey<FormState> _formKey_sign= GlobalKey<FormState>();

  String? _accessToken= null;
  String? _refreshToken= null;

  String _userName="";
  String _userPassword="";


  String get accessToken => _accessToken!;

  set accessToken(String value) {
    _accessToken = value;
  }

  String get refreshToken => _refreshToken!;

  set refreshToken(String value) {
    _refreshToken = value;
  }

  GlobalKey<FormState> get formKey_sign => _formKey_sign;

  set formKey_sign(GlobalKey<FormState> value) {
    _formKey_sign != value;
  }

  String get userPassword => _userPassword;

  set userPassword(String value) {
    _userPassword = value;
  }

  String get userName => _userName;

  set userName(String value) {
    _userName = value;
  }
}
