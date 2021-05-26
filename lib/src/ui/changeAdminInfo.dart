
import 'package:FaceNetAuthentication/src/models/User.dart';
import 'package:FaceNetAuthentication/src/ressources/Constants.dart';
import 'package:FaceNetAuthentication/src/ressources/api_provider.dart';
import 'package:FaceNetAuthentication/src/ui/Change%20admin%20image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChangeAdmin extends StatefulWidget {

  final User user;

  const ChangeAdmin({Key key, this.user}) : super(key: key);

  @override
  Changeadmin createState() => Changeadmin(user);
}

class Changeadmin extends State<ChangeAdmin> {
  Changeadmin(this.user);

  User user;
  final TextEditingController _userNamePassTextEditingController = TextEditingController(text: '');
  final TextEditingController _cinTextEditingController = TextEditingController(text: '');
  final TextEditingController _oldPassTextEditingController = TextEditingController(text: '');
  final TextEditingController _newPassTextEditingController = TextEditingController(text: '');
  final TextEditingController _cnewPassTextEditingController = TextEditingController(text: '');

  CameraDescription cameraDescriptionF;
  CameraDescription cameraDescriptionB;
  ApiService api = new ApiService();

  @override
  void initState()  {
    super.initState();
     startUp();
  }

  Future startUp() async {
    List<CameraDescription> cameras = await availableCameras();

    /// takes the front camera
    cameraDescriptionF = cameras.firstWhere(
          (CameraDescription camera) => camera.lensDirection == CameraLensDirection.front,
    );
    cameraDescriptionB = cameras.firstWhere(
          (CameraDescription camera) => camera.lensDirection == CameraLensDirection.back,
    );
  }

  BoxedReturns bR;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar:AppBar(
          title: Text('Admin Info'),
          backgroundColor: Colors.transparent,
        )
        ,
        body: ListView(
          children: [Padding(
            padding: const EdgeInsets.all(30),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(children: [
                    Container(

                      width: 200,
                      height: 200,
                      child: Image(image: Image.file(user.decodedImage).image,),

                    ),
                    TextButton(child: Text("Take Image"),
                      onPressed: ()async{
                          bR = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangeImage(cameraDescription: cameraDescriptionF,user: user,)
                          ),
                        );
                        user = bR.user;
                        setState(() {

                        });
                      },
                    )
                  ],),

                  SizedBox(height: 80,),
                  Text('Change admin name :',style: TextStyle(fontSize: 20),),
                  TextField(
                    controller: _userNamePassTextEditingController,
                    decoration: InputDecoration(labelText: "Your current admin name is "+user.user),
                  ),
                  SizedBox(height: 80,),
                  Text('Change admin password :',style: TextStyle(fontSize: 20),),
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
                  SizedBox(height: 80,),
                  Text('Enter current pass to confirm the save :',style: TextStyle(fontSize: 20),),
                  TextField(
                    controller: _oldPassTextEditingController,
                    decoration: InputDecoration(labelText: "Your current password  *"),
                    obscureText: true,
                  ),
                  SizedBox(height: 20,),

                  TextButton(
                    onPressed:()async{
                      if((_oldPassTextEditingController.text.isEmpty)||(_oldPassTextEditingController.text!=user.password)){
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: Text('Insert Correct Current Password !'),
                            ));
                      }
                      else{
                        //checks if there is new pw and if the old pw field = current password
                        if(bR!=null?bR.c:false){
                          if(_newPassTextEditingController.text != _cnewPassTextEditingController.text){
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  content: Text('New Password confirmation is wrong  !'),
                                ));
                          }else{
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  content: Text('are you sure about the changes !'),
                                  actions: [
                                    TextButton(
                                  onPressed:()async{
                                    user = await api.changeUserInfo(user.image64,_newPassTextEditingController.text,
                                        _userNamePassTextEditingController.text,null,
                                        user.cin);
                                    Navigator.pop(context,user);
                            }
                                  , child: Text('Confirm')
                                    )],
                                ));

                          }
                        }else{
                          if(_newPassTextEditingController.text != _cnewPassTextEditingController.text){
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  content: Text('New Password confirmation is wrong  !'),
                                ));
                          }else{
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  content: Text('are you sure about the changes !'),
                                  actions: [
                                    TextButton(
                                        onPressed:()async{
                                         user = await api.changeUserInfo(null,_newPassTextEditingController.text,
                                              _userNamePassTextEditingController.text,null,
                                              user.cin);
                                          Navigator.pop(context,user);
                                        }
                                        , child: Text('Confirm')
                                    )],
                                ));


                          }

                        }
                      }
                    },child: Text('save'),),

                ],
              ),
            ),
          )],
        ));
  }

}
