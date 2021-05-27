import 'file:///E:/PointagePFE/lib/src/ressources/api_provider.dart';
import 'package:FaceNetAuthentication/src/models/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminChangePass extends StatelessWidget {
  AdminChangePass(this.u);

  final User u;
  final TextEditingController _userNamePassTextEditingController = TextEditingController(text: '');
  final TextEditingController _oldPassTextEditingController = TextEditingController(text: '');
  final TextEditingController _newPassTextEditingController = TextEditingController(text: '');
  final TextEditingController _cnewPassTextEditingController = TextEditingController(text: '');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: [Padding(
            padding: const EdgeInsets.all(30),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Change user name :',style: TextStyle(fontSize: 20),),
                  TextField(
                    controller: _userNamePassTextEditingController,
                    decoration: InputDecoration(labelText: "Your current user name is "+u.user),
                  ),
                  SizedBox(height: 80,),
                  Text('Change user password :',style: TextStyle(fontSize: 20),),
                  TextField(
                    controller: _oldPassTextEditingController,
                    decoration: InputDecoration(labelText: "Your old password"),
                    obscureText: true,
                  ),
                  SizedBox(height: 20,),
                  TextField(
                    controller: _newPassTextEditingController,
                    decoration: InputDecoration(labelText: "Your new password"),
                    obscureText: true,
                  ),
                  SizedBox(height: 20,),
                  TextField(
                    controller: _cnewPassTextEditingController,
                    decoration: InputDecoration(labelText: "Confirm your new password"),
                    obscureText: true,
                  ),

                  TextButton(
                    onPressed:()async{
                      print(_oldPassTextEditingController.text);
                      if((_newPassTextEditingController.text.isEmpty)||(_oldPassTextEditingController.text==u.password)){
                        bool b = _newPassTextEditingController.text == _cnewPassTextEditingController.text;
                        if(b){
                          await ApiService().changeUserInfo(null,_newPassTextEditingController.text,_userNamePassTextEditingController.text,null,u.cin );
                          u.password=_newPassTextEditingController.text;
                          u.user=_userNamePassTextEditingController.text;
                          Navigator.pop(context,u);
                        }
                      }
                    },child: Text('save'),)
                ],
              ),
            ),
          )],
        ));
  }
}
