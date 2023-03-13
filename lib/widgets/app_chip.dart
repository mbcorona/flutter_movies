import 'package:flutter/material.dart';

class AppChip extends StatelessWidget {
  AppChip({
    super.key,
    required this.text,
    Color? color,
    this.textColor = Colors.white,
  }) : color = color ?? Colors.white.withOpacity(.3);

  final String text;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
        ),
      ),
    );
  }
}
