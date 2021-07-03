class Category {
  String? id, name, image;
  List<dynamic>? subs;

  Category({this.id, this.name, this.image, this.subs});

  factory Category.fromJson(dynamic data) {
    List<dynamic> subs = data["subs"] as List;
    return Category(
        id: data["_id"], name: data["name"], image: data["image"], subs: subs);
  }
}
