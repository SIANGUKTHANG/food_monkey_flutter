import 'package:flutter/material.dart';
import 'package:foodmonkey/models/Category.dart';
import 'package:foodmonkey/models/Product.dart';
import 'package:foodmonkey/models/Tag.dart';
import 'package:foodmonkey/models/User.dart';

class Constants {
  static const Color primary = Color(0xFFF6F6F6);
  static const Color secondary = Color(0xFFFFBB91);
  static const Color accent = Color(0xFFFF8E6E);
  static const Color normal = Color(0xFF515070);

  static const Color yellow = Color(0xffFDC054);
  static const Color darkGrey = Color(0xff202020);
  static const Color transparentYellow = Color.fromRGBO(253, 184, 70, 0.7);

  static const double APP_VERSION = 1.0;

  static const BASE_URL = "http://192.168.8.101:3000";
  static const API_URL = "$BASE_URL/api";
  static const String sampleText = """
  Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dolores iure impedit nulla eligendi dolorum neque amet id deleniti! Non a nesciunt sapiente exercitationem velit aspernatur consequatur asperiores molestiae blanditiis cum?""";
  static const String sampleImg1 =
      "$BASE_URL/uploads/7_Day_Return_Warrranty_1625998058309.png";
  static const String sampleImg2 =
      "$BASE_URL/uploads/7_Day_Return_Warrranty_1625998114663.png";

  static List<Tag> tags = [];
  static List<Category> cats = [];
  static User? user;
  static Map<String, String> headers = {"content-type": "application/json"};
  static Map<String, String> tokenHeader = {
    "content-type": "application/json",
    "authorization": "Bearer ${user?.token}"
  };

  static TextStyle getTitleTextStyle(double size) {
    return TextStyle(
        color: Constants.normal, fontWeight: FontWeight.bold, fontSize: size);
  }

  static String changeImage(String image) {
    var img = "$BASE_URL/uploads/" + image.split("uploads")[1];
    print("img is " + img);
    return img;
  }

  static List<Product> cartProducts = [];

  static addToCard(product) {
    bool exist = false;
    if (cartProducts.length > 0) {
      cartProducts.forEach((pro) {
        if (pro.id == product.id) {
          exist = true;
          pro.count++;
        }
      });
      if (!exist) {
        cartProducts.add(product);
      }
    } else {
      cartProducts.add(product);
    }
  }

  static removeProduct(product) {
    cartProducts.removeWhere((pro) => pro.id == product.id);
  }

  static reduceProductCount(product) {
    cartProducts.forEach((pro) {
      if (pro.id == product.id) {
        if (pro.count > 1) {
          pro.count--;
        }
      }
    });
  }

  static addProductCount(product) {
    cartProducts.forEach((pro) {
      if (pro.id == product.id) {
        pro.count++;
      }
    });
  }

  static getCartTotal() {
    int total = 0;
    cartProducts.forEach((pro) {
      total += pro.count * (pro.price ?? 0);
    });
    return total;
  }

  static Padding getCartAction(context, color) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 20),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Icon(Icons.shopping_cart, size: 40, color: color),
          Positioned(
            right: -2,
            top: -7,
            child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: Constants.accent,
                  shape: BoxShape.circle,
                ),
                child: Center(
                    child: Text(
                        Constants.cartProducts.length
                            .toString()
                            .padLeft(2, "0"),
                        style: TextStyle(fontSize: 12)))),
          )
        ],
      ),
    );
  }

  static generateOrder() {
    List<Map> cartList = [];
    cartProducts.forEach((prd) {
      var map = new Map();
      map["count"] = prd.count.toString();
      map["productId"] = prd.id;
      cartList.add(map);
    });
    return cartList;
  }
}
