import 'package:FaceNetAuthentication/pages/Presence.dart';
import 'package:FaceNetAuthentication/pages/widgets/auth-action-button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'db/database.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Center(
          child: Container(
            child:Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
              style: TextButton.styleFrom(
                minimumSize: List,
              primary: Colors.white,
                backgroundColor:Colors.teal,
              ),
                        onPressed: () async {
                      DataBaseService db = new DataBaseService();
                      if(fp.iN == false){
                        fp=await db.savePresence(fp,user.cin);
                        Navigator.pop(context,fp);
                      }else{
                        print('user already checked in');
                      }
                    },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('IN',style:TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontStyle: FontStyle.italic,)),
                        )),
                  ),
                TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor:Colors.teal,

                      ),
                    onPressed: ()async{
                      DataBaseService db = new DataBaseService();
                      if(fp.iN == true){
                        fp=await db.savePresence(fp,user.cin);
                      }else{
                        print('user did not check in');
                      }
                    },
                    child: Text('OUT',style:TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontStyle: FontStyle.italic,)))
                ],
              ),
            ) ,
          ),
        ),
      )
      ,
    );
  }


}