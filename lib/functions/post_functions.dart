import 'package:flutter/material.dart';
import 'package:fursa_flutter/functions/account_functions.dart';
import 'package:fursa_flutter/pages/create_post.dart';
import 'package:fursa_flutter/pages/login.dart';
import 'package:fursa_flutter/values/strings.dart';

class PostFunctions {
  createPost(BuildContext context) {
    final account = new AccountFunctions();
    if (account.isLoggedIn()) {
      Navigator.push(context,
          new MaterialPageRoute(builder: ((context) => new CreatePostPage())));
    } else {
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new LoginPage(loginToPostText)));
    }
  }
}
