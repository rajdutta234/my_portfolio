import 'dart:math' as math;
import 'package:flutter/material.dart';
import './particle_field.dart';

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
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    
    return MouseRegion(
      onHover: (event) => setState(() => _mousePosition = event.localPosition),
      child: Stack(
        children: [
          // Deep Base Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topLeft,
                radius: 1.5,
                colors: [
                  Color(0xFF0A192F),
                  Color(0xFF020C1B),
                ],
              ),
            ),
          ),

          // Cinematic Mesh Blobs
          AnimatedBuilder(
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

          // Ambient Particles
          ParticleField(
            width: size.width,
            height: size.height,
            numberOfParticles: 120,
            particleColor: const Color(0xFF56F3D6),
          ),
          
        ],
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
    final List<Map<String, dynamic>> blobs = <Map<String, dynamic>>[
      {
        'color': const Color(0xFF00C2FF),
        'pos': const Offset(0.2, 0.3),
        'size': 450.0,
        'speed': 0.4,
      },
      {
        'color': const Color(0xFF56F3D6),
        'pos': const Offset(0.8, 0.7),
        'size': 500.0,
        'speed': 0.3,
      },
      {
        'color': const Color(0xFF1D4ED8),
        'pos': const Offset(0.5, 0.5),
        'size': 400.0,
        'speed': 0.5,
      },
      {
        'color': const Color(0xFF0EA5E9),
        'pos': const Offset(0.1, 0.8),
        'size': 350.0,
        'speed': 0.6,
      },
    ];

    for (int i = 0; i < blobs.length; i++) {
      final blob = blobs[i];
      final double t = (progress * blob['speed'] + i * 0.25) % 1.0;

      double x = size.width * blob['pos'].dx + math.sin(t * math.pi * 2) * 120;
      double y = size.height * blob['pos'].dy + math.cos(t * math.pi * 2) * 120;

      // Mouse Attraction
      final Offset target = Offset(x, y);
      final double dist = (mousePosition - target).distance;
      if (dist < 800) {
        final double factor = (1 - dist / 800).clamp(0, 1);
        x += (mousePosition.dx - x) * 0.15 * factor;
        y += (mousePosition.dy - y) * 0.15 * factor;
      }

      final Paint paint = Paint()
        ..color = blob['color'].withValues(alpha: 0.08)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 150);

      canvas.drawCircle(
        Offset(x, y),
        blob['size'] + math.sin(t * math.pi) * 50,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _MeshPainter oldDelegate) => true;
}
