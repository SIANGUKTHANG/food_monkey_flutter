import 'package:flutter/material.dart';
import 'package:foodmonkey/models/Message.dart';
import 'package:foodmonkey/utils/Constants.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<Message> chats = [];
  final _chatTextController = TextEditingController();

  invokeSocket() {
    Constants.socket?.emit('load');
    Constants.socket?.on('message', (data) {
      Message msg = Message.fromJson(data);
      chats.add(msg);
      setState(() {});
    });
    Constants.socket?.on('messages', (data) {
      List lisy = data as List;
      chats = lisy.map((e) => Message.fromJson(e)).toList();
      setState(() {});
    });
  }

  _emitMessage(msg, type) {
    var sendMsg = new Map();
    sendMsg["from"] = Constants.user?.id;
    sendMsg["to"] = Constants.shopId;
    sendMsg["msg"] = msg;
    sendMsg["type"] = type;
    Constants.socket?.emit("message", sendMsg);
  }

  @override
  void initState() {
    super.initState();
    invokeSocket();
  }

  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) =>
                chats[index].from?.name == Constants.user?.name
                    ? _buildLeftChat(chats[index], mwidth)
                    : _buildRightChat(chats[index], mwidth),
          ),
        ),
        Container(
          height: 50,
          color: Constants.normal,
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Icon(
                Icons.file_copy,
                size: 35,
              ),
              Expanded(
                child: TextFormField(
                  controller: _chatTextController,
                  decoration: InputDecoration(
                    labelStyle:
                        TextStyle(color: Constants.normal, fontSize: 14),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Constants.primary)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Constants.primary)),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _emitMessage(_chatTextController.text, "text");
                },
                child: Icon(
                  Icons.send,
                  size: 35,
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }

  Widget _buildLeftChat(chat, mwidth) {
    return chat.type == "text"
        ? _buildLeftText(chat, mwidth)
        : _buildLeftImage(chat.msg, mwidth);
  }

  Widget _buildRightChat(chat, mwidth) {
    return chat.type == "text"
        ? _buildRightText(chat, mwidth)
        : _buildRightImage(chat.msg, mwidth);
  }

  Widget _buildLeftText(chat, mwidth) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
        width: (mwidth / 3) * 2,
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Constants.secondary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(chat.from.name,
                style: TextStyle(
                    color: Constants.normal, fontWeight: FontWeight.bold)),
            Text(chat.msg,
                textAlign: TextAlign.justify,
                style: TextStyle(color: Constants.normal)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(chat.created.split("T")[0],
                    style: TextStyle(
                        color: Constants.primary, fontWeight: FontWeight.bold))
              ],
            )
          ],
        ),
      )
    ]);
  }

  Widget _buildLeftImage(image, mwidth) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
          width: (mwidth / 3) * 2,
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Constants.secondary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              )),
          child: Image.asset("assets/images/fm.png"))
    ]);
  }

  Widget _buildRightText(chat, mwidth) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Container(
        width: (mwidth / 3) * 2,
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Constants.accent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(chat.from.name,
                style: TextStyle(
                    color: Constants.normal, fontWeight: FontWeight.bold)),
            Text(chat.msg,
                textAlign: TextAlign.justify,
                style: TextStyle(color: Constants.normal)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(chat.created.split("T")[0],
                    style: TextStyle(
                        color: Constants.primary, fontWeight: FontWeight.bold))
              ],
            )
          ],
        ),
      )
    ]);
  }

  Widget _buildRightImage(image, mwidth) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Container(
          width: (mwidth / 3) * 2,
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Constants.secondary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              )),
          child: Image.asset("assets/images/fm.png"))
    ]);
  }
}
