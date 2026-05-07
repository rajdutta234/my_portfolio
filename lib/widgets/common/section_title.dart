import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Layered 3D Heading
        Stack(
          clipBehavior: Clip.none,
          children: [
            // Shadow Layer for depth
            Positioned(
              top: 2,
              left: 2,
              child: Text(
                title.toUpperCase(),
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                  color: Colors.white10,
                  height: 1.1,
                ),
              ),
            ),
            // Main Heading
            Text(
              title.toUpperCase(),
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w900,
                letterSpacing: 2,
                height: 1.1,
                foreground: Paint()
                  ..shader = const LinearGradient(
                    colors: [
                      Color(0xFFFFFFFF),
                      Color(0xFF56F3D6),
                    ],
                  ).createShader(Rect.fromLTWH(0, 0, 400, 70)),
              ),
            ),
          ],
        ).animate().fadeIn(duration: 600.ms).moveX(begin: -20, end: 0),
        
        const SizedBox(height: 12),
        
        // 3D Accent Line
        Row(
          children: [
            Container(
              height: 4,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF56F3D6),
                    Colors.transparent,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF56F3D6).withValues(alpha: 0.3),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Container(
              height: 4,
              width: 12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: Colors.white24,
              ),
            ),
          ],
        ).animate().scaleX(delay: 200.ms, duration: 400.ms, alignment: Alignment.centerLeft),
        
        const SizedBox(height: 20),
        
        // Subtitle
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Text(
            subtitle,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 16,
              height: 1.5,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.2,
            ),
          ),
        ).animate().fadeIn(delay: 400.ms).moveY(begin: 10, end: 0),
      ],
    );
  }
}
