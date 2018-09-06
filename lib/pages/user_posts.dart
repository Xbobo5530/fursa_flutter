import 'package:flutter/material.dart';
import 'package:fursa_flutter/models/user.dart';
import 'package:fursa_flutter/pages/home.dart';

class UserPosts extends StatelessWidget {
  final User user;
  UserPosts(this.user);

  @override
  Widget build(BuildContext context) {
    var username = user.name;
    if (user != null) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('$username\'s posts'),
        ),
        body: new Center(
          child: new Text('user is ${user.name}'),
        ),
      );
    } else {
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new HomePage()));
    }
  }
}
