import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AlterTime extends StatefulWidget {

  List<DateTimeRange> dTR;

  AlterTime(this.dTR);

  @override
  AlterTimeState createState() => AlterTimeState(this.dTR);
}

class AlterTimeState extends State<AlterTime> {

  AlterTimeState(this.dTR);

  List<DateTimeRange> dTR;
  List<DateTimeRange> aDTR;

  @override
  Widget build(BuildContext context) {
    aDTR = dTR;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(FontAwesomeIcons.check),
        onPressed: (){

        },
      ),
      appBar: AppBar(
        title: Text('Change Presence'),
      ),
      body: SafeArea(
        child: GridView.builder(
            itemCount: dTR.length,
            gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
            itemBuilder: (BuildContext context, int index) {
              final TextEditingController _EyearTEC = TextEditingController(text: '');
              final TextEditingController _EmonthTEC = TextEditingController(text: '');
              final TextEditingController _EdayTEC = TextEditingController(text: '');
              final TextEditingController _LyearTEC = TextEditingController(text: '');
              final TextEditingController _LmonthTEC = TextEditingController(text: '');
              final TextEditingController _LdayTEC = TextEditingController(text: '');
              return Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueGrey)
                ),
                child: Column(
                  children: [
                    Text('Entrance'),
                    Row(
                      children: [
                        TextField(
                          controller: _EyearTEC,
                          decoration: InputDecoration(labelText: dTR[index].toString() ),
                        )

                      ],
                    ),
                  ],
                ),
              );
            }),
      )
    );
  }


}

