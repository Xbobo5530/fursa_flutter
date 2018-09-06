import 'package:firebase_auth/firebase_auth.dart';
import 'package:fursa_flutter/models/user.dart';

class Common {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseAuth getAuth() { return FirebaseAuth.instance; }

  //todo figure out the current user anomaly
  bool isLoggedIn() {
    var user = _auth.currentUser();
    if (user != null) {
      print(user);
      return false;
    } else {
      print(user);
      return true;
    }
  }

  String getCurrentUserId(){
    if (this.isLoggedIn()){
      //todo get the user id of the current user
//      var currentUser = this._auth.currentUser();
//      var userId;
//      currentUser.whenComplete()
    }else{
      return 'testUserId';
    }
  }

//  User getUser(){
//    return _auth.currentUser(;
//  }

  void logout() {
    this._auth.signOut();
  }


}
