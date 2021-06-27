import 'dart:convert';

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
}
