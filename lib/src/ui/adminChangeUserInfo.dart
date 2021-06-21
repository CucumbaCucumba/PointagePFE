
import 'package:FaceNetAuthentication/src/models/User.dart';
import 'package:FaceNetAuthentication/src/ressources/Constants.dart';
import 'package:FaceNetAuthentication/src/ressources/NavBar.dart';
import 'package:FaceNetAuthentication/src/ressources/RoundedButton.dart';
import 'package:FaceNetAuthentication/src/ressources/api_provider.dart';
import 'package:FaceNetAuthentication/src/ui/Change%20admin%20image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class AdminChangePass extends StatefulWidget {

  final User user;

  const AdminChangePass({Key key, this.user}) : super(key: key);

  @override
  Changeadmin createState() => Changeadmin(user);
}

class Changeadmin extends State<AdminChangePass> {
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
        extendBodyBehindAppBar: true,
        appBar:AppBar(
          title: Text('User Info'),
          backgroundColor: Colors.transparent,
        )
        ,
        body: ListView(
          children: [Padding(
            padding: const EdgeInsets.fromLTRB(0,30,0,0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 80,
                        child: ClipOval(child: Image(image: Image.file(user.decodedImage).image, height: 150, width: 150, fit: BoxFit.cover,),),
                      ),
                      Positioned(right: 1,bottom: 1 ,child: GestureDetector(
                        onTap: ()async{
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
                        child: Container(
                          height: 50, width: 50,
                          child: Icon(Icons.add_a_photo, color: Colors.white,size: 30,),
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.all(Radius.circular(50))
                          ),
                        ),
                      ))
                    ],
                  ),
                  SizedBox(height: 80,),
                  Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(image: Image.asset('assets/deepOrange.jpg').image,fit:BoxFit.cover )
                      ),
                      child:Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          decoration: BoxDecoration(color: Color(0x55000000),borderRadius: BorderRadius.all(Radius.circular(15))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                                children:[Text('Change user name :',style: TextStyle(fontSize: 20,color:Colors.white),),
                                  TextField(controller: _userNamePassTextEditingController,

                                    decoration: Const.textFieldDeco("current user name is "+user.user),
                                  ),
                                  SizedBox(height: 80,),
                                  Text('Change user password :',style: TextStyle(fontSize: 20,color:Colors.white),),
                                  SizedBox(height: 20,),
                                  TextField(
                                    controller: _newPassTextEditingController,
                                    decoration: Const.textFieldDeco('new Password'),
                                    obscureText: true,
                                  ),
                                  SizedBox(height: 20,),
                                  TextField(
                                    controller: _cnewPassTextEditingController,
                                    decoration: Const.textFieldDeco("Confirm new password"),
                                    obscureText: true,
                                  ),
                                  SizedBox(height: 80,),
                                  SizedBox(height: 20,),

                                  RoundedButton(Color(0xFF14A6AF), 'Save', ()async{

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

                                  }),]),
                          ),
                        ),
                      ))

                ],
              ),
            ),
          )],
        ));
  }

}
