import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DeveloperTerminal extends StatelessWidget {
  const DeveloperTerminal({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 500),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF020C1B).withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFF56F3D6).withValues(alpha: 0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF56F3D6).withValues(alpha: 0.1),
                blurRadius: 30,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Terminal Header
              Row(
                children: [
                  _buildCircle(const Color(0xFFFF5F56)),
                  const SizedBox(width: 8),
                  _buildCircle(const Color(0xFFFFBD2E)),
                  const SizedBox(width: 8),
                  _buildCircle(const Color(0xFF27C93F)),
                  const SizedBox(width: 16),
                  Text(
                    'raj@developer: ~/portfolio',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.4),
                      fontSize: 11,
                      fontFamily: 'monospace',
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // Terminal Content
              DefaultTextStyle(
                style: const TextStyle(
                  color: Color(0xFF56F3D6),
                  fontSize: 13,
                  fontFamily: 'monospace',
                  height: 1.6,
                  letterSpacing: 1.1,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      '> whoami\nRAJ DUTTA [SENIOR_ENGINEER]\n\n'
                      '> stack --detailed\nFLUTTER | FASTAPI | FLASK | DJANGO\n\n'
                      '> systems.status\nALL_MODULES: OPERATIONAL [100%]\n\n'
                      '> projects --count\n12+ PRODUCTION_GRADE_SYSTEMS\n\n'
                      '> current_focus\nAI_INTEGRATED_ECOSYSTEMS',
                      speed: const Duration(milliseconds: 30),
                    ),
                  ],
                  totalRepeatCount: 1,
                  displayFullTextOnTap: true,
                ),
              ),
            ],
          ),
        ),

        // Scanline Shader Overlay
        Positioned.fill(
          child: IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: List.generate(20, (index) => 
                    index % 2 == 0 ? Colors.black.withValues(alpha: 0.1) : Colors.transparent
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 1.2.seconds);
  }

  Widget _buildCircle(Color color) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.8),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 4,
          ),
        ],
      ),
    );
  }
}
