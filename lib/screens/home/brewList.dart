import 'package:BrewCafe/models/brew.dart';
import 'package:BrewCafe/screens/home/brew_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews= Provider.of< List<Brew>>(context) ?? [];

      // if(brews!=null){
        
      //     brews.forEach((element) { 
      //       print(element.name);
      //       print(element.strength);
      //       print(element.surgar);
      //     });
      // }    
    
    return  brews == null ? Container(width: 0.0,height: 0.0,): ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context,index){
        return BrewTile(brew:brews[index]);
      }
      
    );
  }
}