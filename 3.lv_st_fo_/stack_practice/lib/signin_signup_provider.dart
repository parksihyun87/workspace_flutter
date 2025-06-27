import 'package:flutter/material.dart';

class SigninProvider extends ChangeNotifier{

  final GlobalKey<FormState> _signInFormKey= GlobalKey<FormState>();//폼 두개여서 키도 두개 필요함
  final GlobalKey<FormState> _signUpFormKey= GlobalKey<FormState>();

  bool _isSignUp = true;

  String _userName="";
  String _userEmail="";
  String _userPassword="";

  void tryValidation() {
    if (isSignUp) { // 커런트스테이트는 폼의 현재 상태에다가 밸리데이트를 호출함. 얘가 널일수 있따고 오류
      if (_signUpFormKey.currentState!
          .validate()) { // 모두 다 널을 리턴하면 이것의 결과가 true.
        _signUpFormKey.currentState!.save(); // 온세이브를 다 호출함
      }
    }

    if(!isSignUp){
      if(_signInFormKey.currentState!.validate()){
        _signInFormKey.currentState!.save();
      }
    }
  }

  GlobalKey<FormState> get signInFormKey => _signInFormKey;

  GlobalKey<FormState> get signUpFormKey => _signUpFormKey;

  bool get isSignUp => _isSignUp;

  String get userName => _userName;

  String get userEmail => _userEmail;

  String get userPassword => _userPassword;

  set userName(String value) {//검증과정을 거쳐야 의미가 있음.
    _userName = value;
  }

  set userEmail(String value) {
    _userEmail = value;
  }

  set userPassword(String value) {
    _userPassword = value;
  }

  set isSignUp(bool value) {
    _isSignUp = value;
    notifyListeners();
  } //변했을때 노티파이 리스너를 만들어주고 해당 것의 변화시 전역적인 변수 변경을 업데이트 함.
}