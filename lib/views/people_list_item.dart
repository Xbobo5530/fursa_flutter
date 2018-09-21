import 'package:flutter/material.dart';
import 'package:fursa_flutter/models/user.dart';
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
      child: new CircleAvatar(
        backgroundImage: NetworkImage(user.imageUrl),
      ),
    );
    var _infoSection = new ListTile(
      title: Text(user.name),
      subtitle: Text(user.bio),
    );

    var _followSection = FlatButton(
        onPressed: _followUser,
        child: new Text(
          followText,
          style: new TextStyle(color: Colors.blue, fontStyle: FontStyle.italic),
        ));
    return Card(
      child: Row(
        children: <Widget>[
          _imageSection,
          Expanded(child: _infoSection),
          _followSection
        ],
      ),
    );
  }

  void _followUser() {
    //todo handle follow user
  }
}
