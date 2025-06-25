import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stack_practice/signin_signup_provider.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {// 컨텍스트를 통하여 프로바이더의 위치 정보를 통해 가져온다.
    SigninProvider provider= context.watch<SigninProvider>();

    return Positioned(
      // 포지션이 부모인데 띄워지는게 없으니, 본 화면을 전체를 받아들이며, 높이만 300으로 잡는다.
      top: 0,
      right: 0,
      left: 0, // 위 아래 오른쪽 0으로 하여 꽉 채움.
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/KakaoTalk_20250624_154239472.jpg"),
            //이.어 : 정식이미, 어이: 배경등의 이미지
            fit: BoxFit.fill, //박스핏에 가득채워서.
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(top: 90, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ElevatedButton(onPressed: (){
              //   Navigator.pop(context);
              // }, child: Text("버튼")),
              //RichText는 텍스트 안에 다양한 스타일로 표현하게 함. span처럼 작용함. 텍스트 스판은 처음에 나오는 대상
              RichText(
                text: TextSpan(
                  text: "Welcome",
                  style: TextStyle(
                    letterSpacing: 1.0,
                    fontSize: 25,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: provider.isSignUp ? " to My Webpage!" : "back",
                      style: TextStyle(
                        letterSpacing: 1.0,
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Text(
                provider.isSignUp ? "SignUp to continue" : "Sign to continue",
                style: TextStyle(
                  //스,테 2가지로 진입
                  letterSpacing: 1.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
