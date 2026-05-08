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
    final Paint paint = Paint()..style = PaintingStyle.fill;
    final Paint linePaint = Paint()..strokeWidth = 0.5;

    for (int i = 0; i < particles.length; i++) {
      final p1 = particles[i];
      
      // Draw Connections (Neural Effect)
      for (int j = i + 1; j < particles.length; j++) {
        final p2 = particles[j];
        final double distance = math.sqrt(
          math.pow(p1.x - p2.x, 2) + math.pow(p1.y - p2.y, 2)
        );
        
        if (distance < 120) {
          final double opacity = (1.0 - (distance / 120)).clamp(0.0, 1.0);
          linePaint.color = color.withValues(alpha: opacity * 0.15);
          canvas.drawLine(Offset(p1.x, p1.y), Offset(p2.x, p2.y), linePaint);
        }
      }

      // Draw Particle
      final double pOpacity = (0.2 + (p1.size * 0.3)).clamp(0.0, 1.0);
      paint.color = color.withValues(alpha: pOpacity);
      
      canvas.drawCircle(
        Offset(p1.x, p1.y),
        p1.size * maxSize,
        paint,
      );
      
      // Subtle Glow for larger particles
      if (p1.size > 0.7) {
        canvas.drawCircle(
          Offset(p1.x, p1.y),
          p1.size * maxSize * 2.5,
          Paint()
            ..color = color.withValues(alpha: pOpacity * 0.2)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
