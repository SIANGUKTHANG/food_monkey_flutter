import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foodmonkey/models/Tag.dart';
import 'package:foodmonkey/utils/Constants.dart';

class Product extends StatefulWidget {
  final String? type, name;
  const Product({Key? key, this.type, this.name}) : super(key: key);

  @override
  _ProductState createState() => _ProductState(type, name);
}

class _ProductState extends State<Product> {
  final String? type, name;
  int currentIndex = 0;
  _ProductState(this.type, this.name);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("$type : $name")),
        body: Column(
          children: [
            Container(
              height: 30,
              padding: EdgeInsets.only(top: 3),
              // decoration: BoxDecoration(
              //   color: Constants.accent,
              // ),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: Constants.tags.length,
                  itemBuilder: (context, index) =>
                      _buildTitleTab(index, Constants.tags[index])),
            )
          ],
        ));
  }

  Widget _buildTitleTab(index, Tag tag) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: () {
          setState(() {
            currentIndex = index;
          });
        },
        child: Column(children: [
          Text(tag.name ?? "",
              style: TextStyle(color: Constants.normal, fontSize: 16)),
          Container(
            width: 60,
            height: 3,
            decoration: BoxDecoration(
                color: index == currentIndex
                    ? Constants.accent
                    : Colors.transparent),
          )
        ]),
      ),
    );
  }
}
