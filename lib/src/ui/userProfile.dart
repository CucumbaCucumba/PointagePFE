import 'package:FaceNetAuthentication/src/ui/Presence.dart';import 'file:///E:/PointagePFE/lib/src/ui/viewAccount.dart';
import 'file:///E:/PointagePFE/lib/src/ui/check.dart';
import 'file:///E:/PointagePFE/lib/src/ressources/api_provider.dart';
import 'package:FaceNetAuthentication/src/models/User.dart';
import 'package:FaceNetAuthentication/src/ressources/NavBar.dart';
import 'package:FaceNetAuthentication/src/ressources/ReusableCard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Welcome back'),
        backgroundColor: Colors.transparent,
        leading: Icon(Icons.list_outlined),
      ),
        drawer: NavBar(username,fp),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
               'assets/deepOrange.jpg'
            ),
          fit: BoxFit.cover
          )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              ReusableCard(
                colour: Color(0x33000000),
                childCard: ReusableCardContent(
                  text: 'Presence',
                  iconD: FontAwesomeIcons.clock,
                ),
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Presence(fp,username)
                    ),
                  );
                },
              ),
              SizedBox(height: 20,),
              ReusableCard(
                colour: Color(0x33000000),
                childCard: ReusableCardContent(
                  text: 'IN/OUT',
                  iconD: FontAwesomeIcons.check,
                ),
                onPress: () async{
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Check(fp: fp,user: username)
                    ),
                  );

                  fp = await API.loadPresence(username.cin);
                }
              ),
              SizedBox(height: 20,),
              ReusableCard(
                  colour: Color(0x33000000),
                  childCard: ReusableCardContent(
                    text: 'Account Settings',
                    iconD: FontAwesomeIcons.cogs,
                  ),
                  onPress: () async{
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewAccount(username,fp)
                      ),
                    );
                  }
              ),
              ]

    ),
        ),
    )
    );
  }
}
