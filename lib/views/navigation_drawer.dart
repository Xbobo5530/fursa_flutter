import 'package:flutter/material.dart';
import 'package:fursa_flutter/common.dart';
import 'package:fursa_flutter/models/user.dart';
import 'package:fursa_flutter/pages/login.dart';
import 'package:fursa_flutter/pages/user_profile.dart';
import 'package:fursa_flutter/pages/user_posts.dart';
import 'package:url_launcher/url_launcher.dart';

class MainNavigationDrawer extends StatelessWidget {
  final user;
  MainNavigationDrawer(this.user);

  @override
  Widget build(BuildContext context) {
    var userAccountDrawerHeader;
    var userAccountDrawerListItems;

    if (Common().isLoggedIn()) {
      var userCredit = user.credit;
      if (userCredit > 0) {
        userAccountDrawerHeader = new UserAccountsDrawerHeader(
            accountName: Text(user.name),
            accountEmail: Text('Balance: $userCredit(s)'),
            decoration: new BoxDecoration(color: Colors.redAccent
                // image: new DecorationImage(
                //   fit: BoxFit.fill,
                //   image: NetworkImage(url)
                // )
                ));
      } else {
        userAccountDrawerHeader = new UserAccountsDrawerHeader(
            accountName: Text(user.name),
            accountEmail: null,
            decoration: new BoxDecoration(color: Colors.redAccent
                // image: new DecorationImage(
                //   fit: BoxFit.fill,
                //   image: NetworkImage(url)
                // )
                ));
      }

      userAccountDrawerListItems = new ListView(
        children: <Widget>[
          new ListTile(
            title: new Text('My profile'),
            leading: new Icon(Icons.account_circle),
            onTap: () {
              _goToMyProfile(context, user);
            },
          ),
          new ListTile(
            title: new Text('My posts'),
            leading: new Icon(Icons.library_books),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserPosts(user)),
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
            onTap: () {
              Common().logout();
            },
          ),
        ],
      );
    } else {
      userAccountDrawerHeader = new UserAccountsDrawerHeader(
        accountName: null,
        accountEmail: null,
        decoration: new BoxDecoration(color: Colors.redAccent
            //todo add the app icon shadow image
//             image: new DecorationImage(
//               fit: BoxFit.fill,
//               image: NetworkImage(url)
//             )
            ),
      );

      userAccountDrawerListItems = new ListView(
        children: <Widget>[
          new ListTile(
            title: new Text('Login'),
            leading: new Icon(Icons.exit_to_app),
            onTap: () {
              _goToLogin(context);
            },
          ),
        ],
      );
    }

    var commonDrawerListItems = new ListView(
      children: <Widget>[
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
          onTap: () {
            _showAppInfo(context);
          },
        )
      ],
    );

    return new ListView(
      children: <Widget>[
        userAccountDrawerHeader,
        userAccountDrawerListItems,
        commonDrawerListItems,
      ],
    );
  }

  void _goToMyProfile(BuildContext context, User user) {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new UserProfile(user)));
  }

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
      print('launching $url');
    } else {
      throw 'Could not launch $url';
    }
  }

  void _showAppInfo(BuildContext context) {
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

  void _goToLogin(BuildContext context) {
    Navigator.of(context).push(
        new MaterialPageRoute(builder: (BuildContext context) => new Login()));
  }
}
