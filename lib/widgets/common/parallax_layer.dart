import 'package:flutter/material.dart';

class ParallaxLayer extends StatelessWidget {
  const ParallaxLayer({
    super.key,
    required this.child,
    required this.speed,
    required this.mousePosition,
  });

  final Widget child;
  final double speed;
  final Offset mousePosition;

  @override
  Widget build(BuildContext context) {
    final double dx = (mousePosition.dx - MediaQuery.sizeOf(context).width / 2) * speed;
    final double dy = (mousePosition.dy - MediaQuery.sizeOf(context).height / 2) * speed;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOutCubic,
      transform: Matrix4.translationValues(dx, dy, 0),
      child: child,
    );
  }
}
