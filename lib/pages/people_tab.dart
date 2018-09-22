import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fursa_flutter/mock_data/users.dart';
import 'package:fursa_flutter/models/user.dart';
import 'package:fursa_flutter/values/strings.dart';
import 'package:fursa_flutter/views/people_list_item.dart';

class PeopleTab extends StatelessWidget {
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
                    var snapshotDocuments = snapshot.data.documents;
                    List<User> usersList = new List<User>();

                    for (DocumentSnapshot document in snapshotDocuments) {
                      User user = User.fromSnapshot(document);
                      var userId = document.documentID;

                      user.uid = userId;
                      usersList.add(user);
                    }
                    return new PeopleListItemView(usersList[index]);
                  });
            }));
  }
}
