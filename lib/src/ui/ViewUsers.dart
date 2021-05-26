import 'package:FaceNetAuthentication/src/blocs/UsersBloc.dart';
import 'package:FaceNetAuthentication/src/models/users.dart';
import 'package:FaceNetAuthentication/src/ressources/base64Functions.dart';
import 'package:flutter/material.dart';


class ViewUsers extends StatelessWidget {
  
  Base64Fun fun = Base64Fun();
  
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
                    decoration: BoxDecoration(
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
                        RaisedButton(
                          child: Text('View Account'),
                          onPressed: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                    ));
                          },
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