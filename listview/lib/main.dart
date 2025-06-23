import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', home: ListViewPage());
  }
}

class ListViewPage extends StatefulWidget {
  const ListViewPage({super.key});

  static const List<String> titleList = [
    '치과의사',
    '약사',
    '학교 선생님',
    'IT 관리자',
    '게임 게발자',
    '변호사',
    '헤어 디자이너',
    '의사',
    '웹 개발자',
    '비서',
  ];

  static const List<String> imageList = [
    'assets/1.png',
    'assets/2.png',
    'assets/3.png',
    'assets/4.png',
    'assets/5.png',
    'assets/6.png',
    'assets/7.png',
    'assets/8.png',
    'assets/9.png',
    'assets/10.png',
  ];

  static const List<String> discription = [
    '1.There are different types of careers you can pursue in your life. Which one will it be?',
    '2.There are different types of careers you can pursue in your life. Which one will it be?',
    '3.There are different types of careers you can pursue in your life. Which one will it be?',
    '4.There are different types of careers you can pursue in your life. Which one will it be?',
    '5.There are different types of careers you can pursue in your life. Which one will it be?',
    '6.There are different types of careers you can pursue in your life. Which one will it be?',
    '7.There are different types of careers you can pursue in your life. Which one will it be?',
    '8.There are different types of careers you can pursue in your life. Which one will it be?',
    '9.There are different types of careers you can pursue in your life. Which one will it be?',
    '10.There are different types of careers you can pursue in your life. Which one will it be?',
  ];

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {

  void showPop(context, index){// 팝업창 띄울때 쇼우 다이얼로그를 씀
    showDialog(
        context: context,
        builder: (context){// 일단 컨텍스트 넘김
          return Dialog(// 화면 맨 위에 띄우는 창,dialog라고 함.
            child: Container(
              width: MediaQuery.of(context).size.width*0.7,
              height: 380,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(ListViewPage.imageList[index],
                    width: 200,
                    height: 200,
                  )),
                  Text(ListViewPage.titleList[index],
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey
                  ),),
                  Padding(
                      padding: EdgeInsets.all(10),
                  child: Text(ListViewPage.discription[index],
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[500],
                  ),
                    textAlign: TextAlign.center,
                  ),
                  ),
                  ElevatedButton.icon(onPressed: (){
                    Navigator.pop(context);
                  },
                    label: Text("Close"),
                  icon: Icon(Icons.close),)
                ],
              ),
            ),
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    // 미디어 쿼리는 기계의 물리적 크기를 구할때 쓰임(자기가 갇혀있는 박스)
    double width = MediaQuery.of(context).size.width * 0.6;

    return Scaffold(
      appBar: AppBar(
        title: Text("ListView", style: TextStyle(color: Colors.grey)),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        // 스태틱 인용
        itemCount: ListViewPage.titleList.length, //맵처럼 출력이 진행된다.
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap:(){
              print(ListViewPage.titleList[index]);
              showPop(context, index);
            },
            child: Card(
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset(ListViewPage.imageList[index]),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          ListViewPage.titleList[index],
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: width,
                          child: Text(
                            ListViewPage.discription[index],
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[500],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
