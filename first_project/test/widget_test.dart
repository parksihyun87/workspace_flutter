class Person{// 다트는 널을 못넣게 함
  String? name;// 기본적으로 일케 하면 널이 들어갈 수 없는 변수인데//late String name; 물음표는 널이 들어갈수도 있다.
  int? age;// 레이트를 붙이면 널이 들어가지는 않을건데 지금 말고 생성자가 채울것이다. 생성자가 실행하기 전까지는 봐준다. 그떄에도 유효한 데이터가 들어가야함


  Person({String name="kim", int age=20}){// 빨간줄 생김. null safety가 생김. 널을 못넣게 영향미치기, 중괄호를 안넣으면 반드시 저 변수가 들어감
    //{String name, int age} 선택가능한 변수다라는 뜻. 둘다 안넣겠다도 되지만 또 널 오류 나면 안되서 저렇게 킴같은 기본값을 넣음.
    this.name= name;
    this.age=age;
  }
  //Person({this.name, this.age});//축약형,required 하면 얘는 꼭 넣어야 해, 지금

}

void main(){// 객체를 저장할 변수가 널이면
  Person p1 = new Person(age:30, name: "jin");// 중괄호하면 순서는 상관이 없다.
  print(p1.name);//p1이 널이면 없는위치의 속성을 불러오려고 함. 널은 오류를 발생시키나, 코딩 선택의 자유도를 높임
  print(p1.name);
  print(p1.age);
}

//위젯은 클래스를 통해서 만든 거임, 사이즈드