import 'dart:io';

import 'package:FaceNetAuthentication/src/ressources/base64Functions.dart';
import 'package:path/path.dart';

class Users {
  List<Result> _result;

  List<Result> get result => _result;


  Users.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['result'].length);
    if (parsedJson["result"] != null) {
      List<Result> temp = [];
      for (int i = 0; i < parsedJson['result'].length; i++) {
        String imgPath = '/data/data/com.example.FaceNet/cache/userImage$i.png';
        Result result = Result.fromJson(parsedJson['result'][i],imgPath);
        temp.add(result);
      }

      _result = temp;
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_result != null) {
      map["result"] = _result.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Result {
  String userName;
  String password;
  String faceData;
  String status;
  int cin;
  int wage;
  String image;
  String workLocation;
  File decodedImage;



  Result({
      String userName, 
      String password, 
      String faceData, 
      String status, 
      int cin, 
      int wage, 
      String image, 
      String workLocation}){
    userName = userName;
    password = password;
    faceData = faceData;
    status = status;
    cin = cin;
    wage = wage;
    image = image;
    workLocation = workLocation;
}


  Result.fromJson(dynamic json,String path) {
    userName = json["userName"];
    password = json["password"];
    faceData = json["faceData"];
    status = json["status"];
    cin = json["CIN"];
    wage = json["Wage"];
    image = json["image"];
    workLocation = json["workLocation"];
    decodedImage = Base64Fun().tempDirectory2(path, image);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["userName"] = userName;
    map["password"] = password;
    map["faceData"] = faceData;
    map["status"] = status;
    map["CIN"] = cin;
    map["Wage"] = wage;
    map["image"] = image;
    map["workLocation"] = workLocation;
    return map;
  }

}