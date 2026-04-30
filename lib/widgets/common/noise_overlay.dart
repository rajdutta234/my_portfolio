import 'dart:math' as math;
import 'package:flutter/material.dart';

class NoiseOverlay extends StatelessWidget {
  const NoiseOverlay({super.key, this.opacity = 0.03});

  final double opacity;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Opacity(
        opacity: opacity,
        child: CustomPaint(
          painter: _NoisePainter(),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class _NoisePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final random = math.Random();

    for (double i = 0; i < size.width; i += 2) {
      for (double j = 0; j < size.height; j += 2) {
        if (random.nextDouble() > 0.5) {
          paint.color = Colors.white;
          canvas.drawRect(Rect.fromLTWH(i, j, 1, 1), paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
