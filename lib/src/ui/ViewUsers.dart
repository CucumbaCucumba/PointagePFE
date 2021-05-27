import 'package:FaceNetAuthentication/src/blocs/UsersBloc.dart';
import 'package:FaceNetAuthentication/src/models/users.dart';
import 'package:FaceNetAuthentication/src/ressources/api_provider.dart';
import 'package:FaceNetAuthentication/src/ressources/base64Functions.dart';
import 'package:FaceNetAuthentication/src/ui/AVAdminAccount.dart';
import 'package:FaceNetAuthentication/src/models/User.dart';
import 'file:///E:/PointagePFE/lib/src/ui/Presence.dart';
import 'package:flutter/material.dart';
import 'package:FaceNetAuthentication/src/ui/ViewUserAccount.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class ViewUsers extends StatelessWidget {
  
  Base64Fun fun = Base64Fun();
  ApiService api = new ApiService();
  
  @override
  Widget build(BuildContext context) {
    bloc.fetchAllUsers();
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: StreamBuilder(
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
    );
  }

  Widget buildList(AsyncSnapshot<Users> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.result.length,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
        itemBuilder: (BuildContext context, int index) {

          return
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 170,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: snapshot.data.result[index].status=='admin'?Colors.lightGreen:Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      border: Border.all(color: Colors.blueGrey)
                  ),

                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image(
                              height: 200,
                              image: Image.file(snapshot.data
                                  .result[index].decodedImage).image,),

                            Center(
                              child: Column(

                                children: [
                                  Text('User Name :'+ snapshot.data.result[index].userName),
                                  SizedBox(height: 30,),
                                  Text('CIN :'+ snapshot.data.result[index].cin.toString()),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 40),
                        Row(
                          children: [
                            RaisedButton(
                              child: Text('View Account'),
                              onPressed: () async {

                                if(snapshot.data.result[index].status == 'user'){
                                  FichePresence fp = await api.loadPresence(snapshot.data.result[index].cin);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>AdminViewAccount(User().fromSnap(snapshot.data.result, index),fp)
                                      ));
                                }else{

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>AdminViewAdminAccount(User().fromSnap(snapshot.data.result, index))
                                      ));

                                }
                              },
                            ),
                            SizedBox(width: 50,),
                            Icon(
                                FontAwesomeIcons.trash
                            )
                          ],
                        )
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