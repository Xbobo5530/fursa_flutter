import 'package:flutter/material.dart';
import 'package:fursa_flutter/functions/functions.dart';
import 'package:fursa_flutter/models/user.dart';
import 'package:fursa_flutter/pages/follow_users.dart';
import 'package:fursa_flutter/values/strings.dart';

class FollowCountView extends StatefulWidget {
  final User user;
  final String follow;
  FollowCountView({this.user, this.follow});

  @override
  _FollowingCountViewState createState() =>
      _FollowingCountViewState(user: user, follow: follow);
}

class _FollowingCountViewState extends State<FollowCountView> {
  final User user;
  final String follow;
  _FollowingCountViewState({this.user, this.follow});
  final functions = Functions();
  int _followCount;
  @override
  Widget build(BuildContext context) {
    functions.database
        .collection(USERS_COLLECTION)
        .document(user.uid)
        .collection(follow)
        .getDocuments()
        .then((snapshot) {
      setState(() {
        _followCount = snapshot.documents.length;
      });
    });

    if (_followCount == 0 || _followCount == null) {
      return Container();
    } else {
      return FlatButton(
        child: Column(
          children: <Widget>[
            Text(follow),
            Text(
              '$_followCount',
              style: new TextStyle(
                color: Colors.grey,
                fontSize: 12.0,
              ),
            )
          ],
        ),
        onPressed: () => _openFollowing(context),
      );
    }
  }

  _openFollowing(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => FollowPage(user: user)));
  }
}
