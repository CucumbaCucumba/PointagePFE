import 'package:flutter/cupertino.dart';

class User {
  String user;
  String password;
  String status;
  int cin;
  int wage;

  User({@required this.user, @required this.password,@required this.status,@required this.cin});

  static User fromDB(var dbuser) {
    return new User(user: dbuser['userName'], password: dbuser['password'],status:dbuser['status'],cin: dbuser['CIN'] );
  }
}