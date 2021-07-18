class User {
  String? id, name, email, phone, created, token;
  bool? status;

  User({this.id, this.name, this.email, this.phone, this.created, this.token});

  factory User.fromJson(dynamic data) {
    return User(
      id: data["_id"],
      name: data["name"],
      email: data["email"],
      phone: data["phone"],
      created: data["created"],
      token: data["token"],
    );
  }
}
