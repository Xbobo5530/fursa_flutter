import 'package:flutter/material.dart';

class UserPage extends StatelessWidget{

  final String pageName;
  UserPage(this.pageName);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(pageName),),
      body: new Center(
        child: new Text(pageName),
      ),
    );
  }

}