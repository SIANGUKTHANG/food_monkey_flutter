import 'dart:convert';

import 'package:foodmonkey/models/Category.dart';
import 'package:foodmonkey/models/Tag.dart';
import 'package:http/http.dart' as http;
import 'package:foodmonkey/utils/Constants.dart';

class Api {
  static Future<bool> getApiVersion() async {
    Uri uri = Uri.parse("${Constants.API_URL}/appversion");
    var resStr = await http.get(uri);
    var response = jsonDecode(resStr.body);
    if (response["con"]) {
      if (double.parse(response["result"]) == Constants.APP_VERSION) {
        return true;
      }
    }

    return false;
  }

  static Future<bool> getAllTags() async {
    Uri uri = Uri.parse("${Constants.API_URL}/tags");
    var resStr = await http.get(uri);
    var response = jsonDecode(resStr.body);
    if (response["con"]) {
      var tagList = response["result"] as List;
      Constants.tags = tagList.map((tag) => Tag.fromJson(tag)).toList();
    }

    return response["con"];
  }

  static Future<bool> getAllCats() async {
    Uri uri = Uri.parse("${Constants.API_URL}/categories");
    var resStr = await http.get(uri);
    var response = jsonDecode(resStr.body);
    if (response["con"]) {
      var catList = response["result"] as List;
      Constants.cats = catList.map((tag) => Category.fromJson(tag)).toList();
    }

    return response["con"];
  }
}
