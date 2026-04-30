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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
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
      builder: (BuildContext context, Widget? child) {
        return CustomPaint(
          painter: _ParticlePainter(progress: _controller.value),
          size: Size.infinite,
        );
      },
    );
  }
}

class _ParticlePainter extends CustomPainter {
  _ParticlePainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    
    // Background gradient
    final Paint bgPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          const Color(0xFF0A0A0A),
          const Color(0xFF1A1A1A),
          const Color(0xFF0F0F2A),
        ],
      ).createShader(rect);
    canvas.drawRect(rect, bgPaint);

    // Dynamic glow spots
    final Paint glowPaint = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 100);

    final List<Offset> centers = [
      Offset(size.width * 0.2, size.height * 0.3),
      Offset(size.width * 0.8, size.height * 0.7),
      Offset(size.width * 0.5, size.height * 0.5),
    ];

    for (int i = 0; i < centers.length; i++) {
      final double t = (progress + i * 0.33) % 1;
      final double x = centers[i].dx + math.sin(t * math.pi * 2) * 50;
      final double y = centers[i].dy + math.cos(t * math.pi * 2) * 50;
      
      glowPaint.color = [
        Colors.blue.withValues(alpha: 0.08),
        Colors.purple.withValues(alpha: 0.08),
        Colors.teal.withValues(alpha: 0.08),
      ][i];
      
      canvas.drawCircle(Offset(x, y), 200 + math.sin(t * math.pi) * 50, glowPaint);
    }

    final Paint particlePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.15)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    for (int i = 0; i < 30; i++) {
      final double t = (progress + i * 0.03) % 1;
      final double x = size.width * (0.05 + 0.9 * ((i * 43) % 100) / 100);
      final double y = size.height * (1 - t); // Floating upwards
      final double wave = math.sin((progress * math.pi * 2) + i) * 30;
      final double sizeMultiplier = 1 + math.sin(t * math.pi);
      
      canvas.drawCircle(
        Offset(x + wave, y), 
        (1.5 + (i % 4)) * sizeMultiplier, 
        particlePaint..color = Colors.white.withValues(alpha: 0.1 * (1 - t))
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
