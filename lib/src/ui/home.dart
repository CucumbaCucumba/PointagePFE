import 'dart:io';

import 'file:///E:/PointagePFE/lib/src/ui/Presence.dart';
import 'file:///E:/PointagePFE/lib/src/ressources/api_provider.dart';
import 'file:///E:/PointagePFE/lib/src/ui/userProfile.dart';
import 'sign-in.dart';
import 'file:///E:/PointagePFE/lib/src/ui/sign-up.dart';
import 'file:///E:/PointagePFE/lib/src/ressources/auth-action-button.dart';
import 'file:///E:/PointagePFE/lib/src/ressources/facenet.service.dart';
import 'file:///E:/PointagePFE/lib/src/ressources/ml_vision_service.dart';
import 'package:FaceNetAuthentication/src/models/User.dart';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'file:///E:/PointagePFE/lib/src/ressources/Constants.dart';
import 'package:flutter/services.dart';
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
    await _dataBaseService.loadDB();
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
    return Scaffold(
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
                      decoration: Const.textFieldDeco('Enter CIN Number')
                        ,),
                    ),

                    RaisedButton(
                      child: Text('Sign In'),
                      onPressed: () async{
                        if(_cINTextEditingController.text.length!=8){
                          ScaffoldMessenger.of(context).showSnackBar(twix);
                        }else{
                          var cin = int.parse(_cINTextEditingController.text);
                          try{
                             await _dataBaseService.loadUser(cin);}
                             catch(e){
                              print(e);
                             }
                          Directory tempDir = await getTemporaryDirectory();
                      //    Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //             builder: (BuildContext context) => SignIn(cameraDescription1: cameraDescriptionF,),
                      //           ),
                      //        );

                         Navigator.push(
                         context,
                         MaterialPageRoute(
                           builder: (BuildContext context) => IdConfirm(path: tempDir.path,u: _dataBaseService.currUser,),
                         ),
                           );
                        }
                      },
                    ),
                   RaisedButton(
                     child: Text('Sign Up'),
                     onPressed: () {
                       Navigator.push(
                         context,
                         MaterialPageRoute(
                           builder: (BuildContext context) => SignUp(
                             cameraDescription: cameraDescriptionF,
                           ),
                         ),
                       );
                     },
                   ),

                    TextButton(onPressed: ()async{
                      Dio dio = new Dio();
                      await _dataBaseService.loadUser(12845017);
                      int cin = _dataBaseService.currUser.cin;
                      FichePresence fPresence = await _dataBaseService.loadPresence(cin);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Profile(
                                username: _dataBaseService.currUser,
                                fp: fPresence,
                              )));
                    }, child: Text('Skip')),
                  ],
                ),
              )
         : Center(
             child: CircularProgressIndicator(),
           ),
      ),
    );
  }
}
