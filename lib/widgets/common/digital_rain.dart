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
    for (int i = 0; i < 40; i++) {
      _drops.add(_RainDrop(
        x: _random.nextDouble(),
        y: _random.nextDouble() * 2 - 1,
        speed: _random.nextDouble() * 0.005 + 0.002,
        chars: _generateChars(),
        depth: _random.nextDouble(), // 0 = far, 1 = near
      )..updatePainter());
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
      if (_random.nextDouble() > 0.98 && !drop.chars.contains(RegExp(r'[A-Z]'))) {
        drop.chars = _generateChars();
        drop.updatePainter();
      }

      if (drop.y > 1.2) {
        drop.y = -0.5;
        drop.x = _random.nextDouble();
        drop.chars = _generateChars();
        drop.updatePainter();
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

  TextPainter? painter;

  void updatePainter() {
    final double opacity = (0.05 + (depth * 0.15)).clamp(0.0, 1.0);
    final double fontSize = 8 + (depth * 8);
    final Color color = depth > 0.7 
        ? const Color(0xFF56F3D6) 
        : const Color(0xFF00C2FF);

    painter = TextPainter(
      text: TextSpan(
        text: chars,
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
  }
}

class _RainPainter extends CustomPainter {
  final List<_RainDrop> drops;
  _RainPainter({required this.drops});

  @override
  void paint(Canvas canvas, Size size) {
    for (var drop in drops) {
      if (drop.painter == null) continue;
      
      final double fontSize = 8 + (drop.depth * 8);

      canvas.save();
      // Apply slight perspective tilt
      canvas.translate(drop.x * size.width, drop.y * size.height);
      canvas.skew(0.1 * (1 - drop.depth), 0);
      
      drop.painter!.paint(canvas, Offset.zero);
      
      // Add a small glow to the "head" of the drop (only for near drops)
      if (drop.depth > 0.8) {
        final headPaint = Paint()
          ..color = Colors.white.withValues(alpha: 0.1)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);
        canvas.drawCircle(Offset(fontSize / 2, 0), fontSize / 2, headPaint);
      }
      
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _RainPainter oldDelegate) => true;
}
