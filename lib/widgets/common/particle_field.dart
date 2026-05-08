import 'dart:math' as math;
import 'package:flutter/material.dart';

class ParticleField extends StatefulWidget {
  const ParticleField({
    super.key,
    required this.width,
    required this.height,
    this.numberOfParticles = 100,
    this.particleColor = const Color(0xFF56F3D6),
    this.maxParticleSize = 2.0,
  });

  final double width;
  final double height;
  final int numberOfParticles;
  final Color particleColor;
  final double maxParticleSize;

  @override
  State<ParticleField> createState() => _ParticleFieldState();
}

class _ParticleFieldState extends State<ParticleField> with SingleTickerProviderStateMixin {
  late List<_Particle> _particles;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _particles = List.generate(widget.numberOfParticles, (index) => _Particle(widget.width, widget.height));
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
        for (var particle in _particles) {
          particle.update(widget.width, widget.height);
        }
        return CustomPaint(
          size: Size(widget.width, widget.height),
          painter: _ParticlePainter(
            particles: _particles,
            color: widget.particleColor,
            maxSize: widget.maxParticleSize,
          ),
        );
      },
    );
  }
}

class _Particle {
  _Particle(double width, double height) {
    reset(width, height);
  }

  late double x;
  late double y;
  late double vx;
  late double vy;
  late double size;

  void reset(double width, double height) {
    final random = math.Random();
    x = random.nextDouble() * width;
    y = random.nextDouble() * height;
    vx = (random.nextDouble() - 0.5) * 1.5;
    vy = (random.nextDouble() - 0.5) * 1.5;
    size = random.nextDouble();
  }

  void update(double width, double height) {
    x += vx;
    y += vy;

    if (x < 0) x = width;
    if (x > width) x = 0;
    if (y < 0) y = height;
    if (y > height) y = 0;
  }
}

class _ParticlePainter extends CustomPainter {
  _ParticlePainter({required this.particles, required this.color, required this.maxSize});

  final List<_Particle> particles;
  final Color color;
  final double maxSize;

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      canvas.drawCircle(
        Offset(particle.x, particle.y),
        particle.size * maxSize,
        Paint()..color = color.withValues(alpha: 0.2 + (particle.size * 0.3)),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
