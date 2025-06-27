import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stack_practice/signin_signup_provider.dart';

import 'config/palette.dart';

class SigninSignup extends StatelessWidget {
  const SigninSignup({super.key});

  @override
  Widget build(BuildContext context) {// 노티파이를 호출하면 빌드가 다시 호출되면서 다시 렌더링.
    SigninProvider provider= context.watch<SigninProvider>();

    return Positioned(
      top: 180,
      child: Container(
        height: provider.isSignUp ? 280 : 250,
        width: MediaQuery.of(context).size.width - 40,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(100),
              blurRadius: 10,
              offset: Offset(5, 5),
            ),
          ],
        ),
        child: SingleChildScrollView(
          // 스크롤도 가능하게 하는 위젯
          padding: EdgeInsets.only(bottom: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // 여백을 동등히 분배함
                children: [
                  GestureDetector(
                    onTap: (){
                      provider.isSignUp=false;//set의 함수가 자동으로 호출되는 형식임
                    },
                    child: Column(
                      children: [
                        Text("SIGNIN",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: !provider.isSignUp?
                              Palette.activeColor :
                              Palette.textColor1
                          ),),
                        if(!provider.isSignUp)
                          Container(
                            margin: EdgeInsets.only(top: 3),
                            height: 2,
                            width: 55,
                            color: Colors.orange,
                          )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      provider.isSignUp=true;
                    },
                    child: Column(
                      children: [
                        Text("SIGNUP",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: provider.isSignUp?
                              Palette.activeColor :
                              Palette.textColor1
                          ),),
                        if(provider.isSignUp)
                          Container(
                            margin: EdgeInsets.only(top: 3),
                            height: 2,
                            width: 55,
                            color: Colors.orange,
                          )
                      ],
                    ),
                  ),
                ],
              ),
              if(provider.isSignUp)
                Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Form(
                        key: provider.signUpFormKey,
                        child: Column(
                          children: [
                            TextFormField(//폼안의 정보들은 유효성 검사를 할 수 있음.
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.account_circle,
                                  color: Palette.iconColor,
                                ),
                                enabledBorder: OutlineInputBorder( //커서가 들어간 폼의 아웃라인이 도드라져 보이게 변형함
                                    borderSide: BorderSide(
                                        color: Palette.textColor1
                                    ),
                                    borderRadius:
                                    BorderRadius.circular(35)
                                ),
                                hintText: "User name",
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Palette.textColor2
                                ),
                                contentPadding: EdgeInsets.all(10),
                              ),
                              validator: (value){
                                if(value!.isEmpty || value.length<4){// !붙이면 null아니라고 보증해줌. isempty는 빈문자열 객체, 다트에는 널 세이프티를 넣는 거는, null .속성하는 오류를 미리 방지.
                                  return "please enter at least 4 characters";}
                                return null;// 널을 리턴하면 유효성 검사했는데 이상없다는 이야기임.
                              },//textfield안에 입력된 내용이 전달됨
                              onSaved: (value){
                                provider.userName = value!;// 널이 아님을 확신하고 넣는다.
                              },
                              key: ValueKey(1),// 키 넣기, 이거 넣어야 오류가 안남.
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(//폼안의 정보들은 유효성 검사를 할 수 있음.
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email,
                                  color: Palette.iconColor,
                                ),
                                enabledBorder: OutlineInputBorder( //커서가 들어간 폼의 아웃라인이 도드라져 보이게 변형함
                                    borderSide: BorderSide(
                                        color: Palette.textColor1
                                    ),
                                    borderRadius:
                                    BorderRadius.circular(35)
                                ),
                                hintText: "email",
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Palette.textColor2
                                ),
                                contentPadding: EdgeInsets.all(10),
                              ),
                              validator: (value){
                                if(value!.isEmpty || !value.contains("@")){// !붙이면 null아니라고 보증해줌. isempty는 빈문자열 객체, 다트에는 널 세이프티를 넣는 거는, null .속성하는 오류를 미리 방지.
                                  return "please enter a valid email address";}
                                return null;// 널을 리턴하면 유효성 검사했는데 이상없다는 이야기임.
                              },//textfield안에 입력된 내용이 전달됨
                              onSaved: (value){
                                provider.userEmail = value!;// 널이 아님을 확신하고 넣는다.
                              },
                              key: ValueKey(2),// 키 넣기, 이거 넣어야 오류가 안남.
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(//폼안의 정보들은 유효성 검사를 할 수 있음.
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.password,
                                  color: Palette.iconColor,
                                ),
                                enabledBorder: OutlineInputBorder( //커서가 들어간 폼의 아웃라인이 도드라져 보이게 변형함
                                    borderSide: BorderSide(
                                        color: Palette.textColor1
                                    ),
                                    borderRadius:
                                    BorderRadius.circular(35)
                                ),
                                hintText: "Password",
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Palette.textColor2
                                ),
                                contentPadding: EdgeInsets.all(10),
                              ),
                              obscureText: true,//동그라미로 비밀번호 보안
                              validator: (value){
                                if(value!.isEmpty || value.length<6){// !붙이면 null아니라고 보증해줌. isempty는 빈문자열 객체, 다트에는 널 세이프티를 넣는 거는, null .속성하는 오류를 미리 방지.
                                  return "please must ne at least 7 characters long";}
                                return null;// 널을 리턴하면 유효성 검사했는데 이상없다는 이야기임.
                              },//textfield안에 입력된 내용이 전달됨
                              onSaved: (value){
                                provider.userPassword = value!;// 널이 아님을 확신하고 넣는다.
                              },
                              key: ValueKey(3),// 키 넣기, 이거 넣어야 오류가 안남.
                            ),
                          ],
                        ))
                ),//2칸짜리
              if(!provider.isSignUp)
                Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Form(
                        key: provider.signInFormKey,
                        child: Column(
                          children: [
                            TextFormField(//폼안의 정보들은 유효성 검사를 할 수 있음.
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.account_circle,
                                  color: Palette.iconColor,
                                ),
                                enabledBorder: OutlineInputBorder( //커서가 들어간 폼의 아웃라인이 도드라져 보이게 변형함
                                    borderSide: BorderSide(
                                        color: Palette.textColor1
                                    ),
                                    borderRadius:
                                    BorderRadius.circular(35)
                                ),
                                hintText: "User name",
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Palette.textColor2
                                ),
                                contentPadding: EdgeInsets.all(10),
                              ),
                              validator: (value){
                                if(value!.isEmpty || value.length<4){// !붙이면 null아니라고 보증해줌. isempty는 빈문자열 객체, 다트에는 널 세이프티를 넣는 거는, null .속성하는 오류를 미리 방지.
                                  return "please enter at least 4 characters";}
                                return null;// 널을 리턴하면 유효성 검사했는데 이상없다는 이야기임.
                              },//textfield안에 입력된 내용이 전달됨
                              onSaved: (value){
                                provider.userName = value!;// 널이 아님을 확신하고 넣는다.
                              },
                              key: ValueKey(4),// 키 넣기, 이거 넣어야 오류가 안남.
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(//폼안의 정보들은 유효성 검사를 할 수 있음.
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.password,
                                  color: Palette.iconColor,
                                ),
                                enabledBorder: OutlineInputBorder( //커서가 들어간 폼의 아웃라인이 도드라져 보이게 변형함
                                    borderSide: BorderSide(
                                        color: Palette.textColor1
                                    ),
                                    borderRadius:
                                    BorderRadius.circular(35)
                                ),
                                hintText: "Password",
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Palette.textColor2
                                ),
                                contentPadding: EdgeInsets.all(10),
                              ),
                              obscureText: true,//동그라미로 비밀번호 보안
                              validator: (value){
                                if(value!.isEmpty || value.length<6){// !붙이면 null아니라고 보증해줌. isempty는 빈문자열 객체, 다트에는 널 세이프티를 넣는 거는, null .속성하는 오류를 미리 방지.
                                  return "please must ne at least 7 characters long";}
                                return null;// 널을 리턴하면 유효성 검사했는데 이상없다는 이야기임.
                              },//textfield안에 입력된 내용이 전달됨
                              onSaved: (value){
                                provider.userPassword = value!;// 널이 아님을 확신하고 넣는다.
                              },
                              key: ValueKey(5),// 키 넣기, 이거 다 다르게 넣어야 오류가 안남.
                            ),
                          ],
                        ))
                ),//3칸짜리
            ],
          ),
        ),
      ),
    );
  }
}
