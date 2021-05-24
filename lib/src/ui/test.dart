import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YellowBird extends StatefulWidget {


  @override
  _YellowBirdState createState() => _YellowBirdState();
}

class _YellowBirdState extends State<YellowBird> {
  int numb = 9;
  List <Widget>listW = [ Center(
    child: Row(

      children: [
        Text("test",style: TextStyle(fontSize: 30),),
        SizedBox(width: 20,),
        Text("0",style: TextStyle(fontSize: 30 ),)
      ] ,
    ),
  ),];
  double h = 50;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (){
                setState(() {
                  h = 100;
                listW.add(ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('haha'),
                    );
                  },
                ));
                });
                
              },
              child: Container(
              height: h,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.blueGrey)),

                  child:Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children:
                        listW
                      ,
                    ),
                  ),
        )
            ),
          )
        ),
      ),
    );
  }
}