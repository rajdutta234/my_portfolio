import 'package:flutter/material.dart';

class Magnetic extends StatefulWidget {
  const Magnetic({super.key, required this.child, this.range = 100});

  final Widget child;
  final double range;

  @override
  State<Magnetic> createState() => _MagneticState();
}

class _MagneticState extends State<Magnetic> {
  Offset _offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        final RenderBox box = context.findRenderObject() as RenderBox;
        final Offset center = box.size.center(Offset.zero);
        final Offset local = event.localPosition;
        
        final double dx = (local.dx - center.dx);
        final double dy = (local.dy - center.dy);
        
        final double dist = Offset(dx, dy).distance;
        if (dist < widget.range) {
          setState(() {
            _offset = Offset(dx * 0.3, dy * 0.3);
          });
        } else {
          setState(() {
            _offset = Offset.zero;
          });
        }
      },
      onExit: (_) => setState(() => _offset = Offset.zero),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(_offset.dx, _offset.dy, 0),
        child: widget.child,
      ),
    );
  }
}
