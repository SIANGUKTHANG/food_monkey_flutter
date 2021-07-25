class Message {
  String? id, msg, type, created;
  MsgFrom? from;
  MsgTo? to;
  Message({this.id, this.msg, this.type, this.created, this.from, this.to});

  factory Message.fromJson(dynamic data) {
    MsgFrom from = MsgFrom.fromJson(data["from"]);
    MsgTo to = MsgTo.fromJson(data["to"]);

    return Message(
      id: data["_id"],
      msg: data["msg"],
      type: data["type"],
      created: data["created"],
      to: to,
      from: from,
    );
  }
}

class MsgFrom {
  String? id, name;
  MsgFrom({this.id, this.name});
  factory MsgFrom.fromJson(dynamic data) {
    return MsgFrom(id: data["_id"], name: data["name"]);
  }
}

class MsgTo {
  String? id, name;
  MsgTo({this.id, this.name});
  factory MsgTo.fromJson(dynamic data) {
    return MsgTo(id: data["_id"], name: data["name"]);
  }
}

/*
   {
        "from": "605c19163bac7310fb16aabc",
        "to": "605c19163bac7310fb16aabb",
        "msg": "From Tester to Owner",
        "type": "text"
    }

emit =>message 
message => 
emt => load 
messages => asdf
*/
