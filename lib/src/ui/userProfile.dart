import 'file:///E:/PointagePFE/lib/src/ui/Presence.dart';
import 'file:///E:/PointagePFE/lib/src/ui/viewAccount.dart';
import 'file:///E:/PointagePFE/lib/src/ui/check.dart';
import 'file:///E:/PointagePFE/lib/src/ressources/api_provider.dart';
import 'file:///E:/PointagePFE/lib/src/ressources/auth-action-button.dart';
import 'package:FaceNetAuthentication/src/models/User.dart';
import 'package:flutter/material.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'home.dart';

class Profile extends StatelessWidget {
   Profile({Key key, @required this.username, @required this.fp}) : super(key: key);

  FichePresence fp;
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
              Hero(
                tag: 'clock',
                child: DigitalClock(
                  digitAnimationStyle: Curves.elasticOut,
                  is24HourTimeFormat: false,
                  areaDecoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  hourMinuteDigitDecoration:BoxDecoration(color: Colors.transparent),
                  hourMinuteDigitTextStyle: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 50,
                  ),
                  secondDigitDecoration: BoxDecoration(color: Colors.transparent),
                  amPmDigitTextStyle: TextStyle(
                      color: Colors.blueGrey, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20,),

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
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Check(fp: fp,user: username)
                      ),
                    );

                    fp = await API.loadPresence(username.cin);

                  }

              ),
              RaisedButton(
                  child: Text('Account settings'
                      ''),
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
        ),
    )
    );
  }
}
