import 'package:BrewCafe/models/brew.dart';
import 'package:BrewCafe/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});

  //collection  reference
  final CollectionReference brewcollection=FirebaseFirestore.instance.collection("brews");

  Future updateUserData(String sugars,String name,int strength) async{
          return await brewcollection.doc(uid).set({
                'sugars': sugars,
                'name': name,
                'strength': strength,
          });

  }
  //brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot querySnapshot){
            return querySnapshot.docs.map((doc) {
                return Brew(
                  name: doc.data()['name'] ?? " ",
                  strength: doc.data()['strength'] ?? 0,
                  surgar: doc.data()['sugars'] ?? "0"
                );
            }).toList();
  }
  //userdata from snapshot
  UserData _userDataSnapShot(DocumentSnapshot documentSnapshot){
    return UserData(
      uid: uid,
      name: documentSnapshot.data()['name'],
      sugar: documentSnapshot.data()['sugar'],
      strenght: documentSnapshot.data()['strength']
    );

  }
  //get brew stream
  Stream< List<Brew>> get brews{
      return brewcollection.snapshots().map(_brewListFromSnapshot);
  }
  //get user doc stream
  Stream< UserData> get userData{
    return brewcollection.doc(uid).snapshots().map(_userDataSnapShot);
  }
  
}
