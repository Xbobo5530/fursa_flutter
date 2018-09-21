import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

const tag = 'PostsTab: ';

class PostsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
              stream: Firestore.instance.collection('Posts').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(child: new CircularProgressIndicator());
                return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      var document = snapshot.data.documents[index];

                      return Text('${document['desc']}');
                    });
              })

          /*ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            var post = posts[index];
            var userId = post.userId;

            for (var index = 0; index < users.length; index++) {
              var user = users[index];
              if (user.uid == userId) {
                post.username = user.name;
                post.userImageUrl = user.imageUrl;
                break;
              }
            }
            return new PostListItemView(post);
          })*/
          ,
    );
  }
}
