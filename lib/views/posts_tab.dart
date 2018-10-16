import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fursa_flutter/models/post.dart';
import 'package:fursa_flutter/models/user.dart';
import 'package:fursa_flutter/values/strings.dart';
import 'package:fursa_flutter/views/post_list_item.dart';

const tag = 'PostsTab: ';

class PostsTabView extends StatefulWidget {
  @override
  _PostsTabViewState createState() => _PostsTabViewState();
}

class _PostsTabViewState extends State<PostsTabView> {
  var _posts;

  @override
  void initState() {
    _posts = Firestore.instance
        .collection(POSTS_COLLECTION)
        .orderBy(TIMESTAMP_VALUE, descending: true)
        .snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder(
            stream: _posts,
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    var snapshotDocuments = snapshot.data.documents;
                    Post post = Post.fromSnapshot(snapshotDocuments[index]);
                    var userId = post.userId;

                    Firestore.instance
                        .collection(USERS_COLLECTION)
                        .document(userId)
                        .get()
                        .then((DocumentSnapshot documentSnapshot) {
                      User user = User.fromSnapshot(documentSnapshot);
                      var username = user.name;
                      var userImageUrl = user.imageUrl;
                      post.username = username;
                      post.userImageUrl = userImageUrl;
                    });

//                    return new PostListItemView(postsList[index]);
                    return PostListItemView(post: post);
                  });
            }));
  }
}
