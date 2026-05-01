import 'package:flutter/material.dart';

class GlowInput extends StatefulWidget {
  const GlowInput({super.key, required this.child});
  final Widget child;

  @override
  State<GlowInput> createState() => _GlowInputState();
}

class _GlowInputState extends State<GlowInput> {
  Offset _mousePos = Offset.zero;
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      onHover: (event) => setState(() => _mousePos = event.localPosition),
      child: Stack(
        children: [
          // The Glow
          if (_hovered)
            Positioned(
              left: _mousePos.dx - 100,
              top: _mousePos.dy - 100,
              child: IgnorePointer(
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.blue.withValues(alpha: 0.15),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          widget.child,
        ],
      ),
    );
  }
}
