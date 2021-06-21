import 'file:///E:/PointagePFE/lib/src/ui/changeUserInfo.dart';
import 'package:FaceNetAuthentication/src/models/User.dart';
import 'package:FaceNetAuthentication/src/ressources/NavBar.dart';
import 'package:FaceNetAuthentication/src/ui/Presence.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class ViewAccount extends StatelessWidget {
  ViewAccount(this.u,this.fp);

  User u;
  FichePresence fp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(u,fp),
      appBar: AppBar(title: Text(u.user +' Profile''s') ,backgroundColor: Colors.transparent,),
        body:  Padding(
          padding: const EdgeInsets.fromLTRB(0,20,0,0),
          child: Column(
            children: [
              Stack(
                children: <Widget>[
                  CircleAvatar(
                    radius: 80,
                    child: ClipOval(child: Image(image: Image.file(u.decodedImage).image, height: 150, width: 150, fit: BoxFit.cover,),),
                  ),
                  Positioned(right: 1,bottom: 1 ,child: GestureDetector(
                    onTap: ()async{
                      u = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangePass(u,fp)
                        ),

                      );
                      Navigator.pop(context,u);
                    },
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
              SizedBox(height: 40,),
              Expanded(
                child: Container(
                  width: 600,
                  decoration: BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(30)),image: DecorationImage(image: Image.asset('assets/deepOrange.jpg').image,fit: BoxFit.cover)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(color: Color(0x33000000),borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        children: [
                          SizedBox(height: 65,),
                          Text(
                            'User :' + u.user,
                            style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'CIN :' + u.cin.toString(),
                            style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Status :' + u.status,
                            style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),

      /*Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
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
                          builder: (context) => ChangePass(u)
                      ),

                    );
                    Navigator.pop(context,u);
                  }, child: Text('Change User Info'),),

              ],
            ),
          ),
        )*/);
  }
}
