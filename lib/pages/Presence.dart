
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_chart/time_chart.dart';

class FichePresence {
  int cin ;
  List<DateTime> dates ;
  bool iN ;
  FichePresence(this.cin, this.dates,this.iN);
  List<DateTimeRange> fPRange(){

    List<DateTimeRange> data = [];
    for (int i =0 ; i<this.dates.length;i=i+2){
      data.add(DateTimeRange(start: this.dates[i],end: this.dates[i+1]));
    }
    return data;
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
          child: Container(
                  child: Column(
                    children:[TimeChart(
                      data: dTR,
                      viewMode: ViewMode.weekly
                  ),TimeChart(
                        data: dTR,
                        viewMode: ViewMode.weekly,
                        chartType: ChartType.amount,
                    )]
                  ),
          ),
        ),
      ),
    );
  }


}
