import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fursa_flutter/functions/functions.dart';
import 'package:fursa_flutter/models/user.dart';
import 'package:fursa_flutter/values/strings.dart';
import 'package:fursa_flutter/views/user_list_item.dart';

class FollowPage extends StatelessWidget {
  final User user;
  final String follow;
  final functions = Functions();
  FollowPage({this.user, this.follow});
  @override
  Widget build(BuildContext context) {
    var userId = user.uid;

    return Scaffold(
      appBar: AppBar(
//        title: Text(follow),
          ),
      body: StreamBuilder(
          stream: functions.database
              .collection(USERS_COLLECTION)
              .document(userId)
              .collection(follow)
              .snapshots(),
          builder: (context, snapshots) {
            if (!snapshots.hasData)
              return Center(child: CircularProgressIndicator());
            return ListView.builder(
                itemCount: snapshots.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = snapshots.data.documents[index];
                  var followId = document.documentID; //following or follower Id
                  User _follow;
                  functions.database
                      .collection(USERS_COLLECTION)
                      .document(followId)
                      .get()
                      .then((document) {
                    _follow = User.fromSnapshot(document);
                  }).catchError((error) => print(error));
                  return UserListItemView(user: _follow);
                });
          }),
    );
  }
}
