import 'dart:io';

import 'file:///E:/PointagePFE/lib/src/ui/Presence.dart';
import 'file:///E:/PointagePFE/lib/src/ressources/api_provider.dart';
import 'file:///E:/PointagePFE/lib/src/ui/userProfile.dart';
import 'package:FaceNetAuthentication/src/ressources/RoundedButton.dart';
import 'package:FaceNetAuthentication/src/ui/test.dart';

import 'file:///E:/PointagePFE/lib/src/ui/sign-up.dart';
import 'file:///E:/PointagePFE/lib/src/ressources/facenet.service.dart';
import 'file:///E:/PointagePFE/lib/src/ressources/ml_vision_service.dart';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'file:///E:/PointagePFE/lib/src/ressources/Constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:path_provider/path_provider.dart';

import 'idConfirmation.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Services injection
  FaceNetService _faceNetService = FaceNetService();
  MLVisionService _mlVisionService = MLVisionService();
  ApiService _dataBaseService = ApiService();

  SnackBar twix = new SnackBar(content: Text('wrong CIN format must be 8 digits long'));

  final TextEditingController _cINTextEditingController = TextEditingController(text: '');



  CameraDescription cameraDescriptionF;
  CameraDescription cameraDescriptionB;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _startUp();
  }

  /// 1 Obtain a list of the available cameras on the device.
  /// 2 loads the face net model
  _startUp() async {
    _setLoading(true);

    List<CameraDescription> cameras = await availableCameras();

    /// takes the front camera
    cameraDescriptionF = cameras.firstWhere(
      (CameraDescription camera) => camera.lensDirection == CameraLensDirection.front,
    );
    cameraDescriptionB = cameras.firstWhere(
          (CameraDescription camera) => camera.lensDirection == CameraLensDirection.back,
    );

    // start the services
    await _faceNetService.loadModel();
    //await _dataBaseService.loadDB();
    _mlVisionService.initialize();
    new Future.delayed(Duration(seconds: 4));
    _setLoading(false);
  }

  // shows or hides the circular progress indicator
  _setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
  //   appBar: AppBar(
  //     title: Text('Face recognition auth'),
  //     leading: Container(),
  //   ),
        body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/deepOrange.jpg'
            ),
              fit: BoxFit.cover
          )
        ),
          child: !loading
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 200,
                        width: 200,
                        child: Image.asset('assets/logo.png'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextField(
                          controller: _cINTextEditingController ,
                          keyboardType: TextInputType.number,
                          inputFormatters:<TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                  style: TextStyle(
                        color: Colors.white
                  ),
                        decoration: Const.textFieldDeco('Enter CIN Number'),

                        ),
                      ),
                      RoundedButton(Color(0xFF14A6AF),'Log In',() async{
                        Response response;
                        if(_cINTextEditingController.text.length!=8){
                          ScaffoldMessenger.of(context).showSnackBar(twix);
                        }else{
                          try{
                            EasyLoading.show(status: 'Loading');
                            var cin = int.parse(_cINTextEditingController.text);

                            response = await _dataBaseService.loadUser(cin);

                            Directory tempDir = await getTemporaryDirectory();

                            EasyLoading.dismiss();

                            if(response.statusCode == 200){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => IdConfirm(path: tempDir.path,u: _dataBaseService.currUser,),
                                ),
                              );}
                            else
                            {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("wrong CIN"),
                              ));
                            }
                          }
                          catch(e){
                            EasyLoading.showError('Loading Failed');
                          }

                        }
                      }, )
                    ],
                  ),
                )
           : Center(
               child: CircularProgressIndicator(),
             ),
        ),
      ),
    );
  }
}
