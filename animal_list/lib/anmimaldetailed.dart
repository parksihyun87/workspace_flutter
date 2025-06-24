import 'package:flutter/material.dart';

import 'animal.dart';//(패,플,매)3가지


class animaldetialed extends StatefulWidget {
  // final Animal animal;
  // const animaldetialed({super.key, required this.animal});
  const animaldetialed({super.key});
  @override
  State<animaldetialed> createState() => _animaldetialedState();
}


class _animaldetialedState extends State<animaldetialed> {
  late final Animal animal;

  bool checked= false;
  int counter = 0;

  @override// 부모에게 상속받은 것을 디드 해야하며, 특정상황이 되면 자동으로 호출되는 콜백함수이다.
  void didChangeDependencies() {// 이닛 스테이트 다음에 자동으로 호출되며, 부모에게서 바뀌면 다시 호출되게도 함.
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();//이닛이나 디드체인지 두 함수 다 슈퍼.해서 부모함수자 역할실행 먼저 하고 시행한다.
    animal=ModalRoute.of(context)?.settings.arguments as Animal;
    if(animal.likeCount>0){
      checked=true;
    }
    counter=animal.likeCount;
  }// 이닛 스테이트가 호출 되는 시점에는 컨텍스트가 없고, 그 후에는 컨텍스트가 필요하기 때문에 여기서 추출해서 대입해 준다.
  //프리미티브 변수는 변수의 값이 복사되서 전달되지만, 객체가 복사되어서 넘어가면 메모리의 위치값이 넘어가므로, 원래의 값도 바뀜.

  void incrementCounter(){
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {//모달 라우트.오브에서 컨텍스트를 추출한다. 아규먼츠는 무슨형태로나 전달이 되므로 object로 받으며, nullable(널이 가능한) 값으로 넣는다.?가 그래서 물음표임. 원래 자료형이 animal이여서 as로 원자료형으로 캐스팅
    // final Animal animal=ModalRoute.of(context)?.settings.arguments as Animal;// 불린이나 인트가 카운트 영향을 주어 호출될때마다 다시 만들어짐.
    return Scaffold(
        appBar: AppBar(
          title: Text(animal.name),
        ),
        body:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(animal.imagePath,// 정(이.어)2가지로 이미지 불러옴
                width: 100,
                height: 100,
              ),
              Text(animal.name),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: (){
                      setState(() {
                        animal.likeCount++;
                        checked=true;
                      });
                      incrementCounter();
                    },
                    icon: Icon(Icons.favorite),
                    color: checked? Colors.red : Colors.grey,// 3항 연산자로 씀.
                  ),
                  Text("${counter}",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  )
                ],
              )
            ],
          ),
        )
    );
  }
}


