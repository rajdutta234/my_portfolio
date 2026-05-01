import 'package:flutter/material.dart';

class CustomCursor extends StatefulWidget {
  const CustomCursor({super.key, required this.child});
  final Widget child;

  @override
  State<CustomCursor> createState() => _CustomCursorState();
}

class _CustomCursorState extends State<CustomCursor> {
  Offset _pointerPosition = Offset.zero;
  bool _isVisible = false;
  // Note: _isHoveringInteractive would ideally be managed via a provider or notification
  // to react to buttons. For now, we'll keep it as a placeholder or use a simpler detection.
  final bool _isHoveringInteractive = false;

  @override
  Widget build(BuildContext context) {
    // Hide custom cursor on mobile/touch devices
    final bool isDesktop = MediaQuery.sizeOf(context).width > 1024;
    if (!isDesktop) return widget.child;

    return MouseRegion(
      opaque: false,
      onHover: (event) {
        setState(() {
          _pointerPosition = event.position;
          _isVisible = true;
        });
      },
      onExit: (_) => setState(() => _isVisible = false),
      child: Stack(
        children: [
          widget.child,
          if (_isVisible)
            Positioned.fill(
              child: IgnorePointer(
                child: Stack(
                  children: [
                    // Outer Liquid Ring (Lagging)
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOutBack,
                      left: _pointerPosition.dx - (_isHoveringInteractive ? 40 : 15),
                      top: _pointerPosition.dy - (_isHoveringInteractive ? 40 : 15),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: _isHoveringInteractive ? 80 : 30,
                        height: _isHoveringInteractive ? 80 : 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue.withValues(alpha: 0.05),
                          border: Border.all(
                            color: Colors.blue.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    // Inner Dot (Direct)
                    Positioned(
                      left: _pointerPosition.dx - 4,
                      top: _pointerPosition.dy - 4,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
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
