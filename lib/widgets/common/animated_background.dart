import 'dart:math' as math;
import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  Offset _mousePosition = Offset.zero;

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
    return MouseRegion(
      onHover: (event) => setState(() => _mousePosition = event.position),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return CustomPaint(
            painter: _MeshPainter(
              progress: _controller.value,
              mousePosition: _mousePosition,
            ),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}

class _MeshPainter extends CustomPainter {
  _MeshPainter({required this.progress, required this.mousePosition});

  final double progress;
  final Offset mousePosition;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    
    // Deep static background
    canvas.drawRect(rect, Paint()..color = const Color(0xFF020205));

    // Animated Blobs
    final List<Map<String, dynamic>> blobs = [
      {'color': const Color(0xFF1E3A8A), 'pos': Offset(0.2, 0.3), 'size': 300.0, 'speed': 1.0},
      {'color': const Color(0xFF581C87), 'pos': Offset(0.8, 0.7), 'size': 400.0, 'speed': 0.8},
      {'color': const Color(0xFF1E1B4B), 'pos': Offset(0.5, 0.5), 'size': 350.0, 'speed': 1.2},
      {'color': const Color(0xFF0F172A), 'pos': Offset(0.1, 0.8), 'size': 250.0, 'speed': 0.5},
    ];

    for (int i = 0; i < blobs.length; i++) {
      final blob = blobs[i];
      final double t = (progress * blob['speed'] + i * 0.2) % 1.0;
      
      // Calculate base position with oscillation
      double x = size.width * blob['pos'].dx + math.sin(t * math.pi * 2) * 100;
      double y = size.height * blob['pos'].dy + math.cos(t * math.pi * 2) * 100;

      // React to mouse
      final Offset target = Offset(x, y);
      final double dist = (mousePosition - target).distance;
      if (dist < 500) {
        final double factor = (1 - dist / 500).clamp(0, 1);
        x += (mousePosition.dx - x) * 0.15 * factor;
        y += (mousePosition.dy - y) * 0.15 * factor;
      }

      final Paint paint = Paint()
        ..color = blob['color'].withValues(alpha: 0.12)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 120);

      canvas.drawCircle(Offset(x, y), blob['size'] + math.sin(t * math.pi) * 40, paint);
    }

    // Static Noise Texture (simulated with random dots)
    // To keep performance high, we draw fewer but larger blurred noise points
    final math.Random random = math.Random(42);
    final Paint noisePaint = Paint()..color = Colors.white.withValues(alpha: 0.02);
    for (int i = 0; i < 40; i++) {
      final double nx = random.nextDouble() * size.width;
      final double ny = random.nextDouble() * size.height;
      canvas.drawCircle(Offset(nx, ny), 1.5, noisePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _MeshPainter oldDelegate) => true;
}
