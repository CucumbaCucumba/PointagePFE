import 'package:FaceNetAuthentication/pages/Presence.dart';
import 'package:FaceNetAuthentication/pages/viewAccount.dart';
import 'package:FaceNetAuthentication/pages/check.dart';
import 'package:FaceNetAuthentication/pages/db/database.dart';
import 'package:FaceNetAuthentication/pages/widgets/auth-action-button.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class Profile extends StatelessWidget {
   Profile({Key key, @required this.username, @required this.fp}) : super(key: key);

  FichePresence fp;
  User username;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome back, ' + username.user + '!'),
        leading: Container(),
      ),
      body: Container(
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Presence(fp)
                  ),
                );
              },
            ),
            RaisedButton(
                child: Text('IN/OUT'),
                onPressed: () async{
                 username = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Check(fp: fp,user: username)
                    ),
                  );
                 fp = await DataBaseService().loadPresence(username.cin);
                }

            ),
            RaisedButton(
                child: Text('Change Password'),
                onPressed: () async{
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewAccount(username)
                    ),
                  );
                }

            )
            ,]

    ),
    )
    );
  }
}
