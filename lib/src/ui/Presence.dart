
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

  Presence(this.fp);
  final FichePresence fp ;



  @override
  Widget build(BuildContext context) {
    List<DateTimeRange> dTR = fp.fPRange();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: fp.forDurationMin(dTR)<1?Text("Look like you just started working here ,you need to do at least a day of work to check your presence"): Container(
                  child: Column(
                    children:[TimeChart(
                      data: dTR,
                      viewMode: ViewMode.weekly
                  ),TimeChart(
                        data: dTR,
                        viewMode: ViewMode.weekly,
                        chartType: ChartType.amount,
                    ),
                    Text(fp.forDurationHour(dTR).toString())]
                  ),
          ),
        ),
      ),
    );
  }


}
