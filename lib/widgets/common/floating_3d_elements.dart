import 'dart:math' as math;
import 'package:flutter/material.dart';

class Floating3DElements extends StatefulWidget {
  const Floating3DElements({super.key});

  @override
  State<Floating3DElements> createState() => _Floating3DElementsState();
}

class _Floating3DElementsState extends State<Floating3DElements> with SingleTickerProviderStateMixin {
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
        return Stack(
          children: List.generate(8, (index) => _buildFloatingShape(index)),
        );
      },
    );
  }

  Widget _buildFloatingShape(int index) {
    final double t = (_controller.value + index / 8) % 1.0;
    final double opacity = 0.05 + math.sin(t * math.pi) * 0.05;
    
    // 3D Path
    final double x = math.sin(t * math.pi * 2 + index) * 200 + (index * 150);
    final double y = math.cos(t * math.pi * 2 + index * 0.5) * 300 + (index * 100);
    final double z = math.sin(t * math.pi) * 100;

    return Positioned(
      left: x % MediaQuery.of(context).size.width,
      top: y % MediaQuery.of(context).size.height,
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..multiply(Matrix4.translationValues(0.0, 0.0, z))
          ..rotateX(t * math.pi)
          ..rotateY(t * math.pi * 0.5),
        alignment: Alignment.center,
        child: Container(
          width: 60 + index * 10,
          height: 60 + index * 10,
          decoration: BoxDecoration(
            border: Border.all(
              color: index % 2 == 0 ? const Color(0xFF56F3D6) : const Color(0xFF00C2FF),
              width: 0.5,
            ),
            color: (index % 2 == 0 ? const Color(0xFF56F3D6) : const Color(0xFF00C2FF)).withValues(alpha: opacity),
          ),
        ),
      ),
    );
  }
}
