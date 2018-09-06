import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csslib/parser.dart';
import 'package:flutter/material.dart';
import 'package:fursa_flutter/models/user.dart';
import 'package:fursa_flutter/pages/user_profile.dart';

class PeopleTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance.collection('Users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          return new ListView.builder(
              itemCount: snapshot.data.documents.length,
              padding: const EdgeInsets.only(top: 10.0),
              itemExtent: 25.0,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.documents[index];
                var user = new User.fromSnapshot(ds);
//                return new Text('${user.name}');
//                var imageUrl = user.imageUrl;
//                return new UserCardItem(imageUrl);
                return _userCardItem(context, user);
              });
        });
  }

  Widget _userCardItem(BuildContext context, User user) {
    var leftSection;
    var imageUrl;
    if (user.thumbUrl != null) {
      imageUrl = user.thumbUrl;
      leftSection = new Container(
        child: new CircleAvatar(
          backgroundImage: new NetworkImage(imageUrl),
          backgroundColor: Colors.lightBlue,
          radius: 24.0,
        ),
      );
    } else if (user.imageUrl != null) {
      imageUrl = user.imageUrl;
      leftSection = new Container(
        child: new CircleAvatar(
          backgroundImage: new NetworkImage(imageUrl),
          backgroundColor: Colors.lightBlue,
        ),
      );
    } else {
      leftSection = new Container(
        child: new CircleAvatar(
          backgroundColor: Colors.lightBlue,
          radius: 24.0,
        ),
      );
    }

//    var bio
    //todo continue here bio might be null

    var middleSection;
    var bio = user.bio;

    if (bio != null && bio.isNotEmpty) {
      //has bio

      middleSection = new Expanded(
        child: new ListTile(
          title: new Text(user.name),
          subtitle: new Text(user.bio),
        ),
      );
    } else {
      //no bio
      middleSection = new Expanded(
        child: new ListTile(
          title: new Text(user.name),
        ),
      );
    }

//    final rightSection = new Container(
//      child: new Column(
//        children: <Widget>[
//          new FlatButton(onPressed: () {_follow();}, child: const Text('Follow'))
//        ],
//      ),
//    );
    //todo check if current user is already following, then hide follow button
//    return new Scaffold(
//      body: new Container(
//          child: new Row(
//            children: <Widget>[middleSection],
//          ),
//        ),
//    );

    return new FlatButton(
      child: new Scaffold(
        body: new Container(
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              leftSection,
              middleSection,
//          rightSection
            ],
          ),
        ),
      ),
      onPressed: () {
        _goToUserPage(context, user);
      },
    );
  }

  void _follow() {
    //todo follow user
  }
}

void _goToUserPage(context, user) {
  Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) => new UserProfile(user)));
}
