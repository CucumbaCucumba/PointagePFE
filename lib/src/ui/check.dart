import 'package:FaceNetAuthentication/src/ressources/NavBar.dart';
import 'package:FaceNetAuthentication/src/ressources/ReusableCard.dart';
import 'package:FaceNetAuthentication/src/ressources/RoundedButton.dart';
import 'package:FaceNetAuthentication/src/ui/Presence.dart';
import 'package:FaceNetAuthentication/src/models/User.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ressources/api_provider.dart';

class Check extends StatefulWidget {


  @override
  Checkk createState() => new Checkk(fp,user);

  const Check({
    Key key,
    this.fp,
    this.user,
  }) : super(key: key);


  final FichePresence fp ;
  final User user;
}


class Checkk extends State<Check> {

  Checkk(this.fp, this.user);

  FichePresence fp ;
  User user;
  DateTime lD;
  String dat="";

  @override
  void initState(){
    super.initState();
    if(fp.dates.isNotEmpty) {
      lD = fp.dates.first;
    }
    if(lD==null){
      dat = " ";
    }else{
      if(fp.iN){
        dat = "You're checked in at $lD";
      }else{
        dat = "You're checked out at $lD";
      }
    }
    setState(() {
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: NavBar(user,fp),
      appBar: AppBar(title: Text('Clock IN/OUT'),),
      body:Container(
        decoration: BoxDecoration(
          image: DecorationImage(image:Image.asset('assets/deepOrange.jpg',fit: BoxFit.cover,).image)
        ),
        child:Center(
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
                    color: Colors.white,
                    fontSize: 50,
                  ),
                  secondDigitDecoration: BoxDecoration(color: Colors.transparent),
                  amPmDigitTextStyle: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20,),
              Text(dat,style: TextStyle(color: Colors.white,fontSize: 15),),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ReusableCard(
                  colour: Color(0x33000000),
                   childCard: ReusableCardContent(
                     text: 'IN',
                     iconD: FontAwesomeIcons.doorOpen,
                   ),
                   onPress: () async {
                     ApiService db = new ApiService();
                     if(fp.iN == false){
                       fp=await db.savePresence(fp,user.cin);
                       Navigator.pop(context,fp);
                     }else
                     if(DateTime.now().minute == fp.dates[0].minute){
                       print('you just checked in ,you need to wait at least a minute');
                     }else{
                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                         content: Text("you are already checked in"),
                       ));
                       print('user already checked in');
                     }
                   },
                 ),
                  ReusableCard(
                    colour: Color(0x33000000),
                    childCard: ReusableCardContent(
                      text: 'OUT',
                      iconD: FontAwesomeIcons.doorClosed,
                    ),
                    onPress: ()async{
                      ApiService db = new ApiService();
                      if(fp.iN ){
                        fp=await db.savePresence(fp,user.cin);
                        Navigator.pop(context,fp);
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("you did not check in"),
                        ));
                        print('user did not check in');
                      }
                    },
                  ),
                ]),


              //lD==null?Container():Text(fp.iN?"You're checked in at $lD":"You're checked out at $lD")
            ])
        )
      )
    );
  }
}