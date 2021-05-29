import 'package:BrewCafe/models/brew.dart';
import 'package:BrewCafe/screens/home/brewList.dart';
import 'package:BrewCafe/screens/home/settingForm.dart';
import 'package:BrewCafe/servisers/auth.dart';
import 'package:BrewCafe/servisers/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {

  final AuthServices _auth= AuthServices();
  @override
  Widget build(BuildContext context) {

    void _showSettingPanel(){
       showModalBottomSheet(context: context, builder:(context){
         return Container(
           
           padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
           child:SettingForm(),
         );
       });
    }
    return StreamProvider< List<Brew>>.value(
      
       value: DatabaseService().brews,
          child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown,
          title: Text("Brew Cafe"),
          elevation: 0.0,
          actions: [
            FlatButton.icon(
              onPressed: ()async{
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text("logout"),

              ),
              FlatButton.icon(
                onPressed:()=> _showSettingPanel(),
               icon: Icon(Icons.settings),
                label:Text("Setting")
                )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("img/4-2-coffee-beans.png"),
              fit: BoxFit.cover,
              
            ),
          ),
          child: BrewList()
          ),
      ),
    );
  }
}