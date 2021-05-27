import 'dart:io';

import 'package:FaceNetAuthentication/src/models/users.dart';
import 'package:flutter/cupertino.dart';

class User {
  String user;
  String password;
  String status;
  int cin;
  int wage;
  String image64;
  String workLocation;
  List faceData;
  File decodedImage;


  User({@required this.user,@required this.password,@required this.faceData,@required this.status,@required this.cin,@required this.wage,@required this.workLocation,@required this.image64});



  User fromSnap(List<Result> list,int index) {
    User u =User(user: list[index].userName,
        password: list[index].password,
        faceData: list[index].faceData.replaceAll('[', '').replaceAll(']', '').split(','),
        status: list[index].status,
        cin:list[index].cin,
        wage: list[index].wage,
        workLocation: list[index].workLocation,
        image64: list[index].image);
        u.decodedImage = list[index].decodedImage;
    return u;
  }


}