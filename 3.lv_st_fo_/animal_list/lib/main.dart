import 'package:animal_list/animal_data_source.dart';
import 'package:flutter/material.dart';
import 'anmimaldetailed.dart';
import 'animal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // home: AnimalHome()
      initialRoute: "/",
      routes: {
        "/":(context)=>AnimalHome(),// (경,:콜,컨)3가지
        "/animal_page":(context)=>animaldetialed()
      },
    );
  }
}

class AnimalHome extends StatelessWidget {
  AnimalHome({super.key});// 계속 널을 넣으니깐 계속 같은 객체로 유지되고 다르면 지우고 새로 만든다.

  final List<Animal> animalData= List.generate(
      AnimalDataSource.animalName.length, // 1.자동으로 들어갈 요소의 개수 지정, // 2.하나하나 들어갈 함수에 관련하여 화살표 뒤에 들어갈 것이 리턴이 되며, 그것이 리스트 안에 들어가게 됨
          (index)=>Animal(name: AnimalDataSource.animalName[index],
          imagePath: AnimalDataSource.animalImagePath[index],
          location: AnimalDataSource.animalLocation[index]));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("애니멀입니다.")
      ),
      body:
      ListView.builder(
          itemCount:animalData.length,
          itemBuilder:(context,index){
            return Card(
              child: ListTile(
                leading: Image.asset(animalData[index].imagePath
                ),
                title: Text(animalData[index].name),
                onTap: (){
                  Navigator.pushNamed(context, "/animal_page", arguments: animalData[index]);//아규먼츠에다가 정보를 넣으면, 컨텍스트에 해당 내용이 같이 포함되며 넘어가게 된다.
                },
              ),
            );
          }
      ),
    );
  }
}


// class AnimalHome extends StatelessWidget {
//   AnimalHome({super.key});// 계속 널을 넣으니깐 계속 같은 객체로 유지되고 다르면 지우고 새로 만든다.
//
//   final List<Animal> animalData= List.generate(
//       AnimalDataSource.animalName.length, // 1.자동으로 들어갈 요소의 개수 지정, // 2.하나하나 들어갈 함수에 관련하여 화살표 뒤에 들어갈 것이 리턴이 되며, 그것이 리스트 안에 들어가게 됨
//           (index)=>Animal(name: AnimalDataSource.animalName[index],
//           imagePath: AnimalDataSource.animalImagePath[index],
//           location: AnimalDataSource.animalLocation[index]));
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("애니멀입니다.")
//       ),
//       body:
//       ListView.builder(
//           itemCount:animalData.length,
//           itemBuilder:(context,index){
//             return Card(
//               child: ListTile(
//                 leading: Image.asset(animalData[index].imagePath
//                 ),
//                 title: Text(animalData[index].name),
//                 onTap: (){
//                   Navigator.push(context, MaterialPageRoute(//네비게이터.푸시((컨텍스트, 매패루) 2가지( 빌더:, (,컨텍스트,화살표,생성자)가지
//                       builder: (context)=>animaldetialed(animal: animalData[index])));//인덱스 넘겨야 함
//                 },
//               ),
//             );
//           }
//       ),
//     );
//   }
// }
