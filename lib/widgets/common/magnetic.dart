import 'package:flutter/material.dart';

class Magnetic extends StatefulWidget {
  const Magnetic({
    super.key, 
    required this.child, 
    this.range = 100,
    this.strength = 0.3,
  });

  final Widget child;
  final double range;
  final double strength;

  @override
  State<Magnetic> createState() => _MagneticState();
}

class _MagneticState extends State<Magnetic> {
  final ValueNotifier<Offset> _offset = ValueNotifier<Offset>(Offset.zero);

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
          _offset.value = Offset(dx * widget.strength, dy * widget.strength);
        } else {
          _offset.value = Offset.zero;
        }
      },
      onExit: (_) => _offset.value = Offset.zero,
      child: ValueListenableBuilder<Offset>(
        valueListenable: _offset,
        builder: (context, offset, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            transform: Matrix4.translationValues(offset.dx, offset.dy, 0),
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}
