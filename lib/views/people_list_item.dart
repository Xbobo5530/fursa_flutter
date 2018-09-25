import 'package:flutter/material.dart';
import 'package:fursa_flutter/functions/functions.dart';
import 'package:fursa_flutter/models/user.dart';
import 'package:fursa_flutter/pages/user_profile.dart';
import 'package:fursa_flutter/values/strings.dart';

class PeopleListItemView extends StatefulWidget {
  final User user;
  PeopleListItemView(this.user);

  @override
  _PeopleListItemViewState createState() => _PeopleListItemViewState(user);
}

class _PeopleListItemViewState extends State<PeopleListItemView> {
  _PeopleListItemViewState(this.user);
  final User user;

  @override
  Widget build(BuildContext context) {
    var _imageSection = Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
      child: user.imageUrl != null
          ? new CircleAvatar(
              backgroundImage: NetworkImage(user.imageUrl),
            )
          : Icon(
              Icons.account_circle,
              size: 45.0,
              color: Colors.grey,
            ),
    );
    var _infoSection = new ListTile(
      title: Text(user.name),
      subtitle: user.bio != null ? Text(user.bio) : new Container(),
    );

    var _followSection = FlatButton(
        onPressed: _followUser,
        child: new Text(
          followText,
          style: new TextStyle(color: Colors.blue, fontStyle: FontStyle.italic),
        ));
    return Card(
      child: InkWell(
          child: Row(
            children: <Widget>[
              _imageSection,
              Expanded(child: _infoSection),
              _followSection
            ],
          ),
          onTap: () => new Functions().openUserProfile(context, user)),
    );
  }

  void _followUser() {
    //todo handle follow user
  }
}
