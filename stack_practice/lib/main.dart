import 'package:flutter/material.dart';
import 'package:stack_practice/config/palette.dart';

void main() {
  runApp(const MyApp());
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
  bool isSignUp = true;

  String userName="";
  String userEmail="";
  String userPassword="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
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
                            text: isSignUp ? " to My Webpage!" : "back",
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
                      isSignUp ? "SignUp to continue" : "Sign to continue",
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
          ),
          Positioned(
            top: 180,
            child: Container(
              height: isSignUp ? 280 : 250,
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
                            setState(() {
                              isSignUp=false;
                            });
                          },
                          child: Column(
                            children: [
                              Text("SIGNIN",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: !isSignUp?
                                Palette.activeColor :
                                Palette.textColor1
                              ),),
                              if(!isSignUp)
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
                            setState(() {
                              isSignUp=true;
                            });
                          },
                          child: Column(
                            children: [
                              Text("SIGNUP",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSignUp?
                                    Palette.activeColor :
                                    Palette.textColor1
                                ),),
                              if(isSignUp)
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
                    if(isSignUp)
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Form(
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
                                    userName = value!;// 널이 아님을 확신하고 넣는다.
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
                                    userEmail = value!;// 널이 아님을 확신하고 넣는다.
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
                                    userPassword = value!;// 널이 아님을 확신하고 넣는다.
                                  },
                                  key: ValueKey(3),// 키 넣기, 이거 넣어야 오류가 안남.
                                ),
                              ],
                            ))
                      ),//2칸짜리
                    if(!isSignUp)
                      Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Form(
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
                                      userName = value!;// 널이 아님을 확신하고 넣는다.
                                    },
                                    key: ValueKey(1),// 키 넣기, 이거 넣어야 오류가 안남.
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
                                      userPassword = value!;// 널이 아님을 확신하고 넣는다.
                                    },
                                    key: ValueKey(3),// 키 넣기, 이거 넣어야 오류가 안남.
                                  ),
                                ],
                              ))
                      ),//3칸짜리
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
