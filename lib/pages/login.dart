import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fursa_flutter/values/strings.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {
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

  _signInWithGoogle(BuildContext context) {
    var user = _handleGoogleSignIn()
        .then((FirebaseUser user) => print(user))
        .catchError((e) => print(e));
    user != null ? Navigator.pop(context) : new CircularProgressIndicator();
  }

  GoogleSignIn _googleSignInScopes = new GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

//  _signInWithGoogle() async {
//    try {
//      await _googleSignInScopes.signIn();
//    } catch (error) {
//      print(error);
//    }
//  }

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
}
