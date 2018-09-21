import 'package:flutter/material.dart';

class BottomNavView extends StatefulWidget {
  @override
  _BottomNavViewState createState() => _BottomNavViewState();
}

class _BottomNavViewState extends State<BottomNavView> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        new BottomNavigationBarItem(
            icon: new Icon(Icons.home), title: new Text('Home')),
        new BottomNavigationBarItem(
            icon: new Icon(Icons.apps), title: new Text('Categories')),
        new BottomNavigationBarItem(
            icon: new Icon(Icons.notifications),
            title: new Text('Notifications')),
      ],
    );
  }
}
