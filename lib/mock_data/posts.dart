import 'package:fursa_flutter/models/post.dart';
import 'package:fursa_flutter/values/strings.dart';

/*String postId, desc, userId, imageUrl, thumbUrl, title, price, imageText, imageLabel;
  List<dynamic> location, contactDetails, categories, tags;
  int likes, comments, views, activity, feedViews, postType;
  DateTime timestamp, eventDate, eventEndDate;*/
Post post1 = Post.simple(
    postDesc1,
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQPKo0QQD9RMLHhD40jwZY8TPdXdcJll9JuYbaGg1GpzKhODAC',
    'user002',
    ['Mwanza', 'Tanzania']);

Post post2 = Post.simple(
    postDesc2,
    'https://i.ytimg.com/vi/vHgsyDADjHM/maxresdefault.jpg',
    'user001',
    ['Wacahga Street', 'Posta Meru', 'Arusha', 'Tanzania']);
Post post3 = Post.simple(
    postDesc3,
    'https://media.musiciansfriend.com/is/image/MMGS7/RealFeel-2-Sided-Speed-and-Workout-Drum-Pad-Gray-12-in./445396000184076-00-500x500.jpg',
    'user003',
    ['Sinza', 'Dar es Salaam']);

List<Post> posts = [post1, post2, post3];
