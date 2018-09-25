import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fursa_flutter/functions/functions.dart';
import 'package:fursa_flutter/models/user.dart';
import 'package:fursa_flutter/pages/categories.dart';
import 'package:fursa_flutter/pages/home.dart';
import 'package:fursa_flutter/pages/login.dart';
import 'package:fursa_flutter/pages/notifications.dart';
import 'package:fursa_flutter/values/strings.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:launch_review/launch_review.dart';

class MainDrawerView extends StatefulWidget {
  @override
  _MainDrawerViewState createState() => _MainDrawerViewState();
}

class _MainDrawerViewState extends State<MainDrawerView> {
  final functions = new Functions();

  var _isLoggedIn = false;
  User _user;

  @override
  Widget build(BuildContext context) {
    functions.getUser().then((user) {
      user != null
          ? setState(() {
              _isLoggedIn = true;
              _getUserDetails(user);
            })
          : _isLoggedIn = false;
    });

    var headerSection = new UserAccountsDrawerHeader(
        accountName: ListTile(
            leading: _user != null && _user.imageUrl != null
                ? new CircleAvatar(
                    backgroundImage: NetworkImage(_user.imageUrl),
                  )
                : Icon(
                    Icons.account_circle,
                    color: Colors.grey,
                    size: 45.0,
                  ),
            title: _user != null && _user.name != null
                ? Text(
                    _user.name,
                    style: new TextStyle(
                      color: Colors.white,
                    ),
                  )
                : Text(APP_NAME)),
        accountEmail: _isLoggedIn
            ? _user != null && _user.credit != null && _user.credit != 0
                ? Text('Balance: ${_user.credit}(s)')
                : new Container()
            : new Container());

    var loggedInActions = _isLoggedIn
        ? Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.account_circle),
                title: new Text(myProfileText),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.library_books),
                title: new Text(myPostsText),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.bookmark),
                title: new Text(mySavedPostsText),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.sync),
                title: new Text(mySubsText),
                onTap: () {},
              ),
            ],
          )
        : new Container();

    var navSection = Column(
      children: <Widget>[
        new ListTile(
          leading: Icon(Icons.home),
          title: new Text(homeText),
          onTap: () => _openHomePage(context),
        ),
        new ListTile(
          leading: Icon(Icons.apps),
          title: new Text(categoriesText),
          onTap: () => _openCategoriesPage(context),
        ),
        new ListTile(
          leading: Icon(Icons.notifications),
          title: new Text(notificationsText),
          onTap: () => _openNotificationsPage(context),
        ),
      ],
    );

    var appActions = new Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.share),
          title: new Text(shareText),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.contacts),
          title: new Text(contactUsText),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.feedback),
          title: new Text(viewTermsText),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.info_outline),
          title: new Text(aboutText),
          onTap: () => _openAboutDialog(context),
        ),
      ],
    );
    return Drawer(
      child: Column(
        children: <Widget>[
          headerSection,
          Expanded(
            child: ListView(
              children: <Widget>[
                navSection,
                new Divider(),
                loggedInActions,
                _buildLoginListTile(context),
                new Divider(),
                appActions,
              ],
            ),
          )
          //loginSection,
        ],
      ),
    );
  }

  ListTile _buildLoginListTile(BuildContext context) {
    return _isLoggedIn
        ? new ListTile(
            leading: new Icon(Icons.exit_to_app),
            title: Text(logoutText),
            onTap: () {
              Navigator.pop(context);
              functions.logout();
            },
          )
        : new ListTile(
            leading: new Icon(Icons.account_circle),
            title: Text(loginText),
            onTap: () => _login(context),
          );
  }

  _login(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(context, new MaterialPageRoute(builder: (context) {
      return new LoginPage(loginText);
    }));
  }

//  _getPackageInfo() {
//    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
//      String appName = packageInfo.appName;
//      String packageName = packageInfo.packageName;
//      String version = packageInfo.version;
//      String buildNumber = packageInfo.buildNumber;
//    });
//  }

  _openAboutDialog(BuildContext context) async {
    Navigator.pop(context);
    await showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            title: new Text(aboutText),
            content: new Text(
                'In this version we have added more functionality and stability'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => LaunchReview.launch(),
                child: new Text(rateAppText),
              )
            ],
          );
        });
  }

  void _openHomePage(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => new HomePage()));
  }

  _openCategoriesPage(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new CategoriesPage()));
  }

  _openNotificationsPage(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new NotificationsPage()));
  }

  void _getUserDetails(FirebaseUser user) {
    var userId = user.uid;
    functions.database
        .collection(USERS_COLLECTION)
        .document(userId)
        .get()
        .then((document) {
      _user = User.fromSnapshot(document);
    });
  }
}

//class MainDrawerView extends StatelessWidget {
////  final bool _isLoggedIn;
////  MainDrawerView(this._isLoggedIn);
//
//}
