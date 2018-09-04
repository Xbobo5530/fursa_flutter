import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String bio;
  String imageUrl;
  String thumbUrl;
  User(this.name, this.imageUrl, this.thumbUrl, this.bio);

  User.fromJson(var value){
    this.name=value['name'];
    this.bio=value['bio'];
    this.imageUrl=value['image'];
    this.thumbUrl=value['thumb'];

  }

  User.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot.data['name'],
        bio = snapshot.data['bio'],
        imageUrl = snapshot.data['image'],
        thumbUrl = snapshot.data['thumb'];
}