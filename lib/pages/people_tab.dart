import 'package:flutter/material.dart';
import 'package:fursa_flutter/mock_data/users.dart';
import 'package:fursa_flutter/views/people_list_item.dart';

class PeopleTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            var user = users[index];
            return new PeopleListItemView(user);
          }),
    );
  }
}
