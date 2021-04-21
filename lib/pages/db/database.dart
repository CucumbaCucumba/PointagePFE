import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

class DataBaseService {
  // singleton boilerplate
  static final DataBaseService _cameraServiceService = DataBaseService
      ._internal();


  factory DataBaseService() {
    return _cameraServiceService;
  }

  // singleton boilerplate
  DataBaseService._internal();

  /// file that stores the data on filesystem
  File jsonFile;

  /// Data learned on memory
  List<dynamic> _db = List.empty();

  List<dynamic> get db => this._db;
  var dio = Dio();

  /// loads from database
  Future loadDB() async {
    dio.interceptors.add(CustomInterceptors());
    Response response = await dio.get('http://192.168.1.16:8000/customers');
    String d;
    _db = response.data;
    for (int f = 0; f < db.length; f++) {
      _db[f]['faceData'] =
          _db[f]['faceData'].replaceAll('[', '').replaceAll(']', '').split(',');

    }
  }



  /// [Name]: name of the new user
  /// [Data]: Face representation for Machine Learning model
  Future saveData(String user, String password, String modelData, String status) async {
    dio.interceptors.add(CustomInterceptors());
    //String userAndPass = user + ':' + password;
    //_db[userAndPass] = modelData;
    //jsonFile.writeAsStringSync(json.encode(_db));
    Response response = await dio.post('http://192.168.1.16:8000/customers/add',
        data: {'userName': user, 'password': password, 'faceData': modelData, 'status': status});
  }
}


class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] =>  PATH: ${options.path}] == ${options.data}');
    return super.onRequest(options, handler);
  }
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('RESPONSE[${response.statusCode}] =>  ${response.data}');
    return super.onResponse(response, handler);
  }
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('ERROR[${err.response?.statusCode}]');
    return super.onError(err, handler);
  }
}
