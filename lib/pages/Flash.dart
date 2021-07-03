import 'package:flutter/material.dart';
import 'package:foodmonkey/helpers/TrianglePainter.dart';
import 'package:foodmonkey/utils/Api.dart';
import 'package:foodmonkey/utils/Constants.dart';

class Flash extends StatefulWidget {
  const Flash({Key? key}) : super(key: key);

  @override
  _FlashState createState() => _FlashState();
}

class _FlashState extends State<Flash> {
  checkAppVersion() async {
    bool bol = await Api.getApiVersion();
    bool checkTags = await Api.getAllTags();
    bool checkCats = await Api.getAllCats();
    if (bol && checkTags && checkCats) {
      Navigator.pushReplacementNamed(context, "/home");
    }
  }

  @override
  void initState() {
    super.initState();
    checkAppVersion();
  }

  @override
  Widget build(BuildContext context) {
    var msize = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        CustomPaint(
          painter: TrianglePainter(msize: msize),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text("Food Monkey",
                  style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: Constants.normal)),
            ),
            SizedBox(height: 60),
            Center(child: Image.asset("assets/images/fm.png")),
            SizedBox(height: 60),
            Center(
                child: CircularProgressIndicator(
              color: Constants.secondary,
              backgroundColor: Constants.normal,
              // valueColor: AlwaysStoppedAnimation(Colors.red)
            ))
          ],
        )
      ],
    ));
  }
}
