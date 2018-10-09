import 'package:flutter/material.dart';
import 'package:fursa_flutter/models/user.dart';

class UserPostsPage extends StatelessWidget {
  final User user;
  UserPostsPage({this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.name}\'s posts'),
      ),
    );
  }
}
