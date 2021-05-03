import 'package:flutter/material.dart';

class Const {
  static InputDecoration textFieldDeco(String T) {
   return InputDecoration(
      filled: true,
      fillColor: Color.fromARGB(25, 255, 255, 255),
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