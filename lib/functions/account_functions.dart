import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fursa_flutter/models/user.dart';
import 'package:fursa_flutter/pages/user_profile.dart';
import 'package:fursa_flutter/values/strings.dart';

const tag = 'AccountFunctions: ';

class AccountFunctions {
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool isLoggedIn() {
    var user = getUser().whenComplete(() {
      print('$tag this is $this');
      return this;
    });
    print('$tag user is $user');
    return user != null ? true : false;
  }

  logout() {
    auth.signOut();
    print('$tag logout is called');
  }

  Future<FirebaseUser> getUser() async {
    return await this.auth.currentUser();
  }

  openUserProfileWithId(BuildContext context, String userId) async {
    await Firestore.instance
        .collection(USERS_COLLECTION)
        .document(userId)
        .get()
        .then((DocumentSnapshot document) {
      if (document.exists && document != null) {
        User user = User.fromSnapshot(document);
        openUserProfile(context, user);
      } else {
        print('$tag Error: user does not exists, snaphot returned null');
      }
    });
  }

  openUserProfile(BuildContext context, User user) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new UserProfilePage(user),
            fullscreenDialog: true));
  }
}
