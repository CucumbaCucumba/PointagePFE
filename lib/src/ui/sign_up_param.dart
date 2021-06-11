import 'file:///E:/PointagePFE/lib/src/ressources//textFormat.dart';
import 'file:///E:/PointagePFE/lib/src/ressources/facenet.service.dart';
import 'package:FaceNetAuthentication/src/models/User.dart';
import 'package:FaceNetAuthentication/src/ressources/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io' as Io;
import 'dart:convert';


import '../ressources/api_provider.dart';
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
  final ApiService _dataBaseService = ApiService();

  final TextEditingController _userTextEditingController = TextEditingController(text: '');
  final TextEditingController _passwordTextEditingController = TextEditingController(text: '');
  final TextEditingController _cINTextEditingController = TextEditingController(text: '');
  final TextEditingController _wageTextEditingController = TextEditingController(text: '');
  final TextEditingController _workLocationTextEditingController = TextEditingController(text: '');
  final snackBar = SnackBar(content: Text('CIN already exists !!!'));
  String V = 'admin';
  Color c = Colors.white.withOpacity(0.0) ;
  final _amountValidator = RegExInputFormatter.withRegex('^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,})?\$');

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
    String cin = _cINTextEditingController.text;
    String wage =_wageTextEditingController.text;
    String wL =_workLocationTextEditingController.text;

    print(predictedData);
    User test;
    try{
      test = await _dataBaseService.loadUser(int.parse(cin));
    }catch(e){
      print('User exists');
    }
    if(test != null){
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        c = Colors.redAccent.withOpacity(0.3);
      });

    }else{
      final bytes = Io.File(_faceNetService.path).readAsBytesSync();
      String img64 = base64Encode(bytes);
    await _dataBaseService.saveData(user, password, predictedData.toString().replaceAll(" ", ""),V,cin,wage,img64,wL);

    /// resets the face stored in the face net sevice
    this._faceNetService.setPredictedData(null);
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MyHomePage()));
        }
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
                decoration: InputDecoration(labelText: "Your Name *")),
            TextField(
              controller: _passwordTextEditingController,
              decoration: InputDecoration(labelText: "Password *"),
              obscureText: true,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  onChanged: (String value){
                    if(value.length==9){
                      _cINTextEditingController.text=_cINTextEditingController.text.substring(0, _cINTextEditingController.text.length - 1);
                    }
                  },
                  controller: _cINTextEditingController ,
                  keyboardType: TextInputType.number,
                  inputFormatters:<TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  style: TextStyle(
                      color: Colors.white
                  ),
                  decoration: Const.textFieldDeco('Enter CIN Number'),

                ),
              ),
              TextField(
                decoration: Const.textFieldDeco('Enter CIN Number'),
              ),
              TextField(
                controller:_wageTextEditingController,
                keyboardType: TextInputType.numberWithOptions(decimal: true,signed: false),

                inputFormatters: [_amountValidator],

                decoration: InputDecoration(labelText: "Wage *"),

              ),
              TextField(
                  controller: _workLocationTextEditingController,
                  decoration: InputDecoration(labelText: "Work Location *")),
              SizedBox(height: 20,),

              RaisedButton(
                child: Text('Sign Up!'),
                onPressed: () async {
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