import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import './particle_field.dart';
import '../../routes/app_routes.dart';

class CinematicLoader extends StatefulWidget {
  const CinematicLoader({super.key});

  @override
  State<CinematicLoader> createState() => _CinematicLoaderState();
}

class _CinematicLoaderState extends State<CinematicLoader> {
  bool _isFinished = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    
    return Scaffold(
      backgroundColor: const Color(0xFF021414),
      body: Stack(
        children: [
          // Background Particles
          ParticleField(
            width: size.width,
            height: size.height,
            numberOfParticles: 100,
            particleColor: const Color(0xFF56F3D6),
          ),

          // Central Terminal Loading
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Digital Orbit
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF56F3D6).withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF56F3D6),
                      strokeWidth: 1,
                    ),
                  ),
                )
                .animate(onPlay: (controller) => controller.repeat())
                .rotate(duration: 3.seconds),

                const SizedBox(height: 60),

                // Sequential Loading Text
                SizedBox(
                  height: 100,
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'monospace',
                      color: Color(0xFF56F3D6),
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.bold,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'INITIALIZING SYSTEM...',
                          speed: const Duration(milliseconds: 60),
                        ),
                        TypewriterAnimatedText(
                          'LOADING INTERFACE...',
                          speed: const Duration(milliseconds: 60),
                        ),
                        TypewriterAnimatedText(
                          'CONNECTING MODULES...',
                          speed: const Duration(milliseconds: 60),
                        ),
                        TypewriterAnimatedText(
                          'RENDERING EXPERIENCE...',
                          speed: const Duration(milliseconds: 60),
                        ),
                        TypewriterAnimatedText(
                          'WELCOME RAJ DUTTA',
                          speed: const Duration(milliseconds: 80),
                        ),
                      ],
                      totalRepeatCount: 1,
                      onFinished: () {
                        setState(() => _isFinished = true);
                        Future.delayed(1.seconds, () {
                          if (!context.mounted) return;
                          Navigator.of(context).pushReplacementNamed(AppRoutes.portfolio);
                        });
                      },
                    ),
                  ),
                ),

                // Progress Indicator
                if (!_isFinished)
                  Container(
                    width: 300,
                    height: 4,
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
                  .fadeIn(delay: 500.ms)
                  .shimmer(duration: 2.seconds, color: Colors.white24),
              ],
            ),
          ),

          // Glowing Borders
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF56F3D6).withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
