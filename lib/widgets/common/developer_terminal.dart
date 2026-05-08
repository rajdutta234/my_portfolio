import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DeveloperTerminal extends StatelessWidget {
  const DeveloperTerminal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 450),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF020C1B).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF56F3D6).withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF56F3D6).withValues(alpha: 0.05),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Terminal Header
          Row(
            children: [
              _buildCircle(Colors.redAccent),
              const SizedBox(width: 6),
              _buildCircle(Colors.amberAccent),
              const SizedBox(width: 6),
              _buildCircle(Colors.greenAccent),
              const SizedBox(width: 12),
              Text(
                'bash — 80x24',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 10,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Terminal Content
          DefaultTextStyle(
            style: const TextStyle(
              color: Color(0xFF56F3D6),
              fontSize: 13,
              fontFamily: 'monospace',
              height: 1.5,
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  '> whoami\nRaj Dutta\n\n> skills\nFlutter | Dart | Flask | FastAPI\n\n> status\nEngineering the future...\n\n> projects\n9+ Production Apps deployed',
                  speed: const Duration(milliseconds: 40),
                ),
              ],
              totalRepeatCount: 1,
              displayFullTextOnTap: true,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 1.5.seconds).scale(begin: const Offset(0.95, 0.95));
  }

  Widget _buildCircle(Color color) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.5),
        shape: BoxShape.circle,
      ),
    );
  }
}
