import 'dart:math' as math;
import 'package:flutter/material.dart';

class DigitalRain extends StatefulWidget {
  const DigitalRain({super.key});

  @override
  State<DigitalRain> createState() => _DigitalRainState();
}

class _DigitalRainState extends State<DigitalRain> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final List<_RainDrop> _drops = [];
  final math.Random _random = math.Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    _initializeDrops();
  }

  void _initializeDrops() {
    for (int i = 0; i < 80; i++) {
      _drops.add(_RainDrop(
        x: _random.nextDouble(),
        y: _random.nextDouble() * 2 - 1,
        speed: _random.nextDouble() * 0.007 + 0.003,
        chars: _generateChars(),
        depth: _random.nextDouble(), // 0 = far, 1 = near
      ));
    }
  }

  String _generateChars() {
    const chars = '01{}()=>[];:<>!?@#\$%^&*+=-_';
    final List<String> keywords = [
      'DART', 'FLUTTER', 'FLASK', 'FASTAPI', 'PYTHON', 'WIDGET', 
      'UIUX', 'API', 'JSON', 'GIT', 'SQL', 'CSS', 'HTML'
    ];
    
    if (_random.nextDouble() > 0.7) {
      return keywords[_random.nextInt(keywords.length)];
    }
    
    return List.generate(15, (_) => chars[_random.nextInt(chars.length)]).join('\n');
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
        _updateDrops();
        return CustomPaint(
          painter: _RainPainter(drops: _drops),
          size: Size.infinite,
        );
      },
    );
  }

  void _updateDrops() {
    for (var drop in _drops) {
      drop.y += drop.speed;
      
      // Randomly change characters as they fall for more engagement
      if (_random.nextDouble() > 0.95 && !drop.chars.contains(RegExp(r'[A-Z]'))) {
        drop.chars = _generateChars();
      }

      if (drop.y > 1.2) {
        drop.y = -0.5;
        drop.x = _random.nextDouble();
        drop.chars = _generateChars();
      }
    }
  }
}

class _RainDrop {
  double x;
  double y;
  double speed;
  String chars;
  double depth;

  _RainDrop({
    required this.x,
    required this.y,
    required this.speed,
    required this.chars,
    required this.depth,
  });
}

class _RainPainter extends CustomPainter {
  final List<_RainDrop> drops;
  _RainPainter({required this.drops});

  @override
  void paint(Canvas canvas, Size size) {
    for (var drop in drops) {
      final double opacity = (0.05 + (drop.depth * 0.15)).clamp(0.0, 1.0);
      final double fontSize = 8 + (drop.depth * 8);
      final Color color = drop.depth > 0.7 
          ? const Color(0xFF56F3D6) 
          : const Color(0xFF00C2FF);

      final textPainter = TextPainter(
        text: TextSpan(
          text: drop.chars,
          style: TextStyle(
            color: color.withValues(alpha: opacity),
            fontSize: fontSize,
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      canvas.save();
      // Apply slight perspective tilt
      canvas.translate(drop.x * size.width, drop.y * size.height);
      canvas.skew(0.1 * (1 - drop.depth), 0);
      
      textPainter.paint(canvas, Offset.zero);
      
      // Add a small glow to the "head" of the drop
      final headPaint = Paint()
        ..color = Colors.white.withValues(alpha: opacity * 0.5)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
      canvas.drawCircle(Offset(fontSize / 2, 0), fontSize / 2, headPaint);
      
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _RainPainter oldDelegate) => true;
}
