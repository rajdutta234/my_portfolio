import 'package:flutter/material.dart';
import 'dart:math' as math;

class SkillsConstellation extends StatefulWidget {
  final List<String> skills;
  const SkillsConstellation({super.key, required this.skills});

  @override
  State<SkillsConstellation> createState() => _SkillsConstellationState();
}

class _SkillsConstellationState extends State<SkillsConstellation> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final List<_SkillNode> _nodes = [];
  Offset _mousePosition = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
    
    _generateNodes();
  }

  void _generateNodes() {
    final random = math.Random();
    for (var skill in widget.skills) {
      _nodes.add(_SkillNode(
        name: skill,
        x: random.nextDouble(),
        y: random.nextDouble(),
        vx: (random.nextDouble() - 0.5) * 0.002,
        vy: (random.nextDouble() - 0.5) * 0.002,
        size: 5.0 + random.nextDouble() * 5.0,
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        final box = context.findRenderObject() as RenderBox;
        setState(() => _mousePosition = box.globalToLocal(event.position));
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          _updateNodes();
          return CustomPaint(
            painter: _ConstellationPainter(
              nodes: _nodes,
              mousePosition: _mousePosition,
            ),
            size: Size.infinite,
          );
        },
      ),
    );
  }

  void _updateNodes() {
    for (var node in _nodes) {
      node.x += node.vx;
      node.y += node.vy;

      if (node.x < 0 || node.x > 1) node.vx *= -1;
      if (node.y < 0 || node.y > 1) node.vy *= -1;
    }
  }
}

class _SkillNode {
  final String name;
  double x, y, vx, vy, size;
  _SkillNode({
    required this.name,
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.size,
  });
}

class _ConstellationPainter extends CustomPainter {
  final List<_SkillNode> nodes;
  final Offset mousePosition;
  _ConstellationPainter({required this.nodes, required this.mousePosition});

  @override
  void paint(Canvas canvas, Size size) {
    final nodePaint = Paint()..color = const Color(0xFF56F3D6);
    final linePaint = Paint()..strokeWidth = 0.5;
    final textStyle = const TextStyle(
      color: Colors.white70,
      fontSize: 10,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.2,
    );

    for (int i = 0; i < nodes.length; i++) {
      final n1 = nodes[i];
      final p1 = Offset(n1.x * size.width, n1.y * size.height);

      // Draw Connections
      for (int j = i + 1; j < nodes.length; j++) {
        final n2 = nodes[j];
        final p2 = Offset(n2.x * size.width, n2.y * size.height);
        final distance = (p1 - p2).distance;

        if (distance < 180) {
          final opacity = (1.0 - (distance / 180)).clamp(0.0, 0.2);
          linePaint.color = const Color(0xFF56F3D6).withValues(alpha: opacity);
          canvas.drawLine(p1, p2, linePaint);
        }
      }

      // Mouse interaction
      final mouseDistance = (p1 - mousePosition).distance;
      final double hoverScale = mouseDistance < 150 ? (1.0 - (mouseDistance / 150)) : 0;

      // Draw Node
      nodePaint.color = const Color(0xFF56F3D6).withValues(alpha: 0.4 + (hoverScale * 0.6));
      canvas.drawCircle(p1, n1.size * (1.0 + hoverScale), nodePaint);
      
      // Draw Label
      if (hoverScale > 0.2) {
        final textPainter = TextPainter(
          text: TextSpan(text: n1.name, style: textStyle.copyWith(
            color: Colors.white.withValues(alpha: hoverScale),
            fontSize: 10 + (hoverScale * 4),
          )),
          textDirection: TextDirection.ltr,
        )..layout();
        textPainter.paint(canvas, p1 + const Offset(10, -20));
      }
    }
  }

  @override
  bool shouldRepaint(covariant _ConstellationPainter oldDelegate) => true;
}
