import 'package:flutter/material.dart';
import 'package:fursa_flutter/models/post.dart';
import 'package:fursa_flutter/pages/view_post.dart';
import 'package:fursa_flutter/values/strings.dart';
import 'package:fursa_flutter/views/post_top_section.dart';

const tag = 'PostListItemView';

class PostListItemView extends StatefulWidget {
  final Post post;
  PostListItemView({this.post});

  @override
  _PostListItemViewState createState() => _PostListItemViewState(post);
}

class _PostListItemViewState extends State<PostListItemView> {
  final Post post;
  _PostListItemViewState(this.post);

  @override
  Widget build(BuildContext context) {
    var _descSection = Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        post.desc,
        maxLines: 3,
      ),
    );

    var _topSection = new PostTopSectionView(post);

    var _imageSection =
        post.imageUrl != null ? Image.network(post.imageUrl) : new Container();

    var _actionsSection = Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          buildAction(Icons.thumb_up, likeText, () {}),
          buildAction(Icons.comment, commentText, () {}),
          buildAction(Icons.bookmark_border, saveText, () {}),
          buildAction(Icons.share, shareText, () {}),
        ],
      ),
    );

    return Container(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _topSection,
              _imageSection,
              _descSection,
              _actionsSection,
            ],
          )),
        ),
        onTap: () => _openPost(context),
      ),
    );
  }

  Padding buildAction(IconData icon, String text, GestureTapCallback onTap) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: Column(
          children: <Widget>[
            Icon(
              icon,
              color: Colors.grey,
            ),
            Text(text)
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  _openPost(BuildContext context) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) {
              return new ViewPostPage(post);
            },
            fullscreenDialog: true));
  }
}
