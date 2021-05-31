import 'package:FaceNetAuthentication/src/ressources/api_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'file:///E:/PointagePFE/lib/src/ui/Presence.dart';



class AlterTime extends StatefulWidget {

  List<DateTimeRange> dTR;
  int cin;

  AlterTime(this.dTR,this.cin);

  @override
  AlterTimeState createState() => AlterTimeState(this.dTR,this.cin);
}

class AlterTimeState extends State<AlterTime> {

  AlterTimeState(this.dTR,this.cin);

  ApiService api = new ApiService();



  List<DateTimeRange> dTR;
  int cin;

  List<Icon> aDTRC=[];
  List<Icon> aDTRIT=[];

  List<String> eDyearDV   = [];
  List<String> eDmonthDV  = [];
  List<String> eDdayDV    = [];
  List<String> eDhourDV   = [];
  List<String> eDminuteDV = [];
  List<String> lDyearDV   = [];
  List<String> lDmonthDV  = [];
  List<String> lDdayDV    = [];
  List<String> lDhourDV   = [];
  List<String> lDminuteDV = [];

  List<String> year =["2021","2022","2023","2024","2025","2026","2027","2028","2029","2030","2031"];
  List<String> month =["1","2","3","4","5","6","7","8","9","10","11","12"];
  List<String> days = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"];
  List<String> hour = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24"];
  List<String> minute = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60"];

  void remove(int index){

    eDdayDV.removeAt(index);
    eDhourDV.removeAt(index);
    eDminuteDV.removeAt(index);
    lDyearDV.removeAt(index);
    lDmonthDV.removeAt(index);
    lDdayDV.removeAt(index);
    lDhourDV.removeAt(index);
    lDminuteDV.removeAt(index);

  }

  @override
  void initState() {


  if (aDTRC.isEmpty){
    for (int i=0;i<dTR.length;i++){
      aDTRC.add(Icon(FontAwesomeIcons.check,size: 20,color: Colors.white));
    }
  }
  if (aDTRIT.isEmpty){
    for (int i=0;i<dTR.length;i++){
      aDTRIT.add(Icon(FontAwesomeIcons.trash,size: 20,color: Colors.white,));
    }
  }

    for (int i=0;i<dTR.length;i++) {


      eDdayDV.add(dTR[i].start.day.toString());
      eDhourDV.add(dTR[i].start.hour.toString());
      eDminuteDV.add(dTR[i].start.minute.toString());

      lDyearDV.add(dTR[i].end.year.toString());
      lDmonthDV.add(dTR[i].end.month.toString());
      lDdayDV.add(dTR[i].end.day.toString());
      lDhourDV.add(dTR[i].end.hour.toString());
      lDminuteDV.add(dTR[i].end.minute.toString());
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    print('oy');
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(FontAwesomeIcons.save),
        onPressed: ()async{
          FichePresence fP = FichePresence(cin,null,false);
          fP.dates = fP.RangeToFp(dTR);
            await api.savePresence(fP,cin);

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



              return Container(

                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueGrey)
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Entry',style: TextStyle(fontSize: 20),),
                    ),
                    /// Y/M/D Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownButton<String>(
                          value: lDyearDV[index],
                          icon: const Icon(FontAwesomeIcons.angleDown),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple,fontSize: 20),
                          underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                            lDyearDV[index] = newValue;
                          });
                          },
                          items:   year.map<DropdownMenuItem<String>>((String value) {
                         return DropdownMenuItem<String>(
                         value: value,
                         child: Text(value),
                         );
                    }).toList(),
                    ),
                        SizedBox(width: 10,),
                        Text('/',style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),),
                        SizedBox(width: 10,),
                        DropdownButton<String>(
                          value: (lDmonthDV[index]),
                          icon: const Icon(FontAwesomeIcons.angleDown),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple,fontSize: 20),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              lDmonthDV[index] = newValue;
                            });
                          },
                          items:   month.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        SizedBox(width: 10,),
                        Text('/',style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),),
                        SizedBox(width: 10,),
                        DropdownButton<String>(
                          value: eDdayDV[index],
                          icon: const Icon(FontAwesomeIcons.angleDown),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple,fontSize: 20),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              eDdayDV[index] = newValue;
                            });
                          },
                          items:   days.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                    ],
                    ),
                    /// Hours/Minutes Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownButton<String>(
                          value: eDhourDV[index],
                          icon: const Icon(FontAwesomeIcons.angleDown),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple,fontSize: 20),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              eDhourDV[index] = newValue;
                            });
                          },
                          items:   hour.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        SizedBox(width: 10,),
                        DropdownButton<String>(
                          value: eDminuteDV[index],
                          icon: const Icon(FontAwesomeIcons.angleDown),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple,fontSize: 20),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              eDminuteDV[index] = newValue;
                            });
                          },
                          items:   minute.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    SizedBox(height: 40,),
                    Text('Leave',style: TextStyle(fontSize: 20),),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownButton<String>(
                          value: lDyearDV[index],
                          icon: const Icon(FontAwesomeIcons.angleDown),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple,fontSize: 20),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              lDyearDV[index] = newValue;
                            });
                          },
                          items:   year.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        SizedBox(width: 10,),
                        Text('/',style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),),
                        SizedBox(width: 10,),
                        DropdownButton<String>(
                          value: lDmonthDV[index],
                          icon: const Icon(FontAwesomeIcons.angleDown),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple,fontSize: 20),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              lDmonthDV[index] = newValue;
                            });
                          },
                          items:   month.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        SizedBox(width: 10,),
                        Text('/',style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),),
                        SizedBox(width: 10,),
                        DropdownButton<String>(
                          value: lDdayDV[index],
                          icon: const Icon(FontAwesomeIcons.angleDown),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple,fontSize: 20),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              lDdayDV[index] = newValue;
                            });
                          },
                          items:   days.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownButton<String>(
                          value: lDhourDV[index],
                          icon: const Icon(FontAwesomeIcons.angleDown),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple,fontSize: 20),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              lDhourDV[index] = newValue;
                            });
                          },
                          items:   hour.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        SizedBox(width: 10,),
                        DropdownButton<String>(
                          value: lDminuteDV[index],
                          icon: const Icon(FontAwesomeIcons.angleDown),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple,fontSize: 20),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              lDminuteDV[index] = newValue;
                            });
                          },
                          items:   minute.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.all(Radius.circular(30))
                              ),
                              child: aDTRIT[index]
                          ),
                          onTap: (){
                            dTR.removeAt(index);
                            remove(index);
                              setState(() {

                            });

                          },
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          child: Container(
                            width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.lightGreen,
                                borderRadius: BorderRadius.all(Radius.circular(30))
                              ),
                              child: aDTRC[index]
                          ),
                          onTap: (){
                            dTR.replaceRange(index, index+1, [(DateTimeRange(start: DateTime(int.parse(lDyearDV[index]),int.parse(lDmonthDV[index]),int.parse(eDdayDV[index]),
                                int.parse(eDhourDV[index]),int.parse(eDminuteDV[index])), end:DateTime(int.parse(lDyearDV[index]),int.parse(lDmonthDV[index])
                                ,int.parse(lDdayDV[index]),int.parse(lDhourDV[index]),int.parse(lDminuteDV[index]))))]);
                            setState(() {
                              aDTRC[index] = Icon(FontAwesomeIcons.times,size: 20,color: Colors.white,);
                            });
                          },
                        )
                      ],
                    )


                  ],
                ),
              );
            }),
      )
    );
  }


}

