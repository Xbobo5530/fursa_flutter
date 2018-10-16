import 'package:flutter/material.dart';
import 'package:fursa_flutter/functions/functions.dart';
import 'package:fursa_flutter/models/user.dart';
import 'package:fursa_flutter/pages/edit_user_profile.dart';
import 'package:fursa_flutter/values/strings.dart';
import 'package:fursa_flutter/views/profile_follow_count.dart';
import 'package:fursa_flutter/views/profile_posts_count.dart';

class UserProfilePage extends StatefulWidget {
  final User user;
  UserProfilePage(this.user);
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  User _user;
  var _isLoggedIn = false;
  var _currentUserId;
  var functions = Functions();
  @override
  Widget build(BuildContext context) {
    _user = widget.user;

    functions.getUser().then((currentUser) {
      if (currentUser != null) {
        setState(() {
          _isLoggedIn = true;
          _currentUserId = currentUser.uid;
        });
      } else {
        _isLoggedIn = false;
      }
    });

    var imageUrl = widget.user.imageUrl;
    var imageSection = imageUrl != null
        ? Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
            child: Icon(
              Icons.account_circle,
              color: Colors.grey,
              size: 45.0,
            ),
          );

    var userInfoSection = new ListTile(
      title: new Text(_user.name),
      subtitle: _user.bio != null ? new Text(_user.bio) : new Container(),
    );

    var topSection = Row(
      children: <Widget>[
        imageSection,
        Expanded(child: userInfoSection),
      ],
    );

    var middleSection = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text(followText),
                onPressed: () => _followUser()),
          ),
        ],
      ),
    );

    var bottomSection = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          PostsCountView(user: _user),
          FollowCountView(
            user: _user,
            follow: followersText,
          ),
          FollowCountView(
            user: _user,
            follow: followingText,
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Wrap(
            children: <Widget>[
              Column(
                children: <Widget>[
                  topSection,
                  middleSection,
                  bottomSection,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(_user.name),
      actions: <Widget>[
        _isLoggedIn && _currentUserId == _user.uid
            ? IconButton(
                onPressed: () => _confirmEditDialog(context),
                icon: Icon(Icons.edit),
              )
            : Container(),
        IconButton(
          icon: Icon(Icons.share),
          onPressed: () => _shareProfile(),
        )
      ],
    );
  }

  _shareProfile() {
    //todo handle share profile
  }

  _confirmEditDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: new Text(confirmEditProfileText),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(cancelText)),
              FlatButton(
                  onPressed: () => _openEditProfilePage(context),
                  child: new Text(yesText))
            ],
          );
        });
  }

  _openEditProfilePage(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) {
              return new EditUserProfilePage(_user);
            },
            fullscreenDialog: true));
  }

  _followUser() {
    //todo handle follow user
  }

  _openPosts() {}

  _openFollowers() {}

  _openFollowing() {}
}
