import 'package:FaceNetAuthentication/pages/db/database.dart';
import 'package:FaceNetAuthentication/pages/widgets/auth-action-button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePass extends StatelessWidget {
  ChangePass(this.u);

  final User u;
  final TextEditingController _userNamePassTextEditingController = TextEditingController(text: '');
  final TextEditingController _oldPassTextEditingController = TextEditingController(text: '');
  final TextEditingController _newPassTextEditingController = TextEditingController(text: '');
  final TextEditingController _cnewPassTextEditingController = TextEditingController(text: '');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
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
                  obscureText: true,
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
                    if(_oldPassTextEditingController.text==u.password){
                     bool b = _newPassTextEditingController.text == _cnewPassTextEditingController.text;
                      if(b){
                          await DataBaseService().changeUserInfo(_newPassTextEditingController.text,'',null,u.cin );
                          u.password=_newPassTextEditingController.text;
                          Navigator.pop(context,u);
                          }
                    }
                  },child: Text('save'),)
              ],
            ),
          ),
        ));
  }
}
