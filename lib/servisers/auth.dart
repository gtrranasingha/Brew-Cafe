

import 'package:BrewCafe/models/user.dart';
import 'package:BrewCafe/servisers/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices{
  final FirebaseAuth _auth=FirebaseAuth.instance;

      //create user object based on firebased user 2
  TheUser _theUserFromFirebase(User user){
    return user != null ? TheUser(uid: user.uid):null;
    
  }
    //auth change user stream 3
  Stream<TheUser> get user {
      return _auth.authStateChanges().
     // map((User user) => _theUserFromFirebase(user));
     map(_theUserFromFirebase);
  }  

    //sign in anon 1
  Future signinAnon() async{
    try{
    UserCredential result =await _auth.signInAnonymously();
    User user=result.user;
    return _theUserFromFirebase(user);

    }catch(e){
      print(e.toString());
      return null;
    }
  }
    //sign in with Email & password 5
    Future signInEmailAndPassword(String email,String password) async{
          try{
              UserCredential result=await _auth.signInWithEmailAndPassword(email: email, password: password);
              User user=result.user;
              return _theUserFromFirebase(user);
          }catch(e){
              print(e.toString());
              return null;
          }
    }


    //register in with Email & password 4
    Future registerEmailAndPassword(String email,String password) async{
          try{
              UserCredential result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
              User user=result.user;

              //create a new document for the user with the uid
              await DatabaseService(uid: user.uid).updateUserData('0','new crew member', 100);
              
              return _theUserFromFirebase(user);
          }catch(e){
              print(e.toString());
              return null;
          }
    }

    //sign out
    Future signOut() async{
      try{
          return await _auth.signOut();
      }catch(e){
        print(e.toString());
        return null;
      }
    }

}