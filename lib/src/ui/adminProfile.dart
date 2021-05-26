import 'package:FaceNetAuthentication/src/ui/ViewUsers.dart';
import 'package:FaceNetAuthentication/src/ui/sign-up.dart';
import 'package:camera/camera.dart';

import 'ViewAccountAdmin.dart';
import 'file:///E:/PointagePFE/lib/src/ressources/api_provider.dart';
import 'package:FaceNetAuthentication/src/models/User.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class AdminProfile extends StatelessWidget {
  AdminProfile({Key key, @required this.username}) : super(key: key);


  CameraDescription cameraDescriptionF;
  CameraDescription cameraDescriptionB;

  Future startUp() async {
    List<CameraDescription> cameras = await availableCameras();

    /// takes the front camera
    cameraDescriptionF = cameras.firstWhere(
          (CameraDescription camera) => camera.lensDirection == CameraLensDirection.front,
    );
    cameraDescriptionB = cameras.firstWhere(
          (CameraDescription camera) => camera.lensDirection == CameraLensDirection.back,
    );
  }

  User username;
  ApiService API = new ApiService();
  @override
  Widget build(BuildContext context) {
    startUp();
    Future.delayed(Duration(seconds: 2));
    return Scaffold(
        appBar: AppBar(
          title: Text('Welcome back, ' + username.user + '!'),
          leading: Container(),
        ),
        body: Container(
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  RaisedButton(
                    child: Text('Logout'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyHomePage()
                        ),
                      );
                    },
                  ),
                  RaisedButton(
                    child: Text('Create an Account'),
                    onPressed: (){
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> SignUp(cameraDescription: cameraDescriptionF))
                      );
                    },

                  ),
                  RaisedButton(
                      child: Text('Users Accounts'),
                      onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=> ViewUsers())
                        );
                      },
                  ),
                  RaisedButton(
                      child: Text('Account settings'
                          ''),
                      onPressed: () async{
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewAccountAdmin(username)
                          ),
                        );
                      }

                  )
                  ,]

            ),
          ),
        )
    );
  }
}