import 'package:BrewCafe/models/user.dart';
import 'package:BrewCafe/servisers/database.dart';
import 'package:BrewCafe/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingForm extends StatefulWidget {
  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {  
        
        final _formkey= GlobalKey<FormState>();
        final List<String> sugars=['0','1','3','4'];

        String _currenName;
        String _currentSugar;
        int _currentStength;
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<TheUser>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid:user.uid).userData,

      builder: (context, snapshot) {
        if(snapshot.hasData){

                UserData user=snapshot.data;
                return Form(
          key: _formkey,
          child: Column(
            children: [
                Text("Update your brew setting",style: TextStyle(fontSize: 18.0),),
                 SizedBox(height: 8.0),
                 TextFormField(
                          initialValue:user.name ,
                         validator: (value)=> value.isEmpty ? "Insert Brew member name":null,
                        decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Member Name",
                        // border:
                        //     OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
                        ),
                         onChanged: (value){
                           setState(()=>_currenName=value);
                         },
                      ),
                      SizedBox(height: 20.0),
                      //dropdown
                    DropdownButtonFormField(

                      value: _currentSugar ?? user.sugar,
                      decoration: InputDecoration(
                      
                        labelText:"Sugar Count",
                      ),
                      items:  sugars.map((e) {
                        return DropdownMenuItem(
  
                          value: e,
                          child:Text("$e Sugars")
                          );
                      }).toList(), 
                       onChanged: (value){
                           setState(()=>_currentSugar=value);
                         },
                      
                      ),
                      SizedBox(height: 20.0),
                      //slider
                        Slider(
                          activeColor: Colors.brown[_currentStength ?? user.strenght],
                          inactiveColor: Colors.brown[_currentStength ?? user.strenght],
                          min: 100.0,
                          max: 900.0,
                          divisions: 8,
                          //label:  _currentStength.toString(),
                          value: (_currentStength ?? user.strenght ).toDouble(), 
                          onChanged: (value){
                           setState(()=>_currentStength=value.round());
                         },
                          ),
                          SizedBox(height: 20.0),
                 RaisedButton(
                   // minWidth: MediaQuery.of(context).size.width,
                    color: Colors.pink[400],
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: ()async{
                    if(_formkey.currentState.validate()){
                      return DatabaseService(uid: user.uid).
                      updateUserData(
                        _currentSugar ?? user.sugar,
                         _currenName ?? user.name,
                          _currentStength ?? user.strenght
                          );
                          Navigator.of(context).pop();
                    }
                     
                      
                    },
                    child: Text("Update",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              
            ],
          ),
        );
        }else{
                return Loading();  
        }
        
      }
    );
  }
}