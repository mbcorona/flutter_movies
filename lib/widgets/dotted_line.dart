import 'package:flutter/material.dart';

class DottedLine extends StatelessWidget {
  const DottedLine({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 3),
      painter: _DottedlinePainter(),
    );
  }
}

class _DottedlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4;

    for (double i = 0; i < size.width; i += 15) {
      if (i % 3 == 0) {
        canvas.drawLine(Offset(i, 0), Offset(i + 10, 0), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
