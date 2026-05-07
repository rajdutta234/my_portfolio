import 'package:flutter/material.dart';

class PerspectiveCard extends StatefulWidget {
  const PerspectiveCard({
    super.key,
    required this.child,
    this.maxTilt = 0.1,
    this.perspective = 0.001,
  });

  final Widget child;
  final double maxTilt;
  final double perspective;

  @override
  State<PerspectiveCard> createState() => _PerspectiveCardState();
}

class _PerspectiveCardState extends State<PerspectiveCard>
    with SingleTickerProviderStateMixin {
  Offset _tilt = Offset.zero;
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.addListener(() {
      setState(() {
        _tilt = _animation.value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(PointerEvent event) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset center = box.size.center(Offset.zero);
    final Offset local = event.localPosition;

    setState(() {
      _tilt = Offset(
        (local.dy - center.dy) / center.dy,
        -(local.dx - center.dx) / center.dx,
      );
    });
  }

  void _onExit(PointerEvent event) {
    _animation = Tween<Offset>(
      begin: _tilt,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: _onHover,
      onExit: _onExit,
      child: Transform(
        transform:
            Matrix4.identity()
              ..setEntry(3, 2, widget.perspective)
              ..rotateX(_tilt.dx * widget.maxTilt)
              ..rotateY(_tilt.dy * widget.maxTilt),
        alignment: FractionalOffset.center,
        child: widget.child,
      ),
    );
  }
}
