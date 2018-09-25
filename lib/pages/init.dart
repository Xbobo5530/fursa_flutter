import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fursa_flutter/functions/functions.dart';
import 'package:fursa_flutter/pages/categories.dart';
import 'package:fursa_flutter/pages/home.dart';
import 'package:fursa_flutter/pages/notifications.dart';
import 'package:fursa_flutter/views/people_tab.dart';
import 'package:fursa_flutter/views/posts_tab.dart';
import 'package:fursa_flutter/values/strings.dart';
import 'package:fursa_flutter/views/main_drawer.dart';

const tag = 'HomePage: ';

class Init extends StatefulWidget {
  @override
  _InitState createState() => _InitState();
}

class _InitState extends State<Init> {
  final account = new Functions();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: new HomePage(),
//      bottomNavigationBar: BottomNavigationBar(
//          onTap: onTabTapped,
//          currentIndex: _currentIndex,
//          items: <BottomNavigationBarItem>[
//            new BottomNavigationBarItem(
//                icon: new Icon(Icons.home), title: new Text('Home')),
//            new BottomNavigationBarItem(
//                icon: new Icon(Icons.apps), title: new Text('Categories')),
//            new BottomNavigationBarItem(
//                icon: new Icon(Icons.notifications),
//                title: new Text('Notifications')),
//          ]),
      drawer: new MainDrawerView(),
    ));
  }
}
