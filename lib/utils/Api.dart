import 'dart:convert';

import 'package:foodmonkey/models/Category.dart';
import 'package:foodmonkey/models/History.dart';
import 'package:foodmonkey/models/Product.dart';
import 'package:foodmonkey/models/Tag.dart';
import 'package:foodmonkey/models/User.dart';
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

  static Future<List<Product>> getPagintatedProduct(pageNo) async {
    Uri uri = Uri.parse("${Constants.API_URL}/products/${pageNo}");
    var resStr = await http.get(uri);
    var response = jsonDecode(resStr.body);
    List<Product> products = [];
    if (response["con"]) {
      var catList = response["result"] as List;
      products = catList.map((tag) => Product.fromJson(tag)).toList();
    }
    print(products.length);
    return products;
  }

  static Future<bool> register({name, email, phone, password}) async {
    Uri uri = Uri.parse("${Constants.BASE_URL}/user/register");
    var json = jsonEncode(
        {"name": name, "email": email, "phone": phone, "password": password});
    var response = await http.post(uri, body: json, headers: Constants.headers);
    var responseData = jsonDecode(response.body);
    print(responseData);
    return true;
  }

  static Future<bool> login({phone, password}) async {
    Uri uri = Uri.parse("${Constants.BASE_URL}/user");
    var json = jsonEncode({"phone": phone, "password": password});
    var response = await http.post(uri, body: json, headers: Constants.headers);
    var responseData = jsonDecode(response.body);
    Constants.user = User.fromJson(responseData["result"]);
    return true;
  }

  static Future<bool> orderUpload({total, items}) async {
    Uri uri = Uri.parse("${Constants.API_URL}/order");
    var json = jsonEncode({"total": total, "items": items});
    var response =
        await http.post(uri, body: json, headers: Constants.tokenHeader);
    var responseData = jsonDecode(response.body);
    print(responseData);
    return responseData["con"];
  }

  static Future<List<History>> getMyOrders() async {
    var url = "${Constants.API_URL}/userorder/${Constants.user?.id}";

    var response = await http.get(Uri.parse(url));
    var responseData = jsonDecode(response.body);

    List<History> hs = [];
    if (responseData['con']) {
      var data = responseData['result'] as List;
      hs = data.map((e) => History.fromJson(e)).toList();
    }
    print(hs.length);
    return hs;
  }
}
