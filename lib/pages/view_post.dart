import 'package:flutter/material.dart';
import 'package:fursa_flutter/pages/home.dart';

class ViewPost extends StatelessWidget{

  final String postId;
  ViewPost(this.postId);

  @override
  Widget build(BuildContext context) {
    if (postId == null) {
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new HomePage()));
    } else {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('View Post'),),
        body: new Center(
          child: new Text('View Post'),
        ),
      );
    }
  }

}