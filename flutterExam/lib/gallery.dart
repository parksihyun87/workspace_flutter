import 'package:flutter/material.dart';
import 'package:flutterexam/source.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {

  void showPop(context, index){// 팝업창 띄울때 쇼우 다이얼로그를 씀
    showDialog(
        context: context,
        builder: (context){
          return Dialog(
            child: Container(
              padding: EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width*0.7,
              height: 380,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white
              ),
              child: Column(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset("assets/image${index+1}.jpg",
                        width: 200,
                        height: 200,
                      )),
                  Text("${index+1}. ${Source.pictureName[index]}",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey
                    ),),
                  Padding(
                    padding: EdgeInsets.all(10),

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
    return Scaffold(
      appBar: AppBar(
        title: Text("홈으로",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),),
      ),
      body: Column(
        children:[
          Container(
          child: Expanded(
            child: ListView.builder(
                itemCount: Source.pictureName.length,
                itemBuilder:(context,index){
                  return
                    Container(
                      padding: EdgeInsets.all(5),
                      child: ListTile(
                        leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset("assets/image${index+1}.jpg",
                        width: 80,
                        height: 60,
                        fit: BoxFit.cover,),
                      ),
                      title: Text("${index+1}. ${Source.pictureName[index]}",
                      style: TextStyle(
                        fontSize: 22,
                      ),
                      ),
                      onTap: (){
                          showPop(context, index);
                      },
                      ),
                    );
                }
                ),
          ),
        ),
          
        ],
      ),
    );
  }
}
