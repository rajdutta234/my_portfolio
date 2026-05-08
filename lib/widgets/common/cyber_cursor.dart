import 'package:flutter/material.dart';

class CyberCursor extends StatefulWidget {
  final Widget child;
  const CyberCursor({super.key, required this.child});

  @override
  State<CyberCursor> createState() => _CyberCursorState();
}

class _CyberCursorState extends State<CyberCursor> with SingleTickerProviderStateMixin {
  Offset _cursorPos = Offset.zero;
  Offset _orbPos = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          _cursorPos = event.position;
          // Smooth lerp for the orb
          _orbPos = Offset.lerp(_orbPos, _cursorPos, 0.2) ?? _cursorPos;
        });
      },
      child: Stack(
        children: [
          widget.child,
          
          // Outer Glow Orb
          Positioned(
            left: _orbPos.dx - 25,
            top: _orbPos.dy - 25,
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
          ),

          // Inner Sharp Core
          Positioned(
            left: _cursorPos.dx - 4,
            top: _cursorPos.dy - 4,
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
          ),
        ],
      ),
    );
  }
}
