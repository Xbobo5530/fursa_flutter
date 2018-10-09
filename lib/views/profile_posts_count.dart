import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fursa_flutter/functions/functions.dart';
import 'package:fursa_flutter/models/user.dart';
import 'package:fursa_flutter/pages/user_posts.dart';
import 'package:fursa_flutter/values/strings.dart';

const tag = 'PostsCountView';

class PostsCountView extends StatefulWidget {
  final User user;
  PostsCountView({this.user});
  @override
  _PostsCountViewState createState() => _PostsCountViewState(user: user);
}

class _PostsCountViewState extends State<PostsCountView> {
  final User user;
  final functions = Functions();
  _PostsCountViewState({this.user});

  int _postsCount;
  @override
  Widget build(BuildContext context) {
    functions.database
        .collection(USERS_COLLECTION)
        .document(user.uid)
        .collection(SUBSCRIPTIONS_COLLECTION)
        .document(MY_POSTS_DOCUMENT)
        .collection(MY_POSTS_COLLECTION)
        .getDocuments()
        .then((snapshot) {
      setState(() {
        _postsCount = snapshot.documents.length;
        print('$tag posts count is $_postsCount');
      });
    });

    if (_postsCount == 0 || _postsCount == null) {
      return Container();
    } else {
      return FlatButton(
        child: Column(
          children: <Widget>[
            Text(postsText),
            Text(
              '$_postsCount',
              style: new TextStyle(
                color: Colors.grey,
                fontSize: 12.0,
              ),
            )
          ],
        ),
        onPressed: () => _openPosts(context),
      );
    }
  }

  _openPosts(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => UserPostsPage(user: user)));
  }
}
