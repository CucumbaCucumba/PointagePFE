import 'package:FaceNetAuthentication/src/ressources/NavBar.dart';
import 'package:FaceNetAuthentication/src/ressources/RoundedButton.dart';
import 'package:FaceNetAuthentication/src/ui/AlterTime.dart';
import 'package:FaceNetAuthentication/src/ui/changeAdminInfo.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'adminChangeUserInfo.dart';
import 'file:///E:/PointagePFE/lib/src/ui/changeUserInfo.dart';
import '../ui/Presence.dart';
import 'package:FaceNetAuthentication/src/models/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:time_chart/time_chart.dart';


// ignore: must_be_immutable
class AdminViewAccount extends StatelessWidget {
  AdminViewAccount({this.user,this.admin,this.fp});

  FichePresence fp;
  User user;
  User admin;

  @override
  Widget build(BuildContext context) {
    List<DateTimeRange> dTR = fp.fPRange();
    return Scaffold(
      drawer: AdminNavBar(admin),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text (user.status),
      ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: ListView(
            children :[ Center(
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
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context) => AdminChangePass( user: user,)));
                        }

                        ,
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
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                  children:[Text(
                  'User :' + user.user,
                  style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                  height: 20,
                  ),
                  Text(
                  'CIN :' + user.cin.toString(),
                  style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                  height: 20,
                  ),
                  Text(
                  'Status :' + user.status,
                  style: TextStyle(fontSize: 20),
                  ),
                   SizedBox(height: 20,),
                   Text('Worked Hours :' + fp.forDurationHour(dTR).toString(),
                   style: TextStyle(fontSize: 20),)
                  ]),
                  SizedBox(height: 50,),
                  Center(
                    child: fp.forDurationMin(dTR)<1?Text("this user has no recorded Work Time"): Container(
                      child: Column(
                          children:[Container(
                            decoration: BoxDecoration(
                              color: Color(0x11000000),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Time Chart",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(height: 10),
                                  TimeChart(
                                      width: 400,
                                      height: 400,
                                      data: dTR,
                                      viewMode: ViewMode.weekly
                                  ),
                                ],
                              ),
                            ),
                          ),
                            SizedBox(height: 20,),
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0x11000000),
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              ) ,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    Text("Amount of Time",style: TextStyle(fontSize: 20),),
                                    SizedBox(height: 10,),
                                    TimeChart(
                                      width: 400,
                                      height: 400,
                                      data: dTR,
                                      viewMode: ViewMode.weekly,
                                      chartType: ChartType.amount,
                          ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 40,),
                            RoundedButton(Colors.teal, 'Alter User Presence',(){
                              Navigator.push(context,MaterialPageRoute(builder: (context) =>  AlterTime(dTR:dTR,cin:user.cin,fp: fp,user: admin,)));
                            } ),


                          ]
                      ),
                    ),
                  ),

                ],
              ),
            ),]
          ),
        ));
  }
}
