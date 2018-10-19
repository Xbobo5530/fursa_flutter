import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fursa_flutter/functions/functions.dart';
import 'package:fursa_flutter/values/strings.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:firebase_auth/firebase_auth.dart';

const tag = 'LoginPage:';
final functions = Functions();

class LoginPage extends StatelessWidget {
  final _loginMessage;
  LoginPage(this._loginMessage);

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(loginText),
      ),
      body: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _loginMessage,
              style: new TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
            RaisedButton(
              child: Text(googleSignInText),
              onPressed: () => _signInWithGoogle(context),
              color: Colors.blue,
              textColor: Colors.white,
            ),
            RaisedButton(
              child: Text(twitterSignInText),
              onPressed: () => _signInWithTwitter(),
              color: Colors.blue,
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  _signInWithGoogle(BuildContext context) async {
    var user =
        await _handleGoogleSignIn().catchError((error) => print('$tag $error'));
    if (user != null) {
      //check if is new user
      var userId = user.uid;
      _checkIfUserExists(context, user);
    }
  }

  GoogleSignIn _googleSignInScopes = new GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<FirebaseUser> _handleGoogleSignIn() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    FirebaseUser user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print("signed in " + user.displayName);
    return user;
  }

  _signInWithTwitter() {}

  _checkIfUserExists(BuildContext context, FirebaseUser user) async {
    final userId = user.uid;
    DocumentSnapshot document = await functions.database
        .collection(USERS_COLLECTION)
        .document(userId)
        .get();
    document.exists ? Navigator.pop(context) : _registerUser(context, user);
  }

  _registerUser(BuildContext context, FirebaseUser user) async {
    /// create a map for the user
    /// add the map to the database
    /// pop context

    final userMap = {
      'name': user.displayName,
      'image': user.photoUrl,
    };

    await functions.database
        .collection(USERS_COLLECTION)
        .add(userMap)
        .catchError((error) => print('$tag Error adding new user: $error'));

    Navigator.pop(context);
  }
}
