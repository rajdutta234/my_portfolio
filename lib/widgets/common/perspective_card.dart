import 'dart:math' as math;
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
    with TickerProviderStateMixin {
  final ValueNotifier<Offset> _tilt = ValueNotifier<Offset>(Offset.zero);
  late AnimationController _controller;
  late AnimationController _autoController;
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
      _tilt.value = _animation.value;
    });

    _autoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (MediaQuery.sizeOf(context).width < 800) {
        _autoController.repeat(reverse: true);
        _autoController.addListener(() {
          if (!_controller.isAnimating) {
            _tilt.value = Offset(
              math.sin(_autoController.value * math.pi * 2) * 0.2,
              math.cos(_autoController.value * math.pi * 2) * 0.2,
            );
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _autoController.dispose();
    _tilt.dispose();
    super.dispose();
  }

  void _onHover(PointerEvent event) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset center = box.size.center(Offset.zero);
    final Offset local = event.localPosition;

    _tilt.value = Offset(
      (local.dy - center.dy) / center.dy,
      -(local.dx - center.dx) / center.dx,
    );
  }

  void _onExit(PointerEvent event) {
    _animation = Tween<Offset>(
      begin: _tilt.value,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: _onHover,
      onExit: _onExit,
      child: ValueListenableBuilder<Offset>(
        valueListenable: _tilt,
        builder: (context, tilt, child) {
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, widget.perspective)
              ..rotateX(tilt.dx * widget.maxTilt)
              ..rotateY(tilt.dy * widget.maxTilt),
            alignment: FractionalOffset.center,
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}
