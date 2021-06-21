import 'file:///E:/PointagePFE/lib/src/ressources/api_provider.dart';
import 'package:FaceNetAuthentication/src/models/User.dart';
import 'package:FaceNetAuthentication/src/ressources/Constants.dart';
import 'package:FaceNetAuthentication/src/ressources/NavBar.dart';
import 'package:FaceNetAuthentication/src/ressources/RoundedButton.dart';
import 'package:FaceNetAuthentication/src/ui/Presence.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePass extends StatelessWidget {
  ChangePass(this.u,this.fp);
  final FichePresence fp;
  final User u;
  final TextEditingController _userNamePassTextEditingController = TextEditingController(text: '');
  final TextEditingController _oldPassTextEditingController = TextEditingController(text: '');
  final TextEditingController _newPassTextEditingController = TextEditingController(text: '');
  final TextEditingController _cnewPassTextEditingController = TextEditingController(text: '');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(u.user),),
        drawer: NavBar(u,fp),
        body: Container(
          decoration: BoxDecoration(image: DecorationImage(image: Image.asset('assets/deepOrange.jpg').image,fit: BoxFit.cover)),
          child: ListView(
            children: [Padding(
              padding: const EdgeInsets.all(30),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Change user name :',style: TextStyle(fontSize: 20,color: Colors.white),),
                    TextField(
                      controller: _userNamePassTextEditingController,
                      decoration: Const.textFieldDeco("Your current user name is "+u.user),
                    ),
                    SizedBox(height: 80,),
                    Text('Change user password :',style: TextStyle(fontSize: 20,color:Colors.white ),),
                      TextField(
                          controller: _oldPassTextEditingController,
                          decoration: Const.textFieldDeco("Your old password"),
                          obscureText: true,
                      ),
                    SizedBox(height: 20,),
                    TextField(
                        controller: _newPassTextEditingController,
                      decoration: Const.textFieldDeco("Your new password"),
                      obscureText: true,
                    ),
                    SizedBox(height: 20,),
                    TextField(
                        controller: _cnewPassTextEditingController,
                      decoration: Const.textFieldDeco("Confirm your new password"),
                      obscureText: true,
                    ),
                    SizedBox(height: 20,),
                    RoundedButton(Color(0xFF14A6AF),"Save",()async{
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
                         }

                    ),
                  ],
                ),
              ),
            )],
          ),
        ));
  }
}
