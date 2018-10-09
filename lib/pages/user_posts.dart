import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fursa_flutter/functions/functions.dart';
import 'package:fursa_flutter/models/post.dart';
import 'package:fursa_flutter/models/user.dart';
import 'package:fursa_flutter/values/strings.dart';
import 'package:fursa_flutter/views/post_list_item.dart';

class UserPostsPage extends StatefulWidget {
  final User user;
  UserPostsPage({this.user});
  @override
  _UserPostsPageState createState() => _UserPostsPageState(user: user);
}

class _UserPostsPageState extends State<UserPostsPage> {
  final User user;
  _UserPostsPageState({this.user});
  final functions = Functions();
  Post _post;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.name}\'s posts'),
      ),
      body: StreamBuilder(
          stream: functions.database
              .collection(USERS_COLLECTION)
              .document(user.uid)
              .collection(SUBSCRIPTIONS_COLLECTION)
              .document(MY_POSTS_DOCUMENT)
              .collection(MY_POSTS_COLLECTION)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = snapshot.data.documents[index];
                  var postId = document.documentID;

                  functions.database
                      .collection(POSTS_COLLECTION)
                      .document(postId)
                      .get()
                      .then((postDocument) {
                    setState(() {
                      _post = Post.fromSnapshot(postDocument);
                    });

                    var postUserId = _post.userId;
                    functions.database
                        .collection(USERS_COLLECTION)
                        .document(postUserId)
                        .get()
                        .then((document) {
                      User user = User.fromSnapshot(document);
                      _post.username = user.name;
                      _post.userImageUrl = user.imageUrl;
                    });
                  });
                  print(_post);
                  return PostListItemView(
                    post: _post,
                  );
                });
          }),
    );
  }
}
