import 'package:flutter/material.dart';

class OverlayBoxDecoration extends StatelessWidget {
  final Widget child;
  final BoxDecoration decoration;

  OverlayBoxDecoration({required this.child, required this.decoration});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(decoration),
      child: child,
    );
  }
}


class MyPainter extends CustomPainter {
  final BoxDecoration decoration;

  MyPainter(this.decoration);

  @override
  void paint(Canvas canvas, Size size) {
    final painter = decoration.createBoxPainter();
    final Offset offset = Offset.zero;
    final ImageConfiguration configuration = ImageConfiguration(size: size);
    canvas.save();
    painter.paint(canvas, offset, configuration);
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}