import 'package:flutter/material.dart';
import 'package:foodmonkey/models/Category.dart';
import 'package:foodmonkey/models/Tag.dart';

class Constants {
  static const Color primary = Color(0xFFF6F6F6);
  static const Color secondary = Color(0xFFFFBB91);
  static const Color accent = Color(0xFFFF8E6E);
  static const Color normal = Color(0xFF515070);

  static const Color yellow = Color(0xffFDC054);
  static const Color darkGrey = Color(0xff202020);
  static const Color transparentYellow = Color.fromRGBO(253, 184, 70, 0.7);

  static const double APP_VERSION = 1.0;

  static const BASE_URL = "http://10.0.2.2:3000";
  static const API_URL = "$BASE_URL/api";

  static List<Tag> tags = [];
  static List<Category> cats = [];

  static TextStyle getTitleTextStyle(double size) {
    return TextStyle(
        color: Constants.normal, fontWeight: FontWeight.bold, fontSize: size);
  }

  static String changeImage(String image) {
    var img = "http://192.168.8.104:3000/uploads/" + image.split("uploads")[1];
    print("img is " + img);
    return img;
  }
}
