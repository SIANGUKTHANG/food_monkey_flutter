import 'package:flutter/cupertino.dart';
import 'package:foodmonkey/utils/Constants.dart';

class TrianglePainter extends CustomPainter {
  var msize;
  TrianglePainter({this.msize});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint();
    paint.color = Constants.secondary;

    Path upPath = new Path();
    upPath.moveTo(msize.width / 3, 0);
    upPath.lineTo(msize.width, 0);
    upPath.lineTo(msize.width, msize.height / 3);
    upPath.close();

    Path downPath = new Path();
    downPath.moveTo(0, (msize.height / 4) * 2.5);
    downPath.lineTo(0, msize.height);
    downPath.lineTo((msize.width / 4) * 3, msize.height);
    downPath.close();

    canvas.drawPath(upPath, paint);
    canvas.drawPath(downPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
