import 'package:FaceNetAuthentication/pages/Presence.dart';
import 'package:FaceNetAuthentication/pages/db/database.dart';
import 'package:FaceNetAuthentication/pages/profile.dart';
import 'package:FaceNetAuthentication/services/facenet.service.dart';
import 'package:flutter/material.dart';
class User {
  String user;
  String password;
  String status;
  int cin;

  User({@required this.user, @required this.password,@required this.status,@required this.cin});

  static User fromDB(var dbuser) {
    return new User(user: dbuser['userName'], password: dbuser['password'],status:dbuser['status'],cin: dbuser['CIN'] );
  }
}

class AuthActionButton extends StatefulWidget {
  AuthActionButton(this._initializeControllerFuture, {@required this.onPressed, @required this.isLogin});
  final Future _initializeControllerFuture;
  final Function onPressed;
  final bool isLogin;
  @override
  _AuthActionButtonState createState() => _AuthActionButtonState();
}

class _AuthActionButtonState extends State<AuthActionButton> {
  /// service injection
  final FaceNetService _faceNetService = FaceNetService();
  final DataBaseService _dataBaseService = DataBaseService();

  final TextEditingController _userTextEditingController = TextEditingController(text: '');
  final TextEditingController _passwordTextEditingController = TextEditingController(text: '');
  final TextEditingController _statusTextEditingController = TextEditingController(text: '');
  User predictedUser;
  String V;


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

  int _predictUser() {
    int userAndPass = _faceNetService.predict();
    return userAndPass;
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
              var userAndPass = _predictUser();
              if (userAndPass != null) {
                this.predictedUser = User.fromDB(_dataBaseService.db[userAndPass]);
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
