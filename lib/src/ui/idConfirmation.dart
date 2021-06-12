import 'dart:io';

import 'package:FaceNetAuthentication/src/models/User.dart';
import 'package:FaceNetAuthentication/src/ressources/RoundedButton.dart';
import 'package:FaceNetAuthentication/src/ressources/base64Functions.dart';
import 'package:FaceNetAuthentication/src/ressources/ml_vision_service.dart';
import 'package:FaceNetAuthentication/src/ui/sign-in.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

// ignore: must_be_immutable
class IdConfirm extends StatelessWidget {

  final String path;
  final User u;
  IdConfirm({Key key, this.path,this.u}) : super(key: key);





  @override
  Widget build(BuildContext context) {

    MLVisionService _mlVisionService = MLVisionService();
    _mlVisionService.initialize();

    File file = Base64Fun().tempDirectory(path,u);
    u.decodedImage = file;
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
            child: Container(
              decoration:BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/deepOrange.jpg'),fit: BoxFit.cover)
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black, spreadRadius: 2)],
                      ),
                      child: CircleAvatar(
                        radius: 100,
                        child: ClipOval(
                          child: Image(image: Image.file(file).image,
                            fit: BoxFit.cover,
                            width: 200,
                            height: 200,
                      ),
                          ),
                        ),
                    ),
                    SizedBox(height: 20,),
                    RoundedButton(Color(0xFF14A6AF),'This is me', () async {

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
                    },),
                   RoundedButton(Color(0xFF14A6AF),'Not me',() async {

                     Navigator.pop(context);

                   },)
                  ]
                ),
              ),
            )
        )
      )
    )  ;
  }




}