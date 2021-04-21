import 'package:FaceNetAuthentication/pages/widgets/auth-action-button.dart';
import 'package:FaceNetAuthentication/services/facenet.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'db/database.dart';
import 'home.dart';

class SignUpPage extends StatefulWidget{

  SignUpPage(this._initializeControllerFuture,{@required this.onPressed });

  final Future _initializeControllerFuture;
  final Function onPressed;

@override
  SignUpPState createState() => SignUpPState();



}

class SignUpPState extends State<SignUpPage>{

  final FaceNetService _faceNetService = FaceNetService();
  final DataBaseService _dataBaseService = DataBaseService();

  final TextEditingController _userTextEditingController = TextEditingController(text: '');
  final TextEditingController _passwordTextEditingController = TextEditingController(text: '');
  final TextEditingController _statusTextEditingController = TextEditingController(text: '');
  String V;

  @override
  void initState() {
    super.initState();
    try {
      // Ensure that the camera is initialized.

      // onShot event (takes the image and predict output)
      bool faceDetected =  widget.onPressed();


    } catch (e) {
      // If an error occurs, log the error to the console.
      print(e);
    }
  }


  Future _signUp(context) async {

    /// gets predicted data from facenet service (user face detected)
    List predictedData = _faceNetService.predictedData;
    String user = _userTextEditingController.text;
    String password = _passwordTextEditingController.text;

    /// creates a new user in the 'database'
    print(predictedData);
    await _dataBaseService.saveData(user, password, predictedData.toString().replaceAll(" ", ""),V);

    /// resets the face stored in the face net sevice
    this._faceNetService.setPredictedData(null);
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MyHomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Container(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _userTextEditingController,
                decoration: InputDecoration(labelText: "Your Name")),
            TextField(
              controller: _passwordTextEditingController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
              ),
              ListTile(
                title: const Text('user'),
                leading: Radio(
                  value: 'user',
                  groupValue: V,
                  onChanged: (String value) {
                    setState(() {
                      V = value;
                      print('oy');
                    });

                  },
                ),
              ),
              ListTile(
                title: const Text('admin'),
                leading: Radio(
                  value: 'admin',
                  groupValue: V,
                  onChanged: (String value) {
                    setState(() {
                      V = value;
                      print('oyy');
                    });

                  },
                ),
              ),
              RaisedButton(
                child: Text('Sign Up!'),
                onPressed: () async {
                  print('tttt');
                  await _signUp(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

}