import 'file:///E:/PointagePFE/lib/src/ressources//textFormat.dart';
import 'file:///E:/PointagePFE/lib/src/ressources/facenet.service.dart';
import 'package:FaceNetAuthentication/src/models/User.dart';
import 'package:FaceNetAuthentication/src/ressources/Constants.dart';
import 'package:FaceNetAuthentication/src/ressources/NavBar.dart';
import 'package:FaceNetAuthentication/src/ressources/RoundedButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io' as Io;
import 'dart:convert';


import '../ressources/api_provider.dart';

class SignUpPageA extends StatefulWidget{

  SignUpPageA(this._initializeControllerFuture,{this.admin,@required this.onPressed });

  final Future _initializeControllerFuture;
  final Function onPressed;
  final User admin;

@override
  SignUpPState createState() => SignUpPState(this.admin);
}

class SignUpPState extends State<SignUpPageA>{

  final FaceNetService _faceNetService = FaceNetService();
  final ApiService _dataBaseService = ApiService();
  User admin;

  final TextEditingController _userTextEditingController = TextEditingController(text: '');
  final TextEditingController _passwordTextEditingController = TextEditingController(text: '');
  final TextEditingController _cINTextEditingController = TextEditingController(text: '');
  final TextEditingController _wageTextEditingController = TextEditingController(text: '');
  final TextEditingController _workLocationTextEditingController = TextEditingController(text: '');
  final snackBar = SnackBar(content: Text('CIN already exists !!!'));
  String V;
  Color c = Colors.white.withOpacity(0.0) ;
  final _amountValidator = RegExInputFormatter.withRegex('^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,})?\$');

  SignUpPState(this.admin);

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
        }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Sign up')),
      drawer: AdminNavBar(admin),
      body: ListView(
        children: [Container(
          decoration: BoxDecoration(
              image: DecorationImage(image:Image.asset('assets/deepOrange.jpg').image,fit: BoxFit.cover )
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0x55000000),
                borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _userTextEditingController,
                      decoration: Const.textFieldDeco('Name'),
                    ),
                    SizedBox(height: 20,),
                    TextField(
                      controller: _passwordTextEditingController,
                      decoration: Const.textFieldDeco('Password'),
                      obscureText: true,
                    ),
                    SizedBox(height: 20,),
                    TextField(
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
                      decoration: Const.textFieldDeco('CIN'),

                    ),
                    SizedBox(height: 20,),
                    TextField(
                      controller:_wageTextEditingController,
                      keyboardType: TextInputType.numberWithOptions(decimal: true,signed: false),

                      inputFormatters: [_amountValidator],

                      decoration: Const.textFieldDeco('Salary'),
                    ),
                    SizedBox(height: 20,),
                    Text('Role :',
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22,),
                    ),
                    ListTile(
                      selectedTileColor: Colors.white,
                      title: const Text('user ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      leading: Theme(
                        data: Theme.of(context).copyWith(
                            unselectedWidgetColor: Colors.white,
                            disabledColor: Colors.blue),
                        child: Radio(
                          activeColor: Colors.white,
                          value: 'user',
                          groupValue: V,
                          onChanged: (String value) {
                            setState(() {
                              V = value;
                            });

                          },
                        ),
                      ),
                    ),
                    ListTile(
                      title: const Text('admin',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      selectedTileColor: Colors.white,
                      leading: Theme(
                        data: Theme.of(context).copyWith(
                          unselectedWidgetColor: Colors.white,
                          disabledColor: Colors.blue),
                        child: Radio(
                          activeColor: Colors.white,
                          value: 'admin',
                          groupValue: V,
                          onChanged: (String value) {
                            setState(() {
                              V = value;
                            });

                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    RoundedButton(Color(0xFF14A6AF),'Sign Up', () async {
                      EasyLoading.show(status: 'Loading',dismissOnTap: true);
                      await _signUp(context);
                      EasyLoading.showSuccess('User Created',dismissOnTap: true);
                      Navigator.pop(context);
                    }),
                  ],
                ),
              ),
            ),
          ),
        )],
      ),
    );
  }

  }
