import 'package:flutter/material.dart';
import 'package:fursa_flutter/models/post.dart';
import 'package:fursa_flutter/values/strings.dart';

class ViewPostPage extends StatelessWidget {
  final Post post;
  ViewPostPage(this.post);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(APP_NAME),
      ),
      body: new Container(
        child: new Text(post.desc),
      ),
    );
  }
}
