import 'package:flutter/material.dart';
import './user_account.dart';
import 'package:url_launcher/url_launcher.dart';
import './create_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
            child: buildNavListView(context),
          ),
          floatingActionButton: new FloatingActionButton(
              backgroundColor: Colors.red,
              child: new Icon(Icons.add),
              onPressed: _createPost),
          body: TabBarView(
            children: [
              _buildPostsStreamBuilder(),
              _buildPeopleStreamBuilder(),
            ],
          ),
        ),
      ),
    );
  }

  StreamBuilder<QuerySnapshot> _buildPeopleStreamBuilder() {
    return StreamBuilder(
      stream: Firestore.instance.collection('Users').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Text('Loading...');
        return new ListView.builder(
          itemCount: snapshot.data.documents.length,
          padding: const EdgeInsets.only(top: 10.0),
          itemExtent: 25.0,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.documents[index];
            return new Text("${ds['name']}");
          },
        );
      },
    );
  }

  StreamBuilder<QuerySnapshot> _buildPostsStreamBuilder() {
    return StreamBuilder(
      stream: Firestore.instance.collection('Posts').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Text('Loading...');
        return new ListView.builder(
          itemCount: snapshot.data.documents.length,
          padding: const EdgeInsets.only(top: 10.0),
          itemExtent: 25.0,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.documents[index];
            return new Text("${ds['desc']}");
          },
        );
      },
    );
  }

  ListView buildNavListView(BuildContext context) {
    return new ListView(
      children: <Widget>[
        new UserAccountsDrawerHeader(
            accountName: Text('Username'),
            accountEmail: Text('user@email.com'),
            decoration: new BoxDecoration(color: Colors.redAccent
                // image: new DecorationImage(
                //   fit: BoxFit.fill,
                //   image: NetworkImage(url)
                // )
                )),
        new ListTile(
          title: new Text('My profile'),
          leading: new Icon(Icons.account_circle),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserPage('My profile')),
            );
          },
        ),
        new ListTile(
          title: new Text('My posts'),
          leading: new Icon(Icons.library_books),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserPage('My posts')),
            );
          },
        ),
        new ListTile(
          title: new Text('My saved posts'),
          leading: new Icon(Icons.bookmark),
          onTap: () {},
        ),
        new ListTile(
          title: new Text('My subscriptions'),
          leading: new Icon(Icons.cached),
          onTap: () {},
        ),
        new ListTile(
          title: new Text('Logout'),
          leading: new Icon(Icons.exit_to_app),
          onTap: () {},
        ),
        new Divider(),
        new ListTile(
          title: new Text('Share'),
          leading: new Icon(Icons.share),
          onTap: () {},
        ),
        new ListTile(
          title: new Text('Contact us'),
          leading: new Icon(Icons.contacts),
          onTap: () {
            const email = 'mailto:family@nyayozangu.com?';
            _launchUrl(email);
          },
        ),
        new ListTile(
          title: new Text('View terms'),
          leading: new Icon(Icons.feedback),
          onTap: () {
            const url = 'http://fursa.nyayozangu.com/privacy_policy/';
            _launchUrl(url);
          },
        ),
        new ListTile(
          title: new Text('About'),
          leading: new Icon(Icons.info),
          onTap: _showAppInfo,
        ),
      ],
    );
  }

  ListTile buildNavListTile(
      BuildContext context, String title, IconData icon, onTap()) {
    return new ListTile(
      title: new Text(title),
      leading: Icon(icon),
      onTap: () {
        Navigator.of(context).pop();
        onTap();

        // Navigator.of(context).push(
        //   new MaterialPageRoute(
        //     builder: (BuildContext context) => new UserPage('User page')
        //   )
        // );
      },
    );
  }

  createPost() {}

  openMyAccount() {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new UserPage('User page')));
  }

  void _createPost() {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new CreatePost()));
  }

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
      print('launching $url');
    } else {
      throw 'Could not launch $url';
    }
  }

  void _showAppInfo() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text('Fursa v0.0.1'),
            content: new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  new Text('Fursa, now in Flutter'),
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
