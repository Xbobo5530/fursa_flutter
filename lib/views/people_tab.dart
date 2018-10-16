import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fursa_flutter/mock_data/users.dart';
import 'package:fursa_flutter/models/user.dart';
import 'package:fursa_flutter/values/strings.dart';
import 'package:fursa_flutter/views/user_list_item.dart';

class PeopleTabView extends StatefulWidget {
  @override
  _PeopleTabViewState createState() => _PeopleTabViewState();
}

class _PeopleTabViewState extends State<PeopleTabView> {
  var _users;

  @override
  void initState() {
    _users = Firestore.instance
        .collection(USERS_COLLECTION)
//              .orderBy(TIMESTAMP_VALUE, descending: true)
        .snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder(
            stream: _users,
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
