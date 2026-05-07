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
      duration: const Duration(seconds: 14),
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

    final Paint base = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF04080F),
          Color(0xFF050C16),
          Color(0xFF071425),
        ],
      ).createShader(rect);
    canvas.drawRect(rect, base);

    final List<Map<String, dynamic>> blobs = <Map<String, dynamic>>[
      {
        'color': const Color(0xFF00C2FF),
        'pos': const Offset(0.15, 0.22),
        'size': 300.0,
        'speed': 0.65,
      },
      {
        'color': const Color(0xFF56F3D6),
        'pos': const Offset(0.86, 0.78),
        'size': 360.0,
        'speed': 0.52,
      },
      {
        'color': const Color(0xFF386FA4),
        'pos': const Offset(0.48, 0.52),
        'size': 320.0,
        'speed': 0.72,
      },
      {
        'color': const Color(0xFF0A2B47),
        'pos': const Offset(0.08, 0.9),
        'size': 280.0,
        'speed': 0.38,
      },
      {
        'color': const Color(0xFF2F5B82),
        'pos': const Offset(0.78, 0.12),
        'size': 220.0,
        'speed': 0.84,
      },
    ];

    for (int i = 0; i < blobs.length; i++) {
      final blob = blobs[i];
      final double t = (progress * blob['speed'] + i * 0.2) % 1.0;

      // Calculate base position with oscillation
      double x = size.width * blob['pos'].dx + math.sin(t * math.pi * 2) * 72;
      double y = size.height * blob['pos'].dy + math.cos(t * math.pi * 2) * 72;

      // React to mouse
      final Offset target = Offset(x, y);
      final double dist = (mousePosition - target).distance;
      if (dist < 600) {
        final double factor = (1 - dist / 600).clamp(0, 1);
        x += (mousePosition.dx - x) * 0.1 * factor;
        y += (mousePosition.dy - y) * 0.1 * factor;
      }

      final Paint paint = Paint()
        ..color = blob['color'].withValues(alpha: 0.1)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 120);

      canvas.drawCircle(
        Offset(x, y),
        blob['size'] + math.sin(t * math.pi) * 30,
        paint,
      );
    }

    final math.Random random = math.Random(42);
    final Paint noisePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.025);
    for (int i = 0; i < 52; i++) {
      final double nx = random.nextDouble() * size.width;
      final double ny = random.nextDouble() * size.height;
      canvas.drawCircle(Offset(nx, ny), 1.5, noisePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _MeshPainter oldDelegate) => true;
}
