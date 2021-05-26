
import 'file:///E:/PointagePFE/lib/src/ressources//textFormat.dart';
import 'file:///E:/PointagePFE/lib/src/ressources/facenet.service.dart';
import 'package:FaceNetAuthentication/src/models/User.dart';
import 'package:FaceNetAuthentication/src/ressources/Constants.dart';
import 'package:FaceNetAuthentication/src/ressources/base64Functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';


import '../ressources/api_provider.dart';

class ImageConfirm extends StatefulWidget{

  ImageConfirm(this._initializeControllerFuture,{@required this.f ,@required this.user});

  final Future _initializeControllerFuture;
  final File f;
  final User user;

  @override
  SignUpPState createState() => SignUpPState(f,user);



}

class SignUpPState extends State<ImageConfirm>{

  final FaceNetService _faceNetService = FaceNetService();
  final ApiService _dataBaseService = ApiService();

  final TextEditingController _userTextEditingController = TextEditingController(text: '');
  final TextEditingController _passwordTextEditingController = TextEditingController(text: '');
  final TextEditingController _cINTextEditingController = TextEditingController(text: '');
  final TextEditingController _wageTextEditingController = TextEditingController(text: '');
  final TextEditingController _workLocationTextEditingController = TextEditingController(text: '');
  final snackBar = SnackBar(content: Text('CIN already exists !!!'));
  String V;
  File file ;
  User user;
  Color c = Colors.white.withOpacity(0.0) ;
  final _amountValidator = RegExInputFormatter.withRegex('^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,})?\$');

  SignUpPState(this.file,this.user);

  @override
  void initState() {
    super.initState();
    try {
      // Ensure that the camera is initialized.

      // onShot event (takes the image and predict output)


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

      final bytes = File(_faceNetService.path).readAsBytesSync();
      String img64 = base64Encode(bytes);
      file = Base64Fun().tempDirectory2(_faceNetService.path,img64);
      /// resets the face stored in the face net sevice
      this._faceNetService.setPredictedData(null);
      setState(() {

      });


  }

  @override
  Widget build(BuildContext context) {
    _signUp(context);
    return Scaffold(
      body: Container(
        child: Image(image: Image.file(file).image,),
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
                heroTag: 'f1',
                onPressed: (){
                  BoxedReturns bR = new BoxedReturns(true, user);
              Navigator.pop(context,bR);
            }),
            SizedBox(width: 40,),
            FloatingActionButton(
                heroTag: 'f2',
                onPressed: (){
                  BoxedReturns bR = new BoxedReturns(false, user);
                  Navigator.pop(context,bR);
            })
          ],
        ),
    );
  }

  
}