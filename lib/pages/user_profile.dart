import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fursa_flutter/common.dart';
import 'package:fursa_flutter/models/user.dart';

class UserProfile extends StatelessWidget {
  final User user;
  UserProfile(this.user);

  @override
  Widget build(BuildContext context) {
    var title;
    var username = user.name;
    var bio = user.bio;
    var currentUserId = Common().getCurrentUserId();

    var actionButton;
    var userInfo;
    if (currentUserId != null && currentUserId == user.uid) {
      title = 'My profile';
      if (bio != null) {
        userInfo = new ListTile(
          title: new Text(username),
          subtitle: new Text(username),
        );
      } else {
        userInfo = new ListTile(
            title: new Text(
          username,
        ));
      }

      var credit = user.credit;
      if (credit != null) {
        credit = user.credit;
      } else {
        credit = 0;
      }
      actionButton = new RaisedButton(
          child: new Text(
            'Balance: $credit credit(s)',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
          onPressed: () {
            //todo this launch the buy more credit page
          });
    } else {
      title = '${user.name}\'s profile';
      actionButton = new RaisedButton(onPressed: () {
        _follow();
      });
    }

    //check if user has image
    var imageUrl = user.imageUrl;
    var userImage;
    if (imageUrl != null) {
      userImage = new CircleAvatar(
        backgroundImage: new NetworkImage(imageUrl),
        backgroundColor: Colors.lightBlue,
        radius: 50.0,
      );
    } else {
      userImage = new CircleAvatar(
        backgroundColor: Colors.lightBlue,
        radius: 50.0,
      );
    }

    var topSection = new Container(
      child: Row(
        children: <Widget>[
          userImage,
          userInfo,
        ],
      ),
    );

    var bottomSection = new Container(
      child: new Column(
        children: <Widget>[
          actionButton,
          //todo add the user posts button, following and followers
          // check if user has followers amd/or is following
        ],
      ),
    );

    return new Scaffold(
      appBar: new AppBar(title: new Text(title)),
      body: new Center(
          child: new Card(
        child: new Container(
          child: new Column(
            children: <Widget>[
              topSection,
              bottomSection,
            ],
          ),
        ),
      )),
    );
  }

  void _follow() {
    //todo handle follow
    //todo move follow to common
  }

//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text(pageName),),
//      body: new Center(
//        child: new Text(pageName),
//      ),
//    );
//  }
}
