import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodmonkey/models/ImgResult.dart';
import 'package:foodmonkey/models/Message.dart';
import 'package:foodmonkey/utils/Constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<Message> chats = [];
  final _chatTextController = TextEditingController();

  final picker = ImagePicker();
  File? _image;
  ScrollController _scrollController =
      ScrollController(initialScrollOffset: 50);
  invokeSocket() {
    Constants.socket?.emit('load');
    Constants.socket?.on('message', (data) {
      Message msg = Message.fromJson(data);
      chats.add(msg);
      setState(() {
        _scrollController.animateTo(
            _scrollController.position.maxScrollExtent + 450,
            duration: Duration(seconds: 1),
            curve: Curves.fastOutSlowIn);
      });
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
            controller: _scrollController,
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
              InkWell(
                onTap: () => _getImage(),
                child: Icon(
                  Icons.file_copy,
                  size: 35,
                ),
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

  _uploadImageNow() async {
    var galleryUri = Uri.parse("${Constants.BASE_URL}/gallery");

    http.MultipartRequest request =
        new http.MultipartRequest("POST", galleryUri);

    http.MultipartFile multipartFile =
        await http.MultipartFile.fromPath("photo", _image?.path ?? "");
    request.files.add(multipartFile);

    await request.send().then((response) async {
      response.stream.transform(utf8.decoder).listen((value) {
        var resData = jsonDecode(value);
        ImgResult imageRes = ImgResult.fromJson(resData["result"]);
        _emitMessage(imageRes.link, "image");
      });
    }).catchError((e) => print(e));
  }

  Future _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      print("Image Path");
      print(pickedFile?.path);
      _image = File(pickedFile?.path ?? "");
      _uploadImageNow();
    });
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
          child: Image.network(_changeImage(image)))
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
          child: Image.network(_changeImage(image)))
    ]);
  }

  static String _changeImage(String image) {
    var img = "${Constants.BASE_URL}/uploads" + image.split("uploads")[1];
    print("Changed Image is $img");
    return img;
  }
}
