import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // 얘도 불변 위젯인데, 스테이트(변하는 값)을 만들어내는 객체. 얘는 중간다리로 스테이트 객체만 만듬.
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState(); // 빌드없이 객체만 만들면. 얘가 하는 일은 스테이트 객체를 만드는 것과 변하지 않는 데이터를 저장하는 일.(타이틀)
}

class _MyHomePageState extends State<MyHomePage> {
  // 마 홈페이지에서 만들어지는 스테이트 객체를 상속받음.
  // 스테이트풀과 스테이트 상속 받는 두갠데, 지금 얘가(스테이트) 실제 스테이트를 관리하는 객체. 얘가 대부분을 렌더링함. 실제 변화하는 값을 관리하는것은 얘가 함.
  int _counter = 0; // 이게 스테이트 값, _언더바가 있으면 private이고 없으면 public임

  void _incrementCounter() {
    setState(() {
      // 변하는 함수 변경 하려면 set 스테이트 로 변경. 셋스테이트가 호출되면 안에있는것이 호출됨.
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {// 스테이트 객체는 유지가 됨.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(
          context,
        ).colorScheme.inversePrimary, // 부모에게서 테마 데이터 가져와서 반전 색을 가져옴
        title: Text(
          widget.title,
        ), // 일케 쓰면 위의 변하지 않는 것을 가져다 쓸 수 있음, 맨위의 타이틀을 가져오게 됨.
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("버튼을 선택해 눌러주세요"),
            Text(
              "${_counter}",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    _incrementCounter();
                  },
                  icon: Icon(Icons.add),
                  style: IconButton.styleFrom(
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.inversePrimary,
                  ),
                ),
                SizedBox(width: 20),
                IconButton(
                  onPressed: () {
                    _decrementCounter();
                  },
                  icon: Icon(Icons.remove),
                  style: IconButton.styleFrom(
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.inversePrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
