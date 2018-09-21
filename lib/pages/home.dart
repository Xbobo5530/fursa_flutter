import 'package:flutter/material.dart';
import 'package:fursa_flutter/pages/people_tab.dart';
import 'package:fursa_flutter/pages/posts_tab.dart';
import 'package:fursa_flutter/values/strings.dart';
import 'package:fursa_flutter/views/bottom_nav_bar.dart';
import 'package:fursa_flutter/views/main_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String url = 'https://firebasestorage.googleapis.com'
      '/v0/b/fursa-c181d.appspot.com/o/ic_launcher-web.png'
      '?alt=media&token=4ebbe991-147c-4b87-8985-462fd2052b0a';

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
          drawer: new MainDrawerView(),
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
