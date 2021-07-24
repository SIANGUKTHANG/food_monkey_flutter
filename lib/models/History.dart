class History {
  bool? status;
  String? id, user, created;
  int? count, total;
  List<Item>? items;
  History(
      {this.status,
      this.id,
      this.user,
      this.created,
      this.count,
      this.total,
      this.items});

  factory History.fromJson(dynamic data) {
    List ls = data["items"] as List;
    List<Item> items = ls.map((e) => Item.fromJson(e)).toList();
    return History(
        status: data["status"],
        id: data["_id"],
        user: data["user"],
        created: data["created"],
        count: data["count"],
        total: data["total"],
        items: items);
  }
}

class Item {
  List<dynamic>? images;
  bool? status;
  String? id, productId, order, name, created;
  int? count, price, discount;

  Item(
      {this.images,
      this.status,
      this.id,
      this.productId,
      this.order,
      this.name,
      this.count,
      this.price,
      this.created});

  factory Item.fromJson(dynamic data) {
    List<dynamic> imgs = data["images"] as List;
    return Item(
      images: imgs,
      status: data["status"],
      id: data["_id"],
      productId: data["productId"],
      order: data["order"],
      count: data["count"],
      price: data["price"],
      name: data["name"],
      created: data["created"],
    );
  }
}
