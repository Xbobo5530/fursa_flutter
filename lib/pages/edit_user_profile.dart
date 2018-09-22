import 'package:flutter/material.dart';
import 'package:fursa_flutter/models/user.dart';
import 'package:fursa_flutter/values/strings.dart';

class EditUserProfilePage extends StatelessWidget {
  final User user;
  EditUserProfilePage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(editProfileText),
      ),
    );
  }
}
