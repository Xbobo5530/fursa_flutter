
class Post {
  String postId, desc, userId, imageUrl, thumbUrl, title, price, imageText, imageLabel;
  List<dynamic> location, contactDetails, categories, tags;
  int likes, comments, views, activity, feedViews, postType;
  DateTime timestamp, eventDate, eventEndDate;

  Post(this.postId, this.desc, this.userId, this.imageUrl, this.thumbUrl, this.title,
      this.price, this.imageText, this.imageLabel, this.location, this.contactDetails,
      this.categories, this.tags, this.likes, this.comments, this.views, this.activity,
      this.feedViews, this.postType, this.timestamp, this.eventDate, this.eventEndDate);

  Post.fromSnapshot(var value){
    this.desc = value['desc'];
    this.userId = value['user_id'];
    this.imageUrl = value['image_url'];
    this.thumbUrl = value['thumb_url'];
    this.title = value['title'];
    this.price = value['price'];
    this.imageText = value['image_text'];
    this.imageLabel = value['image_label'];
    this.location = value['loacation'];
    this.contactDetails = value['contact_details'];
    this.categories = value['categories'];
    this.tags = value['tags'];
    this.likes = value['likes'];
    this.comments = value['comments'];
    this.views = value['views'];
    this.activity = value['activity'];
    this.feedViews = value['feed_views'];
    this.postType = value['post_type'];
  }
}