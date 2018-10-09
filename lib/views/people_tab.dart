import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fursa_flutter/mock_data/users.dart';
import 'package:fursa_flutter/models/user.dart';
import 'package:fursa_flutter/values/strings.dart';
import 'package:fursa_flutter/views/user_list_item.dart';

class PeopleTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder(
            stream: Firestore.instance
                .collection(USERS_COLLECTION)
//              .orderBy(TIMESTAMP_VALUE, descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(child: new CircularProgressIndicator());
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = snapshot.data.documents[index];
                    User user = User.fromSnapshot(document);
                    var userId = document.documentID;
                    user.uid = userId;
                    return new UserListItemView(user: user);
                  });
            }));
  }
}
