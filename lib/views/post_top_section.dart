import 'package:flutter/material.dart';
import 'package:fursa_flutter/models/post.dart';
import 'package:fursa_flutter/values/strings.dart';

class PostTopSectionView extends StatefulWidget {
  final Post post;
  PostTopSectionView(this.post);
  @override
  _PostTopSectionViewState createState() => _PostTopSectionViewState(post);
}

class _PostTopSectionViewState extends State<PostTopSectionView> {
  final Post post;
  _PostTopSectionViewState(this.post);
  @override
  Widget build(BuildContext context) {
    var _imageSection = Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
      child: CircleAvatar(
        backgroundImage: NetworkImage(post.userImageUrl),
      ),
    );

    var locationString = '';
    var postLocation = post.location;
    postLocation.forEach((item) => locationString += '\n' + item);
    var _middleSection = new ListTile(
      title: Text(post.username),
      subtitle: Text(locationString.trim()),
    );

    var _followSection = FlatButton(
      child: new Text(
        followText,
        style: new TextStyle(color: Colors.blue, fontStyle: FontStyle.italic),
      ),
      onPressed: _followPostUser,
    );

    return Row(
      children: <Widget>[
        _imageSection,
        Expanded(child: _middleSection),
        _followSection,
      ],
    );
  }

  void _followPostUser() {
    //todo hanlde follow post user
  }
}
