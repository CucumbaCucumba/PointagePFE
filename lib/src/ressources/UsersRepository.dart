import 'dart:async';

import 'package:FaceNetAuthentication/src/models/users.dart';
import 'package:FaceNetAuthentication/src/ressources/api_provider.dart';


class Repository {
  final api = ApiService();

  Future<Users> fetchAllUsers() => api.loadDB();
}