import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedReveal extends StatelessWidget {
  const AnimatedReveal({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 600),
    this.offset = const Offset(0, 30),
  });

  final Widget child;
  final Duration delay;
  final Duration duration;
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    return child
        .animate()
        .fadeIn(delay: delay, duration: duration, curve: Curves.easeOutCubic)
        .move(
          begin: offset,
          end: Offset.zero,
          delay: delay,
          duration: duration,
          curve: Curves.easeOutCubic,
        );
  }
}
