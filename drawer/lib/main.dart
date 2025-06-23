import 'package:flutter/material.dart';
import 'home.dart';
import 'qna.dart';
import 'settings.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(//테마 넣기// 기본 테마를 모두 적용가능 하다. 전체 적용 스타일 영향이 가능하다
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        scaffoldBackgroundColor: Colors.amber,//여러 페이지 걸친 색상
        fontFamily: "BlackHanSans",
        textTheme: TextTheme(// 여러 페이지 텍스트
          bodyLarge: TextStyle(//16
            fontSize: 20,
            color: Colors.cyanAccent,
          ),
          bodyMedium: TextStyle(//14
              fontSize: 50,
            color: Colors.blueGrey
          )
        )
      ),
      initialRoute: "/",
      routes:{
        "/"  : (context)=>MyPage(),
        "/h" : (context)=>Home(),
        "/q" :(context)=>Qna(),
        "/s" : (context)=>Settings(),
      }
    );
  }
}

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Page"),
        centerTitle: true,
        actions: [// 오른쪽 뒤에다가 뭔가를 추가함
          IconButton(onPressed: (){
            print("장바구니 클릭!!");
          },
              icon: Icon(Icons.shopping_cart)),
          IconButton(onPressed: (){
            print("장바구니 검색!!");
          },
              icon: Icon(Icons.search))
        ],
      ),
      drawer: AccontDetailsDrawer(),// 이렇게 당겨와야 한다. stateful 위젯이 만들어 낸 state 위젯이 drawer를 만들어 낸다.
    );
  }
}

class AccontDetailsDrawer extends StatefulWidget {// 안바뀌는 값
  const AccontDetailsDrawer({super.key});
  final String phone="010-1234-5678";
  final String address= "서울특별시 강남구";


  @override
  State<AccontDetailsDrawer> createState() => _AccontDetailsDrawerState();
}

class _AccontDetailsDrawerState extends State<AccontDetailsDrawer> {// 이 안에다가 넣어야 리렌더링 되게 값을 만들 수 있다.
  bool showDetails = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(// 햄버거 탭 만들기, 여러가지 들어감
        padding: EdgeInsets.zero,// 맨 위 줄 까지 채움
        children: [
          UserAccountsDrawerHeader(// 삼각형 조그를 제공하는 위젯
            decoration: BoxDecoration(
                color: Colors.red[200],
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)
                )
            ),
            accountName: Text("parksihyun"),
            accountEmail: Text("solarhyun87@gmail.com"),
            currentAccountPicture: CircleAvatar(// 사진이 먼저 나옴.
              backgroundImage: AssetImage("assets/KakaoTalk_20250620_131620581.jpg"),
              backgroundColor: Colors.red[200],
            ),
            onDetailsPressed: (){// 삼각형을 여기서 설정
              setState(() {// 이렇게 해야 재랜더링 된다. 렌더링 관련이므로 이렇게 한다.
                this.showDetails= !(this.showDetails);
              }); //
          },
          ),
          if(this.showDetails)// 바로 밑에 쓰면 조건에 따라 보여짐에 영향을 줌
            Padding(
                padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: (){
                          },
                          icon: Icon(Icons.phone)),
                      Text("Phone : ${widget.phone}"
                      ,style: TextStyle(
                          fontSize: 15
                        ),),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: (){
                          },
                          icon: Icon(Icons.location_on)),
                      Text("Phone : ${widget.address}"
                        ,style: TextStyle(
                            fontSize: 15
                        ),),
                    ],
                  )
                ],
              ),
            ),
          ListTile(
            leading: Icon(Icons.home,
              color: Colors.grey[850],
            ),// 앞에 나오게 할 것
            title: Text("Home"),
            trailing: Icon(Icons.add),
            onTap: (){
              Navigator.pushNamed(context, "/h");
            },
          ),
          ListTile(
            leading: Icon(Icons.question_answer,
              color: Colors.grey[850],
            ),// 앞에 나오게 할 것
            title: Text("Q&A"),
            trailing: Icon(Icons.add),
            onTap: (){
              Navigator.pushNamed(context, "/q");
            },
          ),
          ListTile(
            leading: Icon(Icons.settings,
              color: Colors.grey[850],
            ),// 앞에 나오게 할 것
            title: Text("Settings"),
            trailing: Icon(Icons.add),
            onTap: (){
              Navigator.pushNamed(context, "/s");
            },
          ),
        ],
      ),
    );
  }
}

