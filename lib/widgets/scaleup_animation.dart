import 'package:flutter/material.dart';

class ScaleUpAnimation extends StatelessWidget {
  const ScaleUpAnimation({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 2000),
      curve: Curves.easeOut,
      builder: (context, double value, _) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
    );
  }
}
