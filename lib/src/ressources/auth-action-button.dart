import 'dart:io';
import 'package:FaceNetAuthentication/src/ressources/Constants.dart';
import 'package:FaceNetAuthentication/src/ressources/RoundedButton.dart';
import 'package:path_provider/path_provider.dart';
import 'file:///E:/PointagePFE/lib/src/ui/Presence.dart';
import 'file:///E:/PointagePFE/lib/src/ressources/api_provider.dart';
import 'file:///E:/PointagePFE/lib/src/ui/userProfile.dart';
import 'file:///E:/PointagePFE/lib/src/ressources/facenet.service.dart';
import 'package:FaceNetAuthentication/src/models/User.dart';
import 'package:FaceNetAuthentication/src/ui/adminProfile.dart';
import 'package:FaceNetAuthentication/src/ui/home.dart';
import 'package:FaceNetAuthentication/src/ui/idConfirmation.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';


class AuthActionButton extends StatefulWidget {
  AuthActionButton(this._initializeControllerFuture, {@required this.image,@required this.onPressed, @required this.isLogin, @required this.user});
  final Future _initializeControllerFuture;
  final Function onPressed;
  final bool isLogin;
  final User user;
  final CameraImage image;
  @override
  _AuthActionButtonState createState() => _AuthActionButtonState(user);
}

class _AuthActionButtonState extends State<AuthActionButton> {
  /// service injection
  final FaceNetService _faceNetService = FaceNetService();
  final ApiService _dataBaseService = ApiService();

  final TextEditingController _userTextEditingController = TextEditingController(text: '');
  final TextEditingController _passwordTextEditingController = TextEditingController(text: '');
  final TextEditingController _statusTextEditingController = TextEditingController(text: '');
  User predictedUser;
  User user;
  String V;

  _AuthActionButtonState(this.user);


  Future _signIn(context) async {
    String password = _passwordTextEditingController.text;

    if (this.predictedUser.password == password) {
      if (this.predictedUser.status=='user'){
      FichePresence fPresence = await _dataBaseService.loadPresence(this.predictedUser.cin);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => Profile(
                    username: this.predictedUser,
                    fp: fPresence,
                  )));
      }else{

        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> AdminProfile(
          username: this.predictedUser,

        )));

      }
    } else {
      print(" WRONG PASSWORD!");
    }
  }

  Future<bool> _predictUser() async {

      bool userBoll = _faceNetService.predict(user);
      return userBoll;
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: widget.isLogin ? Text('Sign in') : Text('Sign up'),
      icon: Icon(Icons.camera_alt),
      // Provide an onPressed callback.
      onPressed: () async {
        try {
          // Ensure that the camera is initialized.
          await widget._initializeControllerFuture;
          // onShot event (takes the image and predict output)
          bool faceDetected = await widget.onPressed();

          if (faceDetected) {
            if (widget.isLogin) {
              new Future.delayed(Duration(seconds: 4));
              var userBool = await _predictUser();
              if (userBool) {
                this.predictedUser = user;
              }
            }
            Scaffold.of(context).showBottomSheet((context) => signSheet(context));
          }
        } catch (e) {
          // If an error occurs, log the error to the console.
          print(e);
        }
      },
    );
  }

  signSheet(context) {
    return Container(
      decoration: BoxDecoration(
        color:Colors.teal,
        image: DecorationImage(image: Image.asset('assets/deepOrange.jpg').image,fit: BoxFit.cover),
      ),
      padding: EdgeInsets.all(20),
      height: 300,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListView(
          children: <Widget>[Column(
            children: [
              widget.isLogin && predictedUser != null
                  ? Container(
                      child: Text(
                        'Welcome back, ' + predictedUser.user + '! 😄',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white
                        ),

                      ),
                    )
                  : widget.isLogin
                      ? Container(
                          child: Column(
                            children: [
                              Text(
                              'User not found 😞',
                              style: TextStyle(fontSize: 20),
                        ),
                              SizedBox(
                                height: 50,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RoundedButton(Color(0xFF009688),'Retry', ()async{
                                    Directory tempDir = await getTemporaryDirectory();
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (BuildContext context) =>IdConfirm(path:tempDir.path,u: user,)
                                        )
                                    );
                                  }),
                                  SizedBox(width: 50,),
                                  RaisedButton(
                                      child:Text('Cancel'),
                                      onPressed: (){
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (BuildContext context) =>MyHomePage()
                                            ));
                                      }
                                  )
                                ],
                              )
                            ],
                          ))
                      : Container(),
              !widget.isLogin
                  ? TextField(
                      controller: _userTextEditingController,
                      decoration:   Const.textFieldDeco('Name'),
                    )
                  : Container(),
              widget.isLogin && predictedUser == null
                  ? Container()
                  : TextField(
                      controller: _passwordTextEditingController,
                      decoration: Const.textFieldDeco('Password'),
                      obscureText: true,
                    ),
              !widget.isLogin
                  ?  ListTile(
                title: const Text('admin'),
                leading: Radio(
                  value: 'admin',
                  groupValue: V,
                  onChanged: (String value) {
                    setState(() {
                      V = value;
                    });

                  },
                ),
              ): Container(),
              !widget.isLogin ? ListTile(
                title: const Text('user'),
                leading: Radio(
                  value: 'user',
                  groupValue: V,
                  onChanged: (String value) {
                    setState(() {
                      V = value;
                    });

                  },
                ),
              ): Container(),

              widget.isLogin && predictedUser != null
                  ? RoundedButton(Color(0xFF14A6AF),'Login', () async {
                          await _signIn(context);
                        },)
                      : Container(),
            ],
          ),]
        ),
      ),
    );
  }

  delay(int i) {
    Future.delayed(Duration(seconds: i));
  }

 // @override
 //void dispose() {
 //  super.dispose();
 //}
}
