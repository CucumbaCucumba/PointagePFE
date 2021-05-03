import 'dart:async';
import 'file:///E:/PointagePFE/lib/src/ui/Presence.dart';
import 'file:///E:/PointagePFE/lib/src/ressources/auth-action-button.dart';
import 'package:FaceNetAuthentication/src/models/User.dart';
import 'package:dio/dio.dart';

BaseOptions options = BaseOptions(receiveTimeout: 50000, connectTimeout: 50000);
String dS ;
class ApiService {

  // singleton boilerplate
  static final ApiService _cameraServiceService = ApiService
      ._internal();


  factory ApiService() {
    return _cameraServiceService;
  }

  // singleton boilerplate
  ApiService._internal();


  /// Data learned on memory
  List<dynamic> _db = List.empty();
  List<dynamic> get db => this._db;
  var dio = Dio(options);

  /// loads from database
  Future<FichePresence> savePresence(FichePresence fp, int cin)async{
    if (dio.interceptors.isEmpty)
    {
    dio.interceptors.add(CustomInterceptors());
    }
    var S;
    var dTN = DateTime.now().toString().substring(0,DateTime.now().toString().indexOf('.'));
    if (dS==null){
      S = 'I '+dTN;
    }else{
      if(dS[dS.length-21]=='O'){
        S = 'I '+dTN;
      }else{
        S = 'O '+dTN;
      }
    }

    if (dS != null){
       S = (dS+ ' ' + S);
    }
    S = S.replaceAll('-',' ').replaceAll(':', ' ');
     await dio.put('http://192.168.137.1:8000/presence/$cin',data: {'date': S });
    return  loadPresenceDate(fp);
  }

  changeUserInfo(String pass,String userName,int modifiedcin,int truecin)async{
    if (dio.interceptors.isEmpty) {
      dio.interceptors.add(CustomInterceptors());
    }
    Response response = await dio.put('http://192.168.137.1:8000/customers/$truecin',data: {'password' : pass, 'userName': userName, 'CIN':modifiedcin });

  }

  FutureOr loadPresence(int cin)async{
    if (dio.interceptors.isEmpty) {
      dio.interceptors.add(CustomInterceptors());
    }
    Response response = await dio.get('http://192.168.137.1:8000/presence/get/$cin');
    List<DateTime> dr = [];
    bool b = false;
    dS = response.data['dates'];
      if (dS != null) {
      List<String> lS = dS.split(" ");
      for (int i=lS.length;i>0;i=i-7) {
        if(lS[i-7]=='I'){
          b = true;
        }else{
          b = false;
        }
        dr.add(DateTime(int.parse(lS[i-6]),int.parse(lS[i-5]),int.parse(lS[i-4]),int.parse(lS[i-3]),int.parse(lS[i-2]),int.parse(lS[i-1])));
      }
    }
    FichePresence fp = new FichePresence(int.parse(response.data['CIN']),dr,b);
      return fp;

  }

  Future<FichePresence> loadPresenceDate(FichePresence f )async{
    if (dio.interceptors.isEmpty) {
      dio.interceptors.add(CustomInterceptors());
    }
    var cIN=f.cin;
    Response response = await dio.get('http://192.168.137.1:8000/presence/get/$cIN');
    List<DateTime> dr = [];
    bool b = false;
    dS = response.data['dates'];
    if (dS != null) {
      List<String> lS = dS.split(" ");
      for (int i=0;i<lS.length;i=i+7) {
        if(lS[i]=='I'){
          b = true;
        }else{
          b = false;
        }
        dr.add(DateTime(int.parse(lS[i+1]),int.parse(lS[i+2]),int.parse(lS[i+3]),int.parse(lS[i+4]),int.parse(lS[i+5]),int.parse(lS[i+6])));
      }
    }
    FichePresence fp = new FichePresence(int.parse(response.data['CIN']),dr,b);
    return fp;

  }


  Future loadDB() async {
    if (dio.interceptors.isEmpty) {
      dio.interceptors.add(CustomInterceptors());
    }
    Response response = await dio.get('http://192.168.137.1:8000/customers');
    _db = response.data;
    for (int f = 0; f < db.length; f++) {
      _db[f]['faceData'] =
          _db[f]['faceData'].replaceAll('[', '').replaceAll(']', '').split(',');

    }
  }

  Future loadUser(int cin) async {
    if (dio.interceptors.isEmpty) {
      dio.interceptors.add(CustomInterceptors());
    }
    Response response = await dio.get('http://192.168.137.1:8000/customers/$cin');
    User u = new User();
    u.cin=response.data['CIN'];
    u.user=response.data['userName'];
    u.status=response.data['status'];
    u.password=response.data['password'];
    u.wage=response.data['wage'];
    return u;
  }

  /// [Name]: name of the new user
  /// [Data]: Face representation for Machine Learning model
  Future saveData(String user, String password, String modelData, String status,String cin,String wage) async {
    if (dio.interceptors.isEmpty) {
      dio.interceptors.add(CustomInterceptors());
    }
    await dio.post('http://192.168.137.1:8000/customers/add',//192.168.1.16 ip dar 172.0.1.96 ip GST
        data: {'userName': user, 'password': password, 'faceData': modelData, 'status': status,'CIN':cin,'Wage':wage});
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
