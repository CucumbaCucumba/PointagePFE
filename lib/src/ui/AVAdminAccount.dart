import 'file:///E:/PointagePFE/lib/src/ui/changeUserInfo.dart';
import 'package:FaceNetAuthentication/src/models/User.dart';
import 'package:FaceNetAuthentication/src/ui/Presence.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AdminViewAdminAccount extends StatelessWidget {
  AdminViewAdminAccount(this.u);


  User u;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(u.status),
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
                Text(
                  'User :' + u.user,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'CIN :' + u.cin.toString(),
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Status :' + u.status,
                  style: TextStyle(fontSize: 20),
                ),


              ],
            ),
          ),
        ));
  }
}
