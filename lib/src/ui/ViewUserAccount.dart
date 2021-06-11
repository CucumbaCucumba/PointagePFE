import 'package:FaceNetAuthentication/src/ressources/NavBar.dart';
import 'package:FaceNetAuthentication/src/ui/AlterTime.dart';
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
                  Container(

                    width: 200,
                    height: 200,
                    child: Image(image: Image.file(user.decodedImage).image,),

                  ),
                  Text(
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
                  TextButton(
                    onPressed: ()async{
                      user = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminChangePass(user)
                        ),

                      );

                      Navigator.pop(context,user);
                    }, child: Text('Change User Info'),),

                  SizedBox(height: 50,),
                  Center(
                    child: fp.forDurationMin(dTR)<1?Text("this user has no recorded Work Time"): Container(
                      child: Column(
                          children:[TimeChart(
                              data: dTR,
                              viewMode: ViewMode.weekly
                          ),
                            SizedBox(height: 20,),
                            TimeChart(
                            data: dTR,
                            viewMode: ViewMode.weekly,
                            chartType: ChartType.amount,
                          ),
                            SizedBox(height: 40,),
                            RaisedButton(
                                child:Text('Alter User Presence') ,
                                onPressed:(){
                                  Navigator.push(context,MaterialPageRoute(builder: (context) =>  AlterTime(dTR:dTR,cin:user.cin,fp: fp,user: admin,)));
                                }),
                            SizedBox(height: 40,),
                            Text(fp.forDurationHour(dTR).toString()),
                            SizedBox(height: 20,),
                            Row(
                              children: [
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text('Hours'),
                                        Text(fp.forDurationHour(dTR).toString(),
                                        style: TextStyle(fontSize: 30),),
                                      ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                    border: Border.all(
                                      color: Colors.redAccent,
                                      width: 5,
                                      style: BorderStyle.solid
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(10))

                                  ),
                                ),
                                SizedBox(width: 20,),
                                Icon(
                                    FontAwesomeIcons.times,
                                  size: 60,

                                  ),
                                SizedBox(width: 20,),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text('Wage')
                                        ,
                                        Text(user.wage.toString(),
                                          style: TextStyle(fontSize: 30),),
                                      ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(0, 3), // changes position of shadow
                                        ),
                                      ],
                                      border: Border.all(
                                          color: Colors.redAccent,
                                          width: 5,
                                          style: BorderStyle.solid
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(10))

                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Icon (FontAwesomeIcons.equals,size: 60,),
                            SizedBox(height: 20,),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text((user.wage * fp.forDurationHour(dTR)).toString(),
                                      style: TextStyle(fontSize: 30),),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                  border: Border.all(
                                      color: Colors.redAccent,
                                      width: 5,
                                      style: BorderStyle.solid
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(10))

                              ),
                            ),


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
