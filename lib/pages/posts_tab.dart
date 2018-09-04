import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fursa_flutter/models/post.dart';
import 'package:fursa_flutter/pages/view_post.dart';
import 'package:transparent_image/transparent_image.dart';

class PostsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('Posts').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator()); // show loading
        return new ListView.builder(
          itemCount: snapshot.data.documents.length,
          padding: const EdgeInsets.only(top: 10.0),
          itemExtent: 25.0,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.documents[index];
            var postId = ds.documentID;
            var post = new Post.fromSnapshot(ds);
            post.postId = postId;
            return _postListItem(post, context);
          },
        );
      },
    );
  }

  Widget _postListItem(post, context) {
    var topSection;
    var middleSection = new Container();
    var imageUrl = post.imageUrl;
    if (post.imageUrl != null) {
      middleSection = new Container(
        child: Column(
          children: <Widget>[
            FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: post.imageUrl,
              fadeInDuration: Duration(milliseconds: 200),
            ),
          ],
        ),
      );
    }

    var descSection = new Container();

    //get the post description
    String _getDescription(post) {
      var desc = post.desc;
      var title = post.title;
      if (desc != null && title != null) {
        return '$title\n$desc';
      } else if (title != null && desc == null) {
        return title;
      } else if (desc != null && title == null) {
        return desc;
      } else {
        return '';
      }
    }

    var description = _getDescription(post);
    if (description.isNotEmpty) {
      descSection = new Container(
        padding: new EdgeInsets.only(left: 8.0),
        child: Text(description),
      );
    } else {
      descSection = new Container();
    }

    var bottomSection = new Container();

    return new FlatButton(
      child: Card(
        margin: EdgeInsets.all(8.0),
        child: new Container(
          child: new Flex(
            direction: Axis.vertical,
            children: <Widget>[
              new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
//          topSection,
                  middleSection,
                  descSection,
//        bottomSection
                ],
              ),
            ],
          ),

        ),
      ), onPressed: () {_openPost(post.postId, context);},
    );
  }


}

  void _openPost(postId, context) {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new ViewPost(postId)));
  }