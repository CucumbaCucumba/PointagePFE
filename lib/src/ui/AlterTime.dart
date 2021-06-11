import 'package:FaceNetAuthentication/src/models/User.dart';
import 'package:FaceNetAuthentication/src/ressources/NavBar.dart';
import 'package:FaceNetAuthentication/src/ressources/api_provider.dart';
import 'package:FaceNetAuthentication/src/ui/ViewUsers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Presence.dart';




class AlterTime extends StatefulWidget {

  List<DateTimeRange> dTR;
  int cin;
  FichePresence fp;
  User user;
  AlterTime({this.dTR,this.cin,this.fp,this.user});

  @override
  AlterTimeState createState() => AlterTimeState(this.dTR,this.cin,this.fp,this.user);
}

class AlterTimeState extends State<AlterTime> {

  AlterTimeState(this.dTR,this.cin,this.fPOriginal,this.admin);

  ApiService api = new ApiService();


  User admin;
  List<DateTimeRange> dTR;
  int cin;
  FichePresence fPOriginal;
  bool RlastFP = false;
  bool AlastFP = false;

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

  String fPeDdayDV = '';
  String fPeDhourDV = '';
  String fPeDminuteDV = '';
  String fPeDyearDV = '';
  String fPeDmonthDV = '';
  String fPlDdayDV = '';
  String fPlDhourDV = '';
  String fPlDminuteDV = '';

  List<String> year =["2021","2022","2023","2024","2025","2026","2027","2028","2029","2030","2031"];
  List<String> month =["1","2","3","4","5","6","7","8","9","10","11","12"];
  List<String> days = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"];
  List<String> hour = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23"];
  List<String> minute = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"];
  List<String> fdays = ["??","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"];
  List<String> fhour = ["??","0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23"];
  List<String> fminute = ["??","0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"];


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

    if(fPOriginal.iN){
      fPeDdayDV=(fPOriginal.dates[0].day.toString());
      fPeDhourDV=(fPOriginal.dates[0].hour.toString());
      fPeDminuteDV=(fPOriginal.dates[0].minute.toString());
      fPeDyearDV=(fPOriginal.dates[0].year.toString());
      fPeDmonthDV=(fPOriginal.dates[0].month.toString());
      fPlDdayDV=('??');
      fPlDhourDV=('??');
      fPlDminuteDV=('??');
    }

  if (aDTRC.isEmpty){
    for (int i=0;i<dTR.length+1;i++){
      aDTRC.add(Icon(FontAwesomeIcons.check,size: 20,color: Colors.white));
    }
  }
  if (aDTRIT.isEmpty){
    for (int i=0;i<dTR.length+1;i++){
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
        drawer: AdminNavBar(admin),
        extendBodyBehindAppBar: true,
        floatingActionButton: FloatingActionButton(
        child: Icon(FontAwesomeIcons.save),
        onPressed: ()async{
          FichePresence fP = FichePresence(cin,null,false);
          if(RlastFP == false){
          if(AlastFP){
            if(((fPlDdayDV!='??')&&(fPlDhourDV!='??')) && fPlDminuteDV!='??'){
            dTR.insert(0,DateTimeRange(start: DateTime(int.parse(fPeDyearDV),int.parse(fPeDmonthDV),int.parse(fPeDdayDV),
                int.parse(fPeDhourDV),int.parse(fPeDminuteDV)), end:DateTime(int.parse(fPeDyearDV),int.parse(fPeDmonthDV)
                ,int.parse(fPlDdayDV),int.parse(fPlDhourDV),int.parse(fPlDminuteDV))));}
            else{
              fP.dates.add(DateTime(int.parse(fPeDyearDV),int.parse(fPeDmonthDV),int.parse(fPeDdayDV),
                  int.parse(fPeDhourDV),int.parse(fPeDminuteDV)));
            }
          }
          }
          if(RlastFP){
            fPOriginal.dates.removeAt(0);
          }
          try {
            EasyLoading.show(status: 'Loading');
            fP.dates = rangeToFp(dTR,fPOriginal);
            await api.savePreDeterminedPresence(dTR,fP,cin);
            EasyLoading.dismiss();
            Navigator.push(context,MaterialPageRoute(builder: (context) => ViewUsers(admin)));

          }
          catch(e){

          }
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Change Presence'),
      ),
      body: ListView(
        children: [SafeArea(
          child: Column(
            children: [
              ///First Container
              (fPOriginal.iN )?Container(

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
                    ///first Year
                    DropdownButton<String>(
                      value: fPeDyearDV,
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
                          fPeDyearDV = newValue;
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
                    ///first Month
                    DropdownButton<String>(
                      value: (fPeDmonthDV),
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
                          fPeDmonthDV = newValue;
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
                    ///first Day
                    DropdownButton<String>(
                      value: fPeDdayDV,
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
                          fPeDdayDV = newValue;
                        });
                      },
                      items:   fdays.map<DropdownMenuItem<String>>((String value) {
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
                    ///first Hour
                    DropdownButton<String>(
                      value: fPeDhourDV,
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
                          fPeDhourDV = newValue;
                        });
                      },
                      items:  fhour.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(width: 10,),
                    /// first Minute
                    DropdownButton<String>(
                      value: fPeDminuteDV,
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
                          fPeDminuteDV = newValue;
                        });
                      },
                      items:   fminute.map<DropdownMenuItem<String>>((String value) {
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
                    ///Second year (Both first and second year share the same value)
                    DropdownButton<String>(
                      value: fPeDyearDV,
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
                          fPeDyearDV = newValue;
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
                      value: fPeDmonthDV,
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
                          fPeDmonthDV = newValue;
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
                      value: fPlDdayDV,
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
                          fPlDdayDV = newValue;
                        });
                      },
                      items:   fdays.map<DropdownMenuItem<String>>((String value) {
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
                      value: fPlDhourDV,
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
                          fPlDhourDV = newValue;
                        });
                      },
                      items:   fhour.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(width: 10,),
                    DropdownButton<String>(
                      value: fPlDminuteDV,
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
                          fPlDminuteDV = newValue;
                        });
                      },
                      items:   fminute.map<DropdownMenuItem<String>>((String value) {
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
                          child: aDTRIT.last
                      ),
                      onTap: (){
                        if(RlastFP==false){
                          aDTRIT.last = Icon(FontAwesomeIcons.times);
                        RlastFP = true;}
                        else{
                          RlastFP = false;
                          aDTRIT.last = Icon(FontAwesomeIcons.trash);}
                        }),



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
                          child: aDTRC.last
                      ),
                      onTap: (){
                        AlastFP = true;
                        setState(() {
                          aDTRC.last = Icon(FontAwesomeIcons.times,size: 20,color: Colors.white,);
                        });
                      },
                    )
                  ],
                )


              ],
            ),
          ):Container(),
              GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: dTR.length,
                  gridDelegate:
                  new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
                  itemBuilder: (BuildContext context, int index) {

                    return
                    Container(
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
            ],
          ),
        ),]
      )
    );
  }


  List<DateTime> rangeToFp(List<DateTimeRange> dt,FichePresence fp){

    List<DateTime> ld = []  ;
    for(int i = 0;i<dt.length;i++){
      ld.add(dt[i].end);
      ld.add(dt[i].start);
    }
    dynamic d = fp.dates.first;
    print('wow');
    fp.dates.length % 2 != 0?ld.add(d):print('wow');
    print('wow');
    return ld;
  }

}

