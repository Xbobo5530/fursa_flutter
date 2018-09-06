import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name, bio, imageUrl, thumbUrl, uid;
  int credit, level;
  DateTime lastCreditUpdatedAt;
  User(this.name, this.imageUrl, this.thumbUrl, this.bio, this.uid, this.credit, this.level, this.lastCreditUpdatedAt);

  User.fromSnapshot(var value){
    this.name=value['name'];
    this.bio=value['bio'];
    this.imageUrl=value['image'];
    this.thumbUrl=value['thumb'];
    this.credit=value['credit'];
    this.level=value['level'];
    this.lastCreditUpdatedAt=value['last_daily_credit_update_at'];
  }
}

