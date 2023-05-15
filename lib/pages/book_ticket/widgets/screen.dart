import 'dart:math';

import 'package:flutter/material.dart';

class Screen extends StatelessWidget {
  const Screen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 30,
          child: CustomPaint(
            painter: ScreenPainter(),
          ),
        ),
        const Text(
          'Screen',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ],
    );
  }
}

class ScreenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()..color = Colors.white;

    Path path1 = Path()
      ..addArc(
        Rect.fromCenter(center: center, width: size.width - 20, height: size.height),
        pi,
        pi,
      );

    Path path2 = Path()
      ..addOval(
        Rect.fromCenter(center: center, width: size.width, height: size.height - 5),
      );

    final center3 = Offset(size.width / 2, size.height / 2 - 13);
    Path shadowPath = Path()
      ..addArc(
        Rect.fromCenter(center: center3, width: size.width - 20, height: size.height + 20),
        pi,
        pi,
      );
    canvas.drawShadow(shadowPath, Colors.white, 15, false);
    canvas.drawPath(
      Path.combine(PathOperation.difference, path1, path2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
