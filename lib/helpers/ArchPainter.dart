import 'package:flutter/material.dart';
import 'package:foodmonkey/utils/Constants.dart';
import 'dart:math' as math;

class ArchPainter extends CustomPainter {
  var msize;
  ArchPainter(this.msize);
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Constants.secondary;

    final rect = Rect.fromLTRB(-550, 200, msize.width + 5, msize.height + 500);

    final startAngle = -degreeToRadian(100);
    final sweepAngle = degreeToRadian(300);
    final useCenter = false;

    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint);
  }

  degreeToRadian(value) {
    return value * (math.pi / 180);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
