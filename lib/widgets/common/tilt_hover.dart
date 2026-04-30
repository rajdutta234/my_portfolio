import 'package:flutter/material.dart';

class TiltHover extends StatefulWidget {
  const TiltHover({
    super.key,
    required this.child,
    this.maxTilt = 0.05,
    this.scale = 1.02,
  });

  final Widget child;
  final double maxTilt;
  final double scale;

  @override
  State<TiltHover> createState() => _TiltHoverState();
}

class _TiltHoverState extends State<TiltHover> {
  Offset _mousePosition = Offset.zero;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() {
        _isHovered = true;
        _mousePosition = event.localPosition;
      }),
      onExit: (_) => setState(() {
        _isHovered = false;
        _mousePosition = Offset.zero;
      }),
      onHover: (event) => setState(() => _mousePosition = event.localPosition),
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        tween: Tween<double>(begin: 0, end: _isHovered ? 1 : 0),
        builder: (context, value, child) {
          final size = MediaQuery.sizeOf(context);
          final centerX = size.width / 2;
          final centerY = size.height / 2;
          
          // Calculate tilt based on mouse position relative to center
          // Note: This is a simplified version, usually we'd use the widget's own size
          // but for simplicity and better feel, we'll assume the widget is roughly where the mouse is.
          
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // perspective
              ..scale(1 + (widget.scale - 1) * value)
              ..rotateX(_isHovered ? -(_mousePosition.dy - centerY) * 0.0001 * value : 0)
              ..rotateY(_isHovered ? (_mousePosition.dx - centerX) * 0.0001 * value : 0),
            alignment: FractionalOffset.center,
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}
