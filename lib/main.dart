import 'package:flutter/material.dart';
import 'package:foodmonkey/pages/Flash.dart';
import 'package:foodmonkey/pages/Home.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {"/": (context) => Flash(), "/home": (context) => Home()},
      theme: ThemeData(fontFamily: 'English')));
}
