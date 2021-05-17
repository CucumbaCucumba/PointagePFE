import 'file:///E:/PointagePFE/lib/src/ui/Presence.dart';
import 'file:///E:/PointagePFE/lib/src/ressources/auth-action-button.dart';
import 'package:FaceNetAuthentication/src/models/User.dart';
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
      body:SafeArea(
        child: Center(
          child: Container(
            child:Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DigitalClock(
                      digitAnimationStyle: Curves.elasticOut,
                      is24HourTimeFormat: false,
                      areaDecoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                hourMinuteDigitTextStyle: TextStyle(
                color: Colors.blueGrey,
                fontSize: 50,
              ),
              amPmDigitTextStyle: TextStyle(
                  color: Colors.blueGrey, fontWeight: FontWeight.bold),
            ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor:Colors.teal,
                          ),
                          onPressed: () async {
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
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('IN',style:TextStyle(
                              color: Colors.black,
                              fontSize: 40,
                              fontStyle: FontStyle.italic,))))),
                              TextButton(
                                  style: TextButton.styleFrom(
                                    primary: Colors.white,
                                    backgroundColor:Colors.teal,
                                  ),
                                  onPressed: ()async{
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
                                  child: Text('OUT',style:TextStyle(
                                    color: Colors.black,
                                    fontSize: 40,
                                    fontStyle: FontStyle.italic,)))
                    ]),

                  Text(dat)
                  //lD==null?Container():Text(fp.iN?"You're checked in at $lD":"You're checked out at $lD")
                ])
            )
          )
       )
     )
    );
  }
}