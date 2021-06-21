import 'package:FaceNetAuthentication/src/models/User.dart';
import 'package:FaceNetAuthentication/src/ressources/api_provider.dart';
import 'package:FaceNetAuthentication/src/ui/Presence.dart';
import 'package:FaceNetAuthentication/src/ui/ViewAccountAdmin.dart';
import 'package:FaceNetAuthentication/src/ui/ViewUsers.dart';
import 'package:FaceNetAuthentication/src/ui/adminProfile.dart';
import 'package:FaceNetAuthentication/src/ui/check.dart';
import 'package:FaceNetAuthentication/src/ui/home.dart';
import 'package:FaceNetAuthentication/src/ui/sign-up-First.dart';
import 'package:FaceNetAuthentication/src/ui/userProfile.dart';
import 'package:FaceNetAuthentication/src/ui/viewAccount.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminNavBar extends StatelessWidget {
   User user;

   AdminNavBar(this.user);



   @override
  Widget build(BuildContext context) {
     SystemChrome.setEnabledSystemUIOverlays([]);
     return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user.user,style: TextStyle(fontSize: 15,),),
            accountEmail: Text(user.status,style: TextStyle(fontSize: 15),),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image(image: Image.file(user.decodedImage).image,
                  fit: BoxFit.cover,
                  width: 120,
                  height: 120,
                ),
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(image: Image.asset('assets/deepOrange.jpg').image,fit: BoxFit.cover),
              ),
            ),

          ListTile(
            leading: Icon(FontAwesomeIcons.home),
            title: Text('Home Screen'),
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=> AdminProfile(username: user))
              );
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.plus),
            title: Text('Create Account'),
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=> SignUp(cameraDescription: user.cD))
              );
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.users),
            title: Text('Users'),
            onTap: (){
               Navigator.push(context,
               MaterialPageRoute(builder: (context)=> ViewUsers(user))
              );
              }),
          ListTile(
            leading: Icon(FontAwesomeIcons.cog),
            title: Text('Settings'),
            onTap: ()async{
              await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ViewAccountAdmin(user)
                ),
              );
            }
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.signOutAlt),
            title: Text('Logout'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyHomePage()
                ),
              );
            },
          ),
        ],
      ),

    );
  }
}

class NavBar extends StatelessWidget {
  User user;
  FichePresence fp;
  ApiService API;

  NavBar(this.user,this.fp);



  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user.user,style: TextStyle(fontSize: 15,),),
            accountEmail: Text(user.status,style: TextStyle(fontSize: 15),),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image(image: Image.file(user.decodedImage).image,
                  fit: BoxFit.cover,
                  width: 120,
                  height: 120,
                ),
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(image: Image.asset('assets/deepOrange.jpg').image,fit: BoxFit.cover),
            ),
          ),

           ListTile(
           leading: Icon(FontAwesomeIcons.home),
             title: Text('Home Screen'),
              onTap: (){
               Navigator.push(context,
                 MaterialPageRoute(builder: (context)=> Profile(username: user, fp: fp))
               );
              },
           ),
          ListTile(
            leading: Icon(FontAwesomeIcons.chartBar),
            title: Text('Presence'),
            onTap:() {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Presence(fp,user)
                ),
              );
            },
          ),
          ListTile(
              leading: Icon(FontAwesomeIcons.users),
              title: Text('IN/OUT'),
              onTap: () async{
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Check(fp: fp,user: user)
                  ),
                );

                fp = await API.loadPresence(user.cin);
              }),
          ListTile(
              leading: Icon(FontAwesomeIcons.cog),
              title: Text('Settings'),
              onTap: ()async{
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ViewAccount(user,fp)
                  ),
                );
              }
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.signOutAlt),
            title: Text('Logout'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyHomePage()
                ),
              );
            },
          ),
        ],
      ),

    );
  }
}