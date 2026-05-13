import 'package:flutter/material.dart';

class CyberCursor extends StatefulWidget {
  final Widget child;
  const CyberCursor({super.key, required this.child});

  @override
  State<CyberCursor> createState() => _CyberCursorState();
}

class _CyberCursorState extends State<CyberCursor> with SingleTickerProviderStateMixin {
  final ValueNotifier<Offset> _cursorPos = ValueNotifier<Offset>(Offset.zero);
  final ValueNotifier<Offset> _orbPos = ValueNotifier<Offset>(Offset.zero);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        _cursorPos.value = event.position;
        // Smooth lerp for the orb
        _orbPos.value = Offset.lerp(_orbPos.value, event.position, 0.2) ?? event.position;
      },
      child: Stack(
        children: [
          widget.child,
          
          // Outer Glow Orb
          ValueListenableBuilder<Offset>(
            valueListenable: _orbPos,
            builder: (context, pos, _) {
              return Positioned(
                left: pos.dx - 25,
                top: pos.dy - 25,
                child: IgnorePointer(
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFF56F3D6).withValues(alpha: 0.15),
                          const Color(0xFF56F3D6).withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // Inner Sharp Core
          ValueListenableBuilder<Offset>(
            valueListenable: _cursorPos,
            builder: (context, pos, _) {
              return Positioned(
                left: pos.dx - 4,
                top: pos.dy - 4,
                child: IgnorePointer(
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF56F3D6),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF56F3D6),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
