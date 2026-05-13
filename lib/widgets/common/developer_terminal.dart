import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DeveloperTerminal extends StatelessWidget {
  const DeveloperTerminal({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 480),
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: const Color(0xFF020C1B).withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: const Color(0xFF56F3D6).withValues(alpha: 0.2),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF56F3D6).withValues(alpha: 0.05),
                blurRadius: 40,
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
                  _buildCircle(const Color(0xFFFF5F56)),
                  const SizedBox(width: 10),
                  _buildCircle(const Color(0xFFFFBD2E)),
                  const SizedBox(width: 10),
                  _buildCircle(const Color(0xFF27C93F)),
                  const SizedBox(width: 20),
                  Text(
                    'raj@developer: ~/portfolio',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.3),
                      fontSize: 12,
                      fontFamily: 'monospace',
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Terminal Content with Enhanced Syntax Highlighting
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 14,
                    height: 1.8,
                    letterSpacing: 1.2,
                  ),
                  children: [
                    _buildTerminalLine('> whoami', const Color(0xFF00C2FF)),
                    _buildOutputLine('RAJ DUTTA [SYSTEMS_ENGINEER]'),
                    const TextSpan(text: '\n'),
                    _buildTerminalLine(
                      '> stack --detailed',
                      const Color(0xFF00C2FF),
                    ),
                    _buildOutputLine(
                      'FLUTTER | FASTAPI | FLASK | HTML | CSS | JS ',
                    ),
                    const TextSpan(text: '\n'),
                    _buildTerminalLine(
                      '> systems.status',
                      const Color(0xFF00C2FF),
                    ),
                    _buildOutputLine('ALL_MODULES: OPERATIONAL [100%]'),
                    const TextSpan(text: '\n'),
                    _buildTerminalLine(
                      '> current_focus',
                      const Color(0xFF00C2FF),
                    ),
                    _buildOutputLine('AI_INTEGRATED_ECOSYSTEMS'),
                  ],
                ),
              ).animate().fadeIn(duration: 1.seconds),

              const SizedBox(height: 12),
              // Glowing Cursor
              Container(
                width: 10,
                height: 20,
                decoration: BoxDecoration(
                  color: const Color(0xFF56F3D6),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF56F3D6).withValues(alpha: 0.5),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ).animate(onPlay: (c) => c.repeat()).fadeOut(duration: 500.ms),
            ],
          ),
        ),

        // Cyberpunk Scanline / Noise Overlay
        Positioned.fill(
          child: IgnorePointer(
            child: Opacity(
              opacity: 0.05,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: List.generate(
                      40,
                      (index) =>
                          index % 2 == 0 ? Colors.black : Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 1.2.seconds).moveY(begin: 20);
  }

  TextSpan _buildTerminalLine(String text, Color color) {
    return TextSpan(
      children: [
        TextSpan(
          text: text,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
        const TextSpan(text: '\n'),
      ],
    );
  }

  TextSpan _buildOutputLine(String text) {
    return TextSpan(
      text: text,
      style: const TextStyle(color: Color(0xFF56F3D6)),
    );
  }

  Widget _buildCircle(Color color) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.8),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: 0.3), blurRadius: 4),
        ],
      ),
    );
  }
}
