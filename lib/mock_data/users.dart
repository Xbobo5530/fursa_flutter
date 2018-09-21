/*User(this.name, this.imageUrl, this.thumbUrl, this.bio, this.uid, this.credit,
      this.level, this.lastCreditUpdatedAt);*/
import 'package:fursa_flutter/models/user.dart';

User user1 = User(
    'Patrick',
    'https://ih0.redbubble.net/image.29797477.3431/st%2Csmall%2C215x235-pad%2C210x230%2Cf8f8f8.lite-1u3.jpg',
    null,
    'hey guys i am patrick turn up people turn up',
    'user001',
    6,
    2,
    new DateTime(2018));

User user2 = User(
    'Silky johnson',
    'https://pbs.twimg.com/profile_images/424962002226655232/dvEIPPoa_400x400.jpeg',
    null,
    'hate hate hate hate',
    'user002',
    20,
    5,
    new DateTime(2018));

User user3 = User(
    'Ngosha ent',
    'http://3.bp.blogspot.com/_K9HKJBW3Rh8/TDtH6SpIKXI/AAAAAAAAABw/UWIm3yLyO5g/s1600/mzee.jpg',
    null,
    'hate hate hate hate',
    'user003',
    10,
    3,
    new DateTime(2018));
List<User> users = [user1, user2, user3];
