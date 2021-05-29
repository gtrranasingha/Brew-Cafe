
import 'package:BrewCafe/models/user.dart';
import 'package:BrewCafe/screens/authenticate/authenticate.dart';
import 'package:BrewCafe/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<TheUser>(context);
    print(user);
    //return HomePage or Athenticate
    if(user==null){
          return Authenticate();
    }else{
      return HomePage();
    }
    
    
  }
}