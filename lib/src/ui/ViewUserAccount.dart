import 'package:FaceNetAuthentication/src/ui/AlterTime.dart';

import 'adminChangeUserInfo.dart';
import 'file:///E:/PointagePFE/lib/src/ui/changeUserInfo.dart';
import 'file:///E:/PointagePFE/lib/src/ui/Presence.dart';
import 'package:FaceNetAuthentication/src/models/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:time_chart/time_chart.dart';


// ignore: must_be_immutable
class AdminViewAccount extends StatelessWidget {
  AdminViewAccount(this.u,this.fp);

  FichePresence fp;
  User u;

  @override
  Widget build(BuildContext context) {
    List<DateTimeRange> dTR = fp.fPRange();
    return Scaffold(
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
                            builder: (context) => AdminChangePass(u)
                        ),

                      );
                      Navigator.pop(context,u);
                    }, child: Text('Change User Info'),),

                  SizedBox(height: 50,),
                  Center(
                    child: fp.forDuration(dTR)<1?Text("this user has no recorded hours"): Container(
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
                                  Navigator.push(context,MaterialPageRoute(builder: (context) =>  AlterTime(dTR)));
                                }),
                            SizedBox(height: 40,),
                            Text(fp.forDuration(dTR).toString()),
                            SizedBox(height: 20,),
                            Row(
                              children: [
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(fp.forDuration(dTR).toString(),
                                    style: TextStyle(fontSize: 30),),
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
                                SizedBox(width: 50,),
                                Icon(
                                    FontAwesomeIcons.times,
                                  size: 60,

                                  ),
                                SizedBox(width: 50,),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text('Wage')
                                        ,
                                        Text(u.wage.toString(),
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
                            )

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
