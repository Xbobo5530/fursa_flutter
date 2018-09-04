import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fursa_flutter/common.dart';
import 'package:fursa_flutter/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:flutter_firebase_ui/flutter_firebase_ui.dart';

final GoogleSignIn _googleSignIn = new GoogleSignIn();

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  var _message;

  @override
  Widget build(BuildContext context) {
        if (Common().isLoggedIn())
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new HomePage()));
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Login'),
      ),
      body: new Center(
          child: new Column(
            children: <Widget>[
              MaterialButton(
                  onPressed: (){
                    setState(() {
                      _message = _signInWithGoogle();
                    });},
                  child: new Text('Login with Google'))
            ],
          )
      ),
    );
  }

  Future<String> _signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;
//    final FirebaseUser user = await _auth.signInWithGoogle(
    final FirebaseUser user = await Common().getAuth().signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await Common().getAuth().currentUser();
    assert(user.uid == currentUser.uid);

    return 'signInWithGoogle succeeded: $user';
  }
}
