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
      body: Stack(
        children: [
          Container(color: Colors.green,),

        ],
      ),
    );
  }
}