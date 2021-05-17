import 'file:///E:/PointagePFE/lib/src/ui/Presence.dart';
import 'file:///E:/PointagePFE/lib/src/ressources/api_provider.dart';
import 'file:///E:/PointagePFE/lib/src/ui/userProfile.dart';
import 'file:///E:/PointagePFE/lib/src/ressources/facenet.service.dart';
import 'package:FaceNetAuthentication/src/models/User.dart';
import 'package:flutter/material.dart';


class AuthActionButton extends StatefulWidget {
  AuthActionButton(this._initializeControllerFuture, {@required this.onPressed, @required this.isLogin, @required this.user});
  final Future _initializeControllerFuture;
  final Function onPressed;
  final bool isLogin;
  final User user;
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
      FichePresence fPresence = await _dataBaseService.loadPresence(this.predictedUser.cin);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => Profile(
                    username: this.predictedUser,
                    fp: fPresence,
                  )));
    } else {
      print(" WRONG PASSWORD!");
    }
  }

  bool _predictUser() {
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
              var userBool = _predictUser();
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
      padding: EdgeInsets.all(20),
      height: 300,
      child: ListView(
        children: <Widget>[Column(
          children: [
            widget.isLogin && predictedUser != null
                ? Container(
                    child: Text(
                      'Welcome back, ' + predictedUser.user + '! 😄',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                : widget.isLogin
                    ? Container(
                        child: Text(
                        'User not found 😞',
                        style: TextStyle(fontSize: 20),
                      ))
                    : Container(),
            !widget.isLogin
                ? TextField(
                    controller: _userTextEditingController,
                    decoration: InputDecoration(labelText: "Your Name"),
                  )
                : Container(),
            widget.isLogin && predictedUser == null
                ? Container()
                : TextField(
                    controller: _passwordTextEditingController,
                    decoration: InputDecoration(labelText: "Password"),
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
                ? RaisedButton(
                    child: Text('Login'),
                    onPressed: () async {
                      print('test');
                      await _signIn(context);
                    },
                  )

                    : Container(),
          ],
        ),]
      ),
    );
  }

 // @override
 //void dispose() {
 //  super.dispose();
 //}
}