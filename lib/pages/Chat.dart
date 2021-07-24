import 'dart:html';

import 'package:flutter/material.dart';
import 'package:foodmonkey/utils/Constants.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<Map> chats = [
    {"from": "Mg Mg", "to": "Aung Aung", "msg": "M to A", "type": "text"},
    {"from": "Aung Aung", "to": "Mg Mg", "msg": "A to M", "type": "text"},
    {"from": "Mg Mg", "to": "Aung Aung", "msg": "image Link", "type": "photo"},
    {"from": "Aung Aung", "to": "Mg Mg", "msg": "image Link", "type": "photo"},
    {"from": "Mg Mg", "to": "Aung Aung", "msg": "M to A", "type": "text"},
    {"from": "Aung Aung", "to": "Mg Mg", "msg": "A to M", "type": "text"},
    {"from": "Mg Mg", "to": "Aung Aung", "msg": "image Link", "type": "photo"},
    {"from": "Aung Aung", "to": "Mg Mg", "msg": "image Link", "type": "photo"}
  ];
  final _chatTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) => chats[index]['from'] == "Mg Mg"
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
              Icon(
                Icons.send,
                size: 35,
              ),
            ],
          ),
        )
      ],
    ));
  }

  Widget _buildLeftChat(chat, mwidth) {
    return chat["type"] == "text"
        ? _buildLeftText(chat, mwidth)
        : _buildLeftImage(chat["msg"], mwidth);
  }

  Widget _buildRightChat(chat, mwidth) {
    return chat["type"] == "text"
        ? _buildRightText(chat, mwidth)
        : _buildRightImage(chat["msg"], mwidth);
  }

  Widget _buildLeftText(chat, mwidth) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
        width: (mwidth / 3) * 2,
        // padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            // color: Constants.secondary,
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Mg Mg",
                style: TextStyle(
                    color: Constants.normal, fontWeight: FontWeight.bold)),
            Text(Constants.sampleText,
                textAlign: TextAlign.justify,
                style: TextStyle(color: Constants.normal)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("2020-07-04",
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
    return Image.asset("assets/images/fm.png");
  }

  Widget _buildRightText(chat, mwidth) {
    return Text(chat["msg"]);
  }

  Widget _buildRightImage(image, mwidth) {
    return Image.asset("assets/images/fm.png");
  }
}
