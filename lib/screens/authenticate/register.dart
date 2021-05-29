
import 'package:BrewCafe/servisers/auth.dart';
import 'package:BrewCafe/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleview;
  Register({this.toggleview});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  
   final AuthServices _authServices=AuthServices();
   final _formkey=GlobalKey<FormState>();

  bool loading=false;

  String email="";
  String password="";
  String error="";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child:  loading ? Loading(): Scaffold(
         backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("Signup to Coffe House"),
          backgroundColor: Colors.brown,
          elevation: 0.0,
           actions: [
            FlatButton.icon(
              onPressed:(){
                 widget.toggleview();
              },
              icon: Icon(Icons.person),
              label: Text("Sign In"),
            ),
          ],
        ),
        body:  Container(
            padding: EdgeInsets.symmetric(horizontal: 40.0,vertical: 20.0),
            child: Form(
              key: _formkey,
              child: SingleChildScrollView(
                              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                     SizedBox(
                              height: 150.0,
                              width: 150,
                              child: Image.asset(
                                "img/coffee-logo.png",
                                fit: BoxFit.contain,
                              ),
                      ),
                   
                   
                   SizedBox(height: 30.0),
                   TextFormField(
                     validator: (value)=> value.isEmpty ? "Enter an Email":null,
                    decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Email",
                    border:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
                    ),
                     onChanged: (value){
                       setState(()=> email=value);
                     },
                  ),
                  SizedBox(height: 20.0),

                  TextFormField(
                    validator: (value)=> value.length<6 ? "Enter a Passworod +6 char long":null ,
                        
                  obscureText: true,
                  decoration: InputDecoration(
                   contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Password",
                    border:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
                  ),
                  onChanged: (value){
                    setState(()=> password =value);
                  },
                ),
                 SizedBox(height: 30.0),
                 
                Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.green[600],
            child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                onPressed: () async{
                        if(_formkey.currentState.validate()){
                          setState(() {
                            loading=true;
                          });
                              dynamic result=await _authServices.registerEmailAndPassword(email, password);
                             if(result==null){
                               setState(() {
                                 error="Please supply the valid email";
                                  loading=false;
                               });
                             }
                        }

                },
                child: Text("Register",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
                   SizedBox(height: 15.0),
                   Text(error,style: TextStyle(color: Colors.red,fontSize: 14.0),)

                 
                  ],
                ),
              ),
            ),
            
          ),
        
      ),
    );
  }
}