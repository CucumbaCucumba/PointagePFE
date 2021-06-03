import 'package:FaceNetAuthentication/src/ressources/api_provider.dart';
import 'package:FaceNetAuthentication/src/ui/home.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
                TextButton(
                  onPressed: ()async{
                    u = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangeAdmin(user: u,)
                      ),

                    );
                    Navigator.pop(context,u);
                  }, child: Text('Change User Info'),),
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
        ));
  }
}
