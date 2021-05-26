import 'dart:io';

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



}