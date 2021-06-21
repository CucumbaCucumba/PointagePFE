import 'package:FaceNetAuthentication/src/models/User.dart';
import 'package:FaceNetAuthentication/src/ressources/NavBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_chart/time_chart.dart';

class FichePresence {
  int cin ;
  List<DateTime> dates ;
  bool iN ;
  FichePresence(this.cin, this.dates,this.iN);
  //change fp dates to a list of daterange for the timechart

  double forDurationMin(List<DateTimeRange> dtr){
    double duration = 0;

    for (int i=0;i<dtr.length;i++){

      duration = duration + dtr[i].duration.inMinutes;

    }
    return duration;
  }

  List<DateTimeRange> fPRange(){

    List<DateTimeRange> data = [];
    if((this.dates.length % 2) == 0)
    {
    for (int i =0 ; i<this.dates.length;i=i+2){
      data.add(DateTimeRange(start: this.dates[i+1],end: this.dates[i]));
    }
    return data;
    }else{
      for (int i =1 ; i<this.dates.length;i=i+2){
        data.add(DateTimeRange(start: this.dates[i+1],end: this.dates[i]));
      }
      return data;
    }


  }




  int forDurationHour(List<DateTimeRange> dtr){
    double duration = 0;

    for (int i=0;i<dtr.length;i++){

      duration = duration + dtr[i].duration.inHours;

    }
    return duration.round();
  }

}

class Presence extends StatelessWidget{

  Presence(this.fp,this.user);
  final FichePresence fp ;
  final User user;

  @override
  Widget build(BuildContext context) {
    List<DateTimeRange> dTR = fp.fPRange();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: Text("Presence Time Charts"),backgroundColor: Colors.transparent,),
      body: ListView(
        children: [
          SafeArea(
            child: Center(
              child: fp.forDurationMin(dTR)<1?Text("Look like you just started working here ,you need to do at least a day of work to check your presence",style: TextStyle(fontSize: 20),): Container(
                      child: Column(
                        children:[
                          SizedBox(height: 20),
                          Text("Work Time : "+ fp.forDurationHour(dTR).toString() +" Hours",style: TextStyle(fontSize: 20),),
                          SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                            decoration: BoxDecoration(color: Color(0x22000000),borderRadius: BorderRadius.all(Radius.circular(10))),
                            child: Column(
                              children: [
                                Text("Time Chart",style: TextStyle(fontSize: 20),),
                                SizedBox(height: 10,),
                                TimeChart(
                                  width: 400,
                                  height: 200,
                                  data: dTR,
                                  viewMode: ViewMode.weekly
                      ),
                              ],
                            ),
                        ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(color: Color(0x22000000),borderRadius: BorderRadius.all(Radius.circular(10))),
                              child: Column(
                                children: [
                                  Text("Duration Chart",style: TextStyle(fontSize: 20),),
                                  SizedBox(height: 10,),
                                  TimeChart(
                                    width: 400,
                                    height: 200,
                                    data: dTR,
                                    viewMode: ViewMode.weekly,
                                    chartType: ChartType.amount,
                        ),
                                ],
                              ),
                            ),
                          ),
                        ]
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }


}
