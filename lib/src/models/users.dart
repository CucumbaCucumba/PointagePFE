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
  String _userName;
  String _password;
  String _faceData;
  String _status;
  int _cin;
  int _wage;
  String _image;
  String _workLocation;
  File decodedImage;

  String get userName => _userName;
  String get password => _password;
  String get faceData => _faceData;
  String get status => _status;
  int get cin => _cin;
  int get wage => _wage;
  String get image => _image;
  String get workLocation => _workLocation;

  Result({
      String userName, 
      String password, 
      String faceData, 
      String status, 
      int cin, 
      int wage, 
      String image, 
      String workLocation}){
    _userName = userName;
    _password = password;
    _faceData = faceData;
    _status = status;
    _cin = cin;
    _wage = wage;
    _image = image;
    _workLocation = workLocation;
}

  Result.fromJson(dynamic json,String path) {
    _userName = json["userName"];
    _password = json["password"];
    _faceData = json["faceData"];
    _status = json["status"];
    _cin = json["CIN"];
    _wage = json["Wage"];
    _image = json["image"];
    _workLocation = json["workLocation"];
    decodedImage = Base64Fun().tempDirectory2(path, _image);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["userName"] = _userName;
    map["password"] = _password;
    map["faceData"] = _faceData;
    map["status"] = _status;
    map["CIN"] = _cin;
    map["Wage"] = _wage;
    map["image"] = _image;
    map["workLocation"] = _workLocation;
    return map;
  }

}