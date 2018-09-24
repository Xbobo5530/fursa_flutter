import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fursa_flutter/functions/account_functions.dart';
import 'package:fursa_flutter/pages/people_tab.dart';
import 'package:fursa_flutter/pages/posts_tab.dart';
import 'package:fursa_flutter/values/strings.dart';
import 'package:fursa_flutter/views/bottom_nav_bar.dart';
import 'package:fursa_flutter/views/main_drawer.dart';

const tag = 'HomePage: ';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final account = new AccountFunctions();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(APP_NAME),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.timelapse), text: recentText),
                Tab(icon: Icon(Icons.group), text: peopleText),
              ],
            ),
          ),
          bottomNavigationBar: new BottomNavView(),
          drawer: new MainDrawerView(account.isLoggedIn()),
          floatingActionButton: new FloatingActionButton(
              backgroundColor: Colors.red,
              child: new Icon(Icons.add),
              onPressed: _createPost),
          body: TabBarView(
            children: [
              new PostsTab(),
              new PeopleTab(),
            ],
          ),
        ),
      ),
    );
  }

  void _createPost() {}
}
