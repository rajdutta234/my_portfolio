import 'package:flutter/material.dart';

class CyberGrid extends StatefulWidget {
  const CyberGrid({super.key});

  @override
  State<CyberGrid> createState() => _CyberGridState();
}

class _CyberGridState extends State<CyberGrid>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _CyberGridPainter(progress: _controller.value),
          size: Size.infinite,
        );
      },
    );
  }
}

class _CyberGridPainter extends CustomPainter {
  final double progress;
  _CyberGridPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = const Color(0xFF56F3D6).withValues(alpha: 0.15)
      ..strokeWidth = 1.0;

    const double gridSpacing = 60.0;
    final double verticalOffset = (progress * gridSpacing) % gridSpacing;

    // Perspective transformation parameters
    final double horizon = size.height * 0.4;

    // Draw horizontal lines (with perspective)
    for (double y = 0; y <= size.height - horizon; y += gridSpacing) {
      final double actualY = size.height - y + verticalOffset;
      if (actualY < horizon) continue;

      // Calculate opacity based on distance from bottom
      final double distanceFactor =
          (actualY - horizon) / (size.height - horizon);
      linePaint.color = const Color(
        0xFF56F3D6,
      ).withValues(alpha: 0.2 * distanceFactor);

      canvas.drawLine(
        Offset(0, actualY),
        Offset(size.width, actualY),
        linePaint,
      );
    }

    // Draw vertical lines (converging at horizon)
    const int verticalLines = 20;
    final double centerX = size.width / 2;
    for (int i = -verticalLines; i <= verticalLines; i++) {
      final double xOffset = i * gridSpacing * 2;

      // Lines converge at (centerX, horizon)
      canvas.drawLine(
        Offset(centerX + xOffset, size.height),
        Offset(centerX + xOffset * 0.1, horizon),
        linePaint,
      );
    }

    // Add a glowing "horizon" line
    final Paint horizonPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.transparent,
          const Color(0xFF56F3D6).withValues(alpha: 0.3),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTRB(0, horizon - 2, size.width, horizon + 2));

    canvas.drawRect(
      Rect.fromLTRB(0, horizon - 1, size.width, horizon + 1),
      horizonPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CyberGridPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
