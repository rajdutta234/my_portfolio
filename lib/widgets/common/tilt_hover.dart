import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as v;


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
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      key: _key,
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
          double dx = 0;
          double dy = 0;

          if (_isHovered) {
            final RenderBox? box = _key.currentContext?.findRenderObject() as RenderBox?;
            if (box != null) {
              final size = box.size;
              dx = (_mousePosition.dx - size.width / 2) / (size.width / 2);
              dy = (_mousePosition.dy - size.height / 2) / (size.height / 2);
            }
          }

          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0012) // perspective
              ..rotateX(-dy * widget.maxTilt * value)
              ..rotateY(dx * widget.maxTilt * value)
              ..scaleByVector3(v.Vector3(1 + (widget.scale - 1) * value, 1 + (widget.scale - 1) * value, 1.0)),



            alignment: FractionalOffset.center,
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}
