import 'package:flutter/material.dart';
import 'package:fursa_flutter/functions/account_functions.dart';
import 'package:fursa_flutter/pages/categories.dart';
import 'package:fursa_flutter/pages/home.dart';
import 'package:fursa_flutter/pages/login.dart';
import 'package:fursa_flutter/pages/notifications.dart';
import 'package:fursa_flutter/values/strings.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:launch_review/launch_review.dart';

class MainDrawerView extends StatelessWidget {
//  final bool _isLoggedIn;
//  MainDrawerView(this._isLoggedIn);
  final account = new AccountFunctions();

  @override
  Widget build(BuildContext context) {
    var loggedInActions = Column(
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
    );

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
          new UserAccountsDrawerHeader(
              accountName: Text(APP_NAME), accountEmail: Text('email text')),
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
    var _isLoggedIn = account.isLoggedIn();

    return _isLoggedIn
        ? new ListTile(
            leading: new Icon(Icons.exit_to_app),
            title: Text(logoutText),
            onTap: () => account.logout(),
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
}
