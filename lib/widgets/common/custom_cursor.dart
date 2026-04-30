import 'package:flutter/material.dart';

class CustomCursor extends StatefulWidget {
  const CustomCursor({super.key, required this.child});

  final Widget child;

  @override
  State<CustomCursor> createState() => _CustomCursorState();
}

class _CustomCursorState extends State<CustomCursor> {
  Offset _pointerPosition = Offset.zero;
  bool _isHoveringInteractive = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      opaque: false,
      onHover: (event) {
        setState(() {
          _pointerPosition = event.position;
        });
      },
      child: Stack(
        children: [
          widget.child,
          Positioned.fill(
            child: IgnorePointer(
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeOutCubic,
                    left: _pointerPosition.dx - (_isHoveringInteractive ? 20 : 10),
                    top: _pointerPosition.dy - (_isHoveringInteractive ? 20 : 10),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: _isHoveringInteractive ? 40 : 20,
                      height: _isHoveringInteractive ? 40 : 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.15),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.4),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Global state or similar would be needed to detect interactive hover,
// but for now we'll implement a simple version that follows the mouse.
