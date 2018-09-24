import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

const tag = 'AccountFunctions';

class AccountFunctions {
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool isLoggedIn() {
    var user = auth.currentUser().then((user) => print('$tag $user'));
    return user != null ? true : false;
  }

  logout() {
    if (this.isLoggedIn()) {
      auth.signOut();
      print('$tag logout is called');
    }
  }
}
