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
    final Size size = MediaQuery.sizeOf(context);
    final double dx = (mousePosition.dx - size.width / 2) * speed;
    final double dy = (mousePosition.dy - size.height / 2) * speed;

    return Transform(
      transform: Matrix4.identity()..setTranslationRaw(dx, dy, 0),
      child: child,
    );
  }
}
