import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'file:///E:/PointagePFE/lib/src/ui/sign_up_param.dart';
import 'file:///E:/PointagePFE/lib/src/ressources/FacePainter.dart';
import 'file:///E:/PointagePFE/lib/src/ressources/auth-action-button.dart';
import 'file:///E:/PointagePFE/lib/src/ressources/camera.service.dart';
import 'file:///E:/PointagePFE/lib/src/ressources/facenet.service.dart';
import 'file:///E:/PointagePFE/lib/src/ressources/ml_vision_service.dart';
import 'package:FaceNetAuthentication/src/models/User.dart';
import 'package:FaceNetAuthentication/src/ressources/Constants.dart';
import 'package:FaceNetAuthentication/src/ressources/base64Functions.dart';
import 'package:FaceNetAuthentication/src/ui/ImageConfirmation.dart';
import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

class ChangeImage extends StatefulWidget {
  final CameraDescription cameraDescription;
  final User user;

  const ChangeImage({Key key, @required this.cameraDescription,@required this.user}) : super(key: key);

  @override
  SignUpState createState() => SignUpState(user);
}

class SignUpState extends State<ChangeImage> {
  String imagePath;
  Face faceDetected;
  Size imageSize;
  File imgFile;

  bool _detectingFaces = false;
  bool pictureTaked = false;

  Future _initializeControllerFuture;
  bool cameraInitializated = false;

  // switchs when the user press the camera
  bool _saving = false;
  bool _bottomSheetVisible = false;

  // service injection
  MLVisionService _mlVisionService = MLVisionService();
  CameraService _cameraService = CameraService();
  FaceNetService _faceNetService = FaceNetService();
  User user = new User();

  SignUpState(this.user);

  @override
  void initState() {
    super.initState();

    /// starts the camera & start framing faces
    _start();
  }

  //@override
  // void dispose() {
  // Dispose of the controller when the widget is disposed.
  //   _cameraService.dispose();
//  super.dispose();
  //}

  /// starts the camera & start framing faces
  _start() async {
    _initializeControllerFuture =
        _cameraService.startService(widget.cameraDescription);
    await _initializeControllerFuture;

    setState(() {
      cameraInitializated = true;
    });

    _frameFaces();
  }

  /// handles the button pressed event
  Future<void> onShot() async {
    print('onShot performed');

    if (faceDetected == null) {
      showDialog(
          context: context,
          builder: (_) =>
              AlertDialog(
                content: Text('No face detected!'),
              ));

      return false;
    } else {
      imagePath =
          join((await getTemporaryDirectory()).path, '${DateTime.now()}.png');

      imgFile = File(imagePath);

      _saving = true;

      await Future.delayed(Duration(milliseconds: 500));
      await _cameraService.cameraController.stopImageStream();
      await Future.delayed(Duration(milliseconds: 200));
      await _cameraService.takePicture(imagePath);

      _faceNetService.path = imagePath;

      setState(() {
        _bottomSheetVisible = true;
        pictureTaked = true;
      });

      return true;
    }
  }

  /// draws rectangles when detects faces
  _frameFaces() {
    imageSize = _cameraService.getImageSize();

    _cameraService.cameraController.startImageStream((image) async {
      if (_cameraService.cameraController != null) {
        // if its currently busy, avoids overprocessing
        if (_detectingFaces) return;

        _detectingFaces = true;

        try {
          List<Face> faces = await _mlVisionService.getFacesFromImage(image);

          if (faces.length > 0) {
            setState(() {
              faceDetected = faces[0];
            });

            if (_saving) {
              _faceNetService.setCurrentPrediction(image, faceDetected);
              setState(() {
                _saving = false;
              });
            }
          } else {
            setState(() {
              faceDetected = null;
            });
          }

          _detectingFaces = false;
        } catch (e) {
          print(e);
          _detectingFaces = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double mirror = math.pi;
    final width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
        body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (pictureTaked) {
                return Container(
                  width: width,
                  child: Transform(
                      alignment: Alignment.center,
                      child: Image.file(File(imagePath)),
                      transform: Matrix4.rotationY(mirror)),
                );
              } else {
                return Transform.scale(
                  scale: 1.0,
                  child: AspectRatio(
                    aspectRatio: MediaQuery
                        .of(context)
                        .size
                        .aspectRatio,
                    child: OverflowBox(
                      alignment: Alignment.center,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Container(
                          width: width,
                          height: width / _cameraService.cameraController.value
                              .aspectRatio,
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              CameraPreview(_cameraService.cameraController),
                              CustomPaint(
                                painter: FacePainter(
                                    face: faceDetected, imageSize: imageSize),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () async{
            await onShot();
            BoxedReturns bR = await Navigator.push
              (context, MaterialPageRoute
              (builder: (context) =>
                 ImageConfirm(_initializeControllerFuture, f: imgFile,user:user)));
            user = bR.user;
            if(bR.c) {
              final bytes = File(_faceNetService.path).readAsBytesSync();
              String img64 = base64Encode(bytes);
              user.image64 = img64;
              imgFile = Base64Fun().tempDirectory(_faceNetService.path,user);
              user.faceData = _faceNetService.predictedData;
              user.decodedImage = imgFile;
            }
            Navigator.pop(context,bR);
          },
        )
    );
  }
}