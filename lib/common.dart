import 'package:firebase_auth/firebase_auth.dart';

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

  void logout() {
    this._auth.signOut();
  }


}
