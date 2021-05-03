import 'file:///E:/PointagePFE/lib/src/ui/Presence.dart';
import 'file:///E:/PointagePFE/lib/src/ressources/api_provider.dart';
import 'file:///E:/PointagePFE/lib/src/ui/profile.dart';
import 'file:///E:/PointagePFE/lib/src/ui/sign-in.dart';
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => SignIn(
                              cameraDescription1: cameraDescriptionF,cameraDescription2: cameraDescriptionB ,
                            ),
                          ),
                        );
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
                      User u = await _dataBaseService.loadUser(12845016);
                      int cin = u.cin;
                      FichePresence fPresence = await _dataBaseService.loadPresence(cin);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Profile(
                                username: u,
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
