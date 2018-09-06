import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fursa_flutter/models/user.dart';
import 'package:fursa_flutter/pages/login.dart';
import 'package:fursa_flutter/pages/people_tab.dart';
import 'package:fursa_flutter/pages/posts_tab.dart';
import 'package:fursa_flutter/pages/user_posts.dart';
import 'package:fursa_flutter/views/navigation_drawer.dart';
import './user_profile.dart';
import 'package:url_launcher/url_launcher.dart';
import './create_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fursa_flutter/common.dart';

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
    var currentUser;
    if (Common().isLoggedIn()) {
      var currentUserId = Common().getCurrentUserId();
      var documentSnapshot =
          Firestore.instance.collection('Users').document(currentUserId).get();
      currentUser = User.fromSnapshot(documentSnapshot);
      currentUser.uid = currentUserId;
    }

    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Fursa'),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.timelapse)),
                Tab(icon: Icon(Icons.group)),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              new BottomNavigationBarItem(
                  icon: new Icon(Icons.home), title: new Text('Home')),
              new BottomNavigationBarItem(
                  icon: new Icon(Icons.apps), title: new Text('Categories')),
              new BottomNavigationBarItem(
                  icon: new Icon(Icons.notifications),
                  title: new Text('Notifications')),
            ],
          ),
          drawer: new Drawer(
//            child: _buildNavListView(context, currentUser),
            child: MainNavigationDrawer(currentUser),
          ),
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

  void _createPost() {
    if (Common().isLoggedIn()) {
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new CreatePost()));
    } else {
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new Login()));
    }
  }
}
