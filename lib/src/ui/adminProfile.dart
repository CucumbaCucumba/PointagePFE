import 'dart:ui';

import 'package:FaceNetAuthentication/src/ressources/NavBar.dart';
import 'package:FaceNetAuthentication/src/ui/ViewUsers.dart';
import 'package:FaceNetAuthentication/src/ui/sign-up.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:FaceNetAuthentication/src/ressources/ReusableCard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    username.cD = cameraDescriptionF;
  }

  User username;
  ApiService API = new ApiService();
  @override
  Widget build(BuildContext context) {
    startUp();
    Future.delayed(Duration(seconds: 2));
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar (centerTitle: true,title: Text('Welcome Back'),backgroundColor: Colors.transparent,),
        drawer:AdminNavBar(username) ,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      'assets/deepOrange.jpg'
                  ),
                  fit: BoxFit.cover
              )
          ),
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10,10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.2),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ReusableCard(
                              colour: Color(0x33000000),
                              childCard: ReusableCardContent(
                                text: 'Create Account',
                                iconD: FontAwesomeIcons.plus,
                              ),
                            onPress: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context)=> SignUp(cameraDescription: username.cD))
                              );
                            },
                              ),
                          SizedBox(height: 20,),
                          ReusableCard(
                            colour: Color(0x33000000),
                            childCard: ReusableCardContent(
                              text: 'Users',
                              iconD: FontAwesomeIcons.user,
                            ),
                            onPress: (){Navigator.push(context,
                                MaterialPageRoute(builder: (context)=> ViewUsers(username))
                              );
                           },
                          ),
                    ReusableCard(
                      colour: Color(0x33000000),
                      childCard: ReusableCardContent(
                        text: 'Account Settings',
                        iconD: FontAwesomeIcons.cogs,
                      ),
                      onPress: (){Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> ViewAccountAdmin(username))
                      );
                      },
                    ),
                          ]

                    ),
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }
}