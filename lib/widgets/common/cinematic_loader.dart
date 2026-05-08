import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import './particle_field.dart';
import '../../screens/portfolio_page.dart';

class CinematicLoader extends StatefulWidget {
  const CinematicLoader({super.key});

  @override
  State<CinematicLoader> createState() => _CinematicLoaderState();
}

class _CinematicLoaderState extends State<CinematicLoader> {
  bool _isFinished = false;
  bool _showFinalText = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    
    return Scaffold(
      backgroundColor: const Color(0xFF020C1B),
      body: Stack(
        children: [
          // Background Neural Particles
          ParticleField(
            width: size.width,
            height: size.height,
            numberOfParticles: 80,
            particleColor: const Color(0xFF56F3D6),
          ),

          // Scanline Overlay
          Positioned.fill(
            child: Opacity(
              opacity: 0.05,
              child: Column(
                children: List.generate(
                  (size.height / 4).floor(),
                  (index) => Container(
                    height: 2,
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: 2),
                  ),
                ),
              ),
            ),
          ),

          // Central Terminal Loading
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Digital Orbit with Glitch
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF56F3D6).withValues(alpha: 0.3),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF56F3D6).withValues(alpha: 0.1),
                        blurRadius: 40,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(
                        Icons.terminal_rounded,
                        color: Color(0xFF56F3D6),
                        size: 50,
                      ),
                      CircularProgressIndicator(
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF56F3D6)),
                        strokeWidth: 1,
                      ).animate(onPlay: (c) => c.repeat()).rotate(duration: 3.seconds),
                    ],
                  ),
                )
                .animate(onPlay: (c) => c.repeat())
                .shimmer(duration: 2.seconds, color: const Color(0xFF00C2FF).withValues(alpha: 0.3))
                .shake(hz: 1, curve: Curves.easeInOut),

                const SizedBox(height: 60),

                // Multi-line Boot Logs
                SizedBox(
                  height: 160,
                  width: 500,
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontFamily: 'monospace',
                      color: Color(0xFF56F3D6),
                      height: 1.6,
                      letterSpacing: 1.2,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          '> SYSTEM_CORE_BOOT: v4.0.1\n'
                          '> INITIALIZING QUANTUM_INTERFACE...\n'
                          '> LOADING ASSETS [████████░░] 84%\n'
                          '> API_GATEWAY: CONNECTED_SSL_SECURE\n'
                          '> SYNCING NEURAL_DATA_MODELS...\n'
                          '> OPTIMIZING SHADER_PIPELINE...\n'
                          '> HANDSHAKE: RAJ_DUTTA_AUTHORIZED',
                          speed: const Duration(milliseconds: 20),
                        ),
                      ],
                      totalRepeatCount: 1,
                      onFinished: () {
                        setState(() => _showFinalText = true);
                        Future.delayed(800.ms, () {
                          setState(() => _isFinished = true);
                          Future.delayed(1.seconds, () {
                            if (!context.mounted) return;
                            Navigator.of(context).pushReplacement(
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => const PortfolioPage(),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  return FadeTransition(opacity: animation, child: child);
                                },
                                transitionDuration: 1500.ms,
                              ),
                            );
                          });
                        });
                      },
                    ),
                  ),
                ),

                // Success Message
                if (_showFinalText)
                  const Text(
                    'SYSTEM READY. ENTERING INTERFACE...',
                    style: TextStyle(
                      color: Color(0xFF00C2FF),
                      fontFamily: 'monospace',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ).animate().fadeIn().shimmer(duration: 1.seconds),

                const SizedBox(height: 20),

                // Progress Indicator
                if (!_isFinished)
                  Container(
                    width: 300,
                    height: 2,
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: const LinearProgressIndicator(
                        backgroundColor: Colors.transparent,
                        color: Color(0xFF56F3D6),
                      ),
                    ),
                  )
                  .animate()
                  .fadeIn(delay: 500.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
