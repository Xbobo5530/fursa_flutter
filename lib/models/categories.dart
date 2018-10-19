class Category {
  String title;
  Category(this.title);

  Category.fromSnapshot(var value) {
    this.title = value['title'];
  }
}
