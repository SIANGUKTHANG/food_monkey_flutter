class ImgResult {
  String? id, name, originalname, mimetype, link;
  int? size;

  ImgResult(
      {this.id,
      this.name,
      this.originalname,
      this.mimetype,
      this.link,
      this.size});

  factory ImgResult.fromJson(dynamic data) {
    return ImgResult(
        id: data["_id"],
        name: data["name"],
        originalname: data["originalname"],
        mimetype: data["mimetype"],
        link: data["link"],
        size: data["size"]);
  }
}
