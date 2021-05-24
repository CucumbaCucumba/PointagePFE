import 'ViewAccountAdmin.dart';
import 'file:///E:/PointagePFE/lib/src/ui/Presence.dart';
import 'file:///E:/PointagePFE/lib/src/ui/viewAccount.dart';
import 'file:///E:/PointagePFE/lib/src/ui/check.dart';
import 'file:///E:/PointagePFE/lib/src/ressources/api_provider.dart';
import 'file:///E:/PointagePFE/lib/src/ressources/auth-action-button.dart';
import 'package:FaceNetAuthentication/src/models/User.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class AdminProfile extends StatelessWidget {
  AdminProfile({Key key, @required this.username}) : super(key: key);


  User username;
  ApiService API = new ApiService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Welcome back, ' + username.user + '!'),
          leading: Container(),
        ),
        body: Container(
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  RaisedButton(
                    child: Text('Logout'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyHomePage()
                        ),
                      );
                    },
                  ),
                  RaisedButton(
                    child: Text('Presence'),

                  ),
                  RaisedButton(
                      child: Text('Users Accounts'),


                  ),
                  RaisedButton(
                      child: Text('Account settings'
                          ''),
                      onPressed: () async{
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewAccountAdmin(username)
                          ),
                        );
                      }

                  )
                  ,]

            ),
          ),
        )
    );
  }
}