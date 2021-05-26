import 'dart:html';

import 'package:FaceNetAuthentication/src/models/User.dart';
import 'package:bloc/bloc.dart';

enum Events{A,B,C,D}

class VUA extends Bloc<Events,User>{
  VUA(User initialState) : super(initialState);


  User get initialState => null;

  @override
  Stream<User> mapEventToState(Events event) {
    switch{
    case Events.A

    }
    }

}