import 'package:FaceNetAuthentication/src/ressources/NavBar.dart';
import 'package:FaceNetAuthentication/src/ressources/RoundedButton.dart';
import 'package:FaceNetAuthentication/src/ressources/api_provider.dart';
import 'package:FaceNetAuthentication/src/ui/home.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'changeAdminInfo.dart';
import 'package:FaceNetAuthentication/src/models/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ViewAccountAdmin extends StatelessWidget {
  ViewAccountAdmin(this.u);

  User u;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      drawer: AdminNavBar(u),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0,20,0,0),
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: 80,
                  child: ClipOval(child: Image(image: Image.file(u.decodedImage).image, height: 150, width: 150, fit: BoxFit.cover,),),
                ),
                Positioned(right: 1,bottom: 1 ,child: GestureDetector(
                  onTap: ()async{
                    u = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangeAdmin(user: u,)
                      ),

                    );
                    Navigator.pop(context,u);
                  },
                  child: Container(
                    height: 50, width: 50,
                    child: Icon(FontAwesomeIcons.cog, color: Colors.white,size: 30,),
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.all(Radius.circular(50))
                    ),
                  ),
                ))
              ],
            ),
            SizedBox(height: 40,),
            Expanded(
              child: Container(
                width: 600,
                decoration: BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(30)),image: DecorationImage(image: Image.asset('assets/deepOrange.jpg').image,fit: BoxFit.cover)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(color: Color(0x33000000),borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        SizedBox(height: 65,),
                        Text(
                          'User :' + u.user,
                          style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'CIN :' + u.cin.toString(),
                          style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Status :' + u.status,
                          style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 30,),
                        RoundedButton(Color(0xFF14A6AF), 'Delete', (){
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: Text('this User will be deleted Permanently!'),
                                actions: [
                                  TextButton(
                                      onPressed:()async{
                                        EasyLoading.show(status: 'Loading');
                                        await ApiService().deleteUser(u.cin.toString());
                                        EasyLoading.dismiss();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MyHomePage()
                                          ),
                                        );
                                      }
                                      , child: Text('Confirm')
                                  )],
                              ));
                        })
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );/*Scaffold(
        appBar: AppBar(
          title: Text('Admin Info '),
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(

                  width: 200,
                  height: 200,
                  child: Image(image: Image.file(u.decodedImage).image,),

                ),

                TextButton(
                  onPressed: , child: Text('Change User Info'),),
                SizedBox(height: 20,),
                SizedBox(height: 20,),
                TextButton(
                    onPressed:(){
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: Text('this User will be deleted Permanently!'),
                            actions: [
                              TextButton(
                                  onPressed:()async{
                                    EasyLoading.show(status: 'Loading');
                                    await ApiService().deleteUser(u.cin.toString());
                                    EasyLoading.dismiss();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyHomePage()
                                      ),
                                    );
                                  }
                                  , child: Text('Confirm')
                              )],
                          ));
                    },
                    child: Text('Delete Account'))

              ],
            ),
          ),
        ));*/
  }
}
