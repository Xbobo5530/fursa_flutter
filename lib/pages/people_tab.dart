import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csslib/parser.dart';
import 'package:flutter/material.dart';
import 'package:fursa_flutter/models/user.dart';

class PeopleTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance.collection('Users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          return new ListView.builder(
              itemCount: snapshot.data.documents.length,
              padding: const EdgeInsets.only(top: 10.0),
              itemExtent: 25.0,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.documents[index];
                var user = new User.fromSnapshot(ds);
//                return new Text('${user.name}');
//                var imageUrl = user.imageUrl;
//                return new UserCardItem(imageUrl);
                return _userCardItem(user);
              });
        });
  }

//  Card _buildUserCard(String username, String bio, String imageUrl) {
//    if (imageUrl != null) {
//      return Card(
//          child: Row(
//        crossAxisAlignment: CrossAxisAlignment.stretch,
//        children: <Widget>[
//          CircleAvatar(
//            child: Image.network(imageUrl),
//          ),
//          Column(
//            children: <Widget>[
//              Text("$username"),
//              Text("$bio"),
//            ],
//          ),
//        ],
//      ));
//    } else {
//      return Card(
//          child: Row(
//        crossAxisAlignment: CrossAxisAlignment.stretch,
//        children: <Widget>[
//          CircleAvatar(
//            backgroundColor: Colors.lightBlue,
//          ),
//          Column(
//            children: <Widget>[
//              Text("$username"),
//              Text("$bio"),
//            ],
//          ),
//        ],
//      ));
//    }
//  }

  Widget _userCardItem(User user) {
    var leftSection;
    var imageUrl;
    if (user.thumbUrl != null){
      imageUrl = user.thumbUrl;
      leftSection = new Container(
        child: new CircleAvatar(
          backgroundImage: new NetworkImage(imageUrl),
          backgroundColor: Colors.lightBlue,
          radius: 24.0,
        ),
      );
    }else if (user.imageUrl != null){
      imageUrl = user.imageUrl;
      leftSection = new Container(
        child: new CircleAvatar(
          backgroundImage: new NetworkImage(imageUrl),
          backgroundColor: Colors.lightBlue,
        ),
      );
    }else{
      leftSection = new Container(
        child: new CircleAvatar(
          backgroundColor: Colors.lightBlue,
          radius: 24.0,
        ),
      );
    }

//    var bio
    //todo continue here bio might be null

    var middleSection;
    var bio = user.bio;

    if (bio != null && bio.isNotEmpty) {
      //has bio

      middleSection = new Expanded(
        child: new ListTile(
          title: new Text(user.name),
          subtitle: new Text(user.bio),
        ),
      );


//      middleSection = new Expanded(
//        child: new Container(
//          padding: new EdgeInsets.only(left: 8.0),
//          child: new Column(
//            mainAxisSize: MainAxisSize.min,
//            crossAxisAlignment: CrossAxisAlignment.start,
//            mainAxisAlignment: MainAxisAlignment.spaceAround,
//            children: <Widget>[
//              new Text(
//                user.name,
//                style: new TextStyle(
//                  color: Colors.black,
//                  fontWeight: FontWeight.w600,
//                  fontSize: 16.0,
//                ),
//              ),
//              new Text(
//                user.bio,
//                style: new TextStyle(color: Colors.grey),
//              ),
//            ],
//          ),
//        ),
//      );
    } else {
      //no bio

      middleSection = new Expanded(
        child: new ListTile(
          title: new Text(user.name),
        ),
      );


      middleSection = new Expanded(
        child: new Container(
          padding: new EdgeInsets.only(left: 8.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new Text(
                user.name,
                style: new TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.wt600,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      );
    }

//    final middleSection = new Container(
//      child: new Column(
//        children: <Widget>[
//          new Text(user.name, textAlign: TextAlign.left,),
////          new Text(user.bio),
//        ],
//      ),
//    );

//    final rightSection = new Container(
//      child: new Column(
//        children: <Widget>[
//          new FlatButton(onPressed: () {_follow();}, child: const Text('Follow'))
//        ],
//      ),
//    );
    //todo check if current user is already following, then hide follow button
//    return new Scaffold(
//      body: new Container(
//          child: new Row(
//            children: <Widget>[middleSection],
//          ),
//        ),
//    );

    return new Scaffold(
      body: new Container(
        child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              leftSection,
              middleSection,
//          rightSection
            ],
        ),
      ),
    );
  }

  void _follow() {
    //todo follow user
  }
}
