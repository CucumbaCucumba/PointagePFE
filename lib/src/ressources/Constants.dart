import 'package:FaceNetAuthentication/src/models/User.dart';
import 'package:flutter/material.dart';

class BoxedReturns{
   bool c = false;
   User user ;

  BoxedReturns(this.c, this.user);

}


class Const {
  static InputDecoration textFieldDeco(String T) {
   return InputDecoration(
      filled: true,
      fillColor: Color.fromARGB(50, 255, 255, 255),
      hintText: T,
      hintStyle: TextStyle(
        color: Colors.white70,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
    )
    ;
  }
}