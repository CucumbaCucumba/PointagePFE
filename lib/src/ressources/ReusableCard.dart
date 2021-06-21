import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard({@required this.colour, this.childCard,this.onPress});
  final Color colour;
  final Widget childCard;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: 150,
        height: 110,
        child: childCard,
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white60,width: 5),
          borderRadius: BorderRadius.all(Radius.circular(10)),
             color: colour),
      ),
    );
  }
}
class ReusableCardContent extends StatelessWidget {


  ReusableCardContent({this.text,this.iconD});
  final String text;
  final IconData iconD;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          iconD,
          color: Colors.white,
          size: 50.0,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontSize: 16.0
          ),
        )
      ],
    );
  }

}