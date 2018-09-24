import 'package:flutter/material.dart';
import 'package:fursa_flutter/functions/account_functions.dart';
import 'package:fursa_flutter/pages/login.dart';
import 'package:fursa_flutter/values/strings.dart';

class MainDrawerView extends StatelessWidget {
  final bool _isLoggedIn;
  MainDrawerView(this._isLoggedIn);
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
          onTap: () {},
        ),
      ],
    );
    return Drawer(
      child: Column(
        children: <Widget>[
          new UserAccountsDrawerHeader(
              accountName: Text(APP_NAME), accountEmail: Text('email text')),
          loggedInActions,
          _buildLoginListTile(context),
          new Divider(),
          appActions, //loginSection,
        ],
      ),
    );
  }

  ListTile _buildLoginListTile(BuildContext context) {
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
      return new LoginPage();
    }));
  }
}
