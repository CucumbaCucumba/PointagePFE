import 'dart:io';

import 'package:FaceNetAuthentication/src/models/User.dart';
import 'package:FaceNetAuthentication/src/ressources/base64Functions.dart';
import 'package:FaceNetAuthentication/src/ressources/ml_vision_service.dart';
import 'package:FaceNetAuthentication/src/ui/sign-in.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

// ignore: must_be_immutable
class IdConfirm extends StatelessWidget {

  final String path;
  final User u;
  IdConfirm({Key key, this.path,this.u}) : super(key: key);





  @override
  Widget build(BuildContext context) {
    EasyLoading.showSuccess('Success');
    MLVisionService _mlVisionService = MLVisionService();
    _mlVisionService.initialize();

    File file = Base64Fun().tempDirectory(path,u);
    u.decodedImage = file;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 200,
                    height: 200,
                    child: Image(image: Image.file(file).image,),
                  ),
                  Text(
                    'is this You',
                    style: TextStyle(
                      fontSize: 40.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RaisedButton(
                    child: Text('YES'),
                    onPressed: () async {

                      List<CameraDescription> cameras = await availableCameras();
                      CameraDescription cameraDescriptionF = cameras.firstWhere(
                            (CameraDescription camera) => camera.lensDirection == CameraLensDirection.front,
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => SignIn(
                            cameraDescription1: cameraDescriptionF ,user:u
                          ),
                        ),
                      );
                    },
                  ),
                  RaisedButton(
                    child: Text('NO'),
                    onPressed: () async {

                      Navigator.pop(context);

                    },
                  ),
                ]
              ),
            )
        )
      )
    )  ;
  }




}