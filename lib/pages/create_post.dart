import 'package:flutter/material.dart';

class CreatePost extends StatelessWidget {
  final String pageName = 'Create post';
  CreatePost();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(pageName),
        actions: <Widget>[
          FlatButton(
            child: new Text('Submit'),
            textColor: Colors.white,
            onPressed: () {},
          )
        ],
      ),
      body: new Center(child: new Column()),
    );
  }
}
