import 'package:flutter/material.dart';

class HoverScale extends StatefulWidget {
  const HoverScale({
    super.key,
    required this.child,
    this.onTap,
  });

  final Widget child;
  final VoidCallback? onTap;

  @override
  State<HoverScale> createState() => _HoverScaleState();
}

class _HoverScaleState extends State<HoverScale> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 240),
        curve: Curves.easeOutCubic,
        scale: _isHovered ? 1.03 : 1,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 240),
          opacity: _isHovered ? 0.95 : 1,
          child: GestureDetector(
            onTap: widget.onTap,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
