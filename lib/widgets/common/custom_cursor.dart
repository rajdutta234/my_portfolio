import 'dart:ui' show lerpDouble;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/portfolio_provider.dart';

class CustomCursor extends ConsumerStatefulWidget {
  const CustomCursor({super.key, required this.child});
  final Widget child;

  @override
  ConsumerState<CustomCursor> createState() => _CustomCursorState();
}

class _CustomCursorState extends ConsumerState<CustomCursor> with TickerProviderStateMixin {
  Offset _pointerPosition = Offset.zero;
  Offset _trailPosition = Offset.zero;
  bool _isVisible = false;

  late final AnimationController _hoverController;
  late final Animation<double> _hoverAnimation;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _hoverAnimation = CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOutBack,
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.sizeOf(context).width > 1024;
    if (!isDesktop) return widget.child;

    final bool isHovering = ref.watch(cursorHoverProvider);
    if (isHovering) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }

    return MouseRegion(
      opaque: false,
      cursor: SystemMouseCursors.none,
      onHover: (event) {
        setState(() {
          _pointerPosition = event.position;
          _isVisible = true;
        });
        // Smooth lerp for the trail
        Future.delayed(const Duration(milliseconds: 50), () {
          if (mounted) {
            setState(() {
              _trailPosition = Offset(
                lerpDouble(_trailPosition.dx, _pointerPosition.dx, 0.2)!,
                lerpDouble(_trailPosition.dy, _pointerPosition.dy, 0.2)!,
              );
            });
          }
        });
      },
      onExit: (_) => setState(() => _isVisible = false),
      child: Stack(
        children: [
          widget.child,
          if (_isVisible)
            Positioned.fill(
              child: IgnorePointer(
                child: AnimatedBuilder(
                  animation: _hoverAnimation,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: _CursorPainter(
                        pointerPosition: _pointerPosition,
                        trailPosition: _trailPosition,
                        hoverProgress: _hoverAnimation.value,
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _CursorPainter extends CustomPainter {
  _CursorPainter({
    required this.pointerPosition,
    required this.trailPosition,
    required this.hoverProgress,
  });

  final Offset pointerPosition;
  final Offset trailPosition;
  final double hoverProgress;

  @override
  void paint(Canvas canvas, Size size) {
    final Color primaryColor = const Color(0xFF56F3D6);
    final Color secondaryColor = const Color(0xFF00C2FF);

    // 1. Outer Trailing Glow (Soft)
    final Paint trailPaint = Paint()
      ..color = primaryColor.withValues(alpha: 0.15)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);
    
    canvas.drawCircle(trailPosition, 30 + (20 * hoverProgress), trailPaint);

    // 2. Liquid Border (Reactive)
    final Paint borderPaint = Paint()
      ..color = primaryColor.withValues(alpha: 0.5 + (0.5 * hoverProgress))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5 - (0.5 * hoverProgress);
    
    canvas.drawCircle(
      pointerPosition, 
      15 + (25 * hoverProgress), 
      borderPaint
    );

    // 3. Central Core Dot
    final Paint corePaint = Paint()
      ..color = Colors.white
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 2 * (1 - hoverProgress));
    
    canvas.drawCircle(pointerPosition, 4 * (1 - hoverProgress), corePaint);

    // 4. Secondary Pulse (On Hover)
    if (hoverProgress > 0) {
      final Paint pulsePaint = Paint()
        ..color = secondaryColor.withValues(alpha: 0.1 * (1 - hoverProgress))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      
      canvas.drawCircle(pointerPosition, 15 + (60 * hoverProgress), pulsePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _CursorPainter oldDelegate) => true;
}
