import 'package:FaceNetAuthentication/src/blocs/UsersBloc.dart';
import 'package:FaceNetAuthentication/src/models/users.dart';
import 'package:FaceNetAuthentication/src/ressources/RoundedButton.dart';
import 'package:FaceNetAuthentication/src/ressources/api_provider.dart';
import 'package:FaceNetAuthentication/src/ressources/base64Functions.dart';
import 'package:FaceNetAuthentication/src/ui/AVAdminAccount.dart';
import 'package:FaceNetAuthentication/src/models/User.dart';
import '../ui/Presence.dart';
import 'package:flutter/material.dart';
import 'package:FaceNetAuthentication/src/ui/ViewUserAccount.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'home.dart';


class ViewUsers extends StatelessWidget {
  
  Base64Fun fun = Base64Fun();
  ApiService api = new ApiService();
  User admin;

  ViewUsers(this.admin);

  @override
  Widget build(BuildContext context) {
    bloc.fetchAllUsers();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: Container(
        decoration: BoxDecoration(image: DecorationImage(image: Image.asset('assets/deepOrange.jpg').image,fit: BoxFit.cover)),
        child: StreamBuilder(
          stream: bloc.allMovies,
          builder: (context, AsyncSnapshot<Users> snapshot) {
            if (snapshot.hasData)
              if(snapshot.data.result != null){
              return buildList(snapshot);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget buildList(AsyncSnapshot<Users> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.result.length,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,childAspectRatio: 0.95),
        itemBuilder: (BuildContext context, int index) {

          return
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: snapshot.data.result[index].status=='admin'?Color(0x66000000):Color(0x33000000),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      border: Border.all(color: Colors.blueGrey)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              child: ClipOval(
                                child: Image(image: Image.file(snapshot.data
                                    .result[index].decodedImage).image,
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10,20,0,0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('User Name :'+ snapshot.data.result[index].userName,
                                        style:TextStyle(color: Colors.white,fontSize: 20)
                                    ),
                                    SizedBox(height: 15,),
                                    Text('CIN :'+ snapshot.data.result[index].cin.toString(),
                                        style:TextStyle(color: Colors.white,fontSize: 20) ),
                                    SizedBox(height: 15,),
                                    Text('Status :'+ snapshot.data.result[index].status,
                                      style:TextStyle(color: Colors.white,fontSize: 20) ,)
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundedButton(Color(0xFF14A6AF),"View Account",() async {
                               if(snapshot.data.result[index].status == 'user'){
                               EasyLoading.show(status: 'Loading');
                               try{
                               FichePresence fp = await api.loadPresence(snapshot.data.result[index].cin);
                               EasyLoading.dismiss();
                               Navigator.push(
                               context,
                               MaterialPageRoute(
                               builder: (BuildContext context) =>AdminViewAccount(user:User().fromSnap(snapshot.data.result, index),fp:fp,admin: admin,)
                               ));
                               }
                               catch(e){
                               EasyLoading.showError('Loading Failed');
                               }
                               }else{

                               Navigator.push(
                               context,
                               MaterialPageRoute(
                               builder: (BuildContext context) =>AdminViewAdminAccount(User().fromSnap(snapshot.data.result, index))
                               ));
                               EasyLoading.showSuccess('Success');

                               }
                               },),
                          ],
                        ),
                        snapshot.data.result[index].status=='user'?RoundedButton(Color(0xFF14A6AF),"Delete",(){
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: Text('this User will be deleted Permanently!'),
                                actions: [
                                  TextButton(
                                      onPressed:()async{
                                        try{
                                          EasyLoading.show(status: 'Loading');
                                          await ApiService().deleteUser(snapshot.data.result[index].cin.toString());
                                          EasyLoading.dismiss();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ViewUsers(admin)
                                            ),
                                          );}
                                        catch(e){
                                          EasyLoading.showError('Failure');
                                          Navigator.pop(context);
                                        }
                                      }
                                      , child: Text('Confirm')
                                  )],
                              ));
                        },):Container()
                      ],
                    ),
                  ),
                ),
              ),
            )
          ;

        });
  }
}