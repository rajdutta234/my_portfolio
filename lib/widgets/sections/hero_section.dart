import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/constants/portfolio_data.dart';
import '../common/glass_container.dart';
import '../common/link_utils.dart';
import '../common/typing_text.dart';
import '../common/video_background.dart';

import '../common/parallax_layer.dart';
import '../common/magnetic.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({
    super.key,
    required this.onViewProjects,
  });

  final VoidCallback onViewProjects;

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  Offset _mousePosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final bool mobile = size.width < 700;

    return MouseRegion(
      onHover: (event) => setState(() => _mousePosition = event.position),
      child: SizedBox(
        height: size.height,
        child: Stack(
          children: [
            // Background Layer (Parallax)
            ParallaxLayer(
              speed: 0.02,
              mousePosition: _mousePosition,
              child: const VideoBackground(
                assetPath: 'assets/videos/tech_video.mp4',
                opacity: 0.1,
              ),
            ),
            
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1120),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: mobile ? 20 : 36,
                    vertical: 24,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Mid Layer: Large decorative text or shapes
                      ParallaxLayer(
                        speed: -0.015,
                        mousePosition: _mousePosition,
                        child: Text(
                          'INNOVATE',
                          style: TextStyle(
                            fontSize: mobile ? 100 : 200,
                            fontWeight: FontWeight.w900,
                            color: Colors.white.withValues(alpha: 0.02),
                            letterSpacing: 20,
                          ),
                        ),
                      ),

                      // Foreground Layer: Main Content
                      ParallaxLayer(
                        speed: 0.03,
                        mousePosition: _mousePosition,
                        child: GlassContainer(
                          borderRadius: 40,
                          padding: EdgeInsets.symmetric(
                            horizontal: mobile ? 22 : 60,
                            vertical: mobile ? 40 : 80,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: mobile
                                  ? CrossAxisAlignment.start
                                  : CrossAxisAlignment.center,
                            children: <Widget>[
                              // Animated Profile Image with Floating Effect
                              Magnetic(
                                child: Container(
                                  width: mobile ? 120 : 180,
                                  height: mobile ? 120 : 180,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.blue.withValues(alpha: 0.2),
                                        blurRadius: 50,
                                        spreadRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        width: mobile ? 120 : 180,
                                        height: mobile ? 120 : 180,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.white12,
                                            width: 1,
                                          ),
                                        ),
                                      ).animate(onPlay: (c) => c.repeat()).rotate(duration: 10.seconds),
                                      
                                      ClipOval(
                                        child: Image.asset(
                                          'assets/images/profile.jpg',
                                          width: mobile ? 110 : 165,
                                          height: mobile ? 110 : 165,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ).animate().scale(delay: 200.ms, duration: 800.ms, curve: Curves.easeOutBack),
                              
                              const SizedBox(height: 48),
                              
                              // Staggered Text Reveal
                              Column(
                                crossAxisAlignment: mobile ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    developerName.toUpperCase(),
                                    textAlign: mobile ? TextAlign.left : TextAlign.center,
                                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: -2,
                                          height: 1.0,
                                          color: Colors.white,
                                        ),
                                  ).animate().fadeIn(delay: 400.ms).moveY(begin: 30, end: 0, curve: Curves.easeOutCubic),
                                  
                                  const SizedBox(height: 12),
                                  
                                  Text(
                                    developerTitle,
                                    textAlign: mobile ? TextAlign.left : TextAlign.center,
                                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                          color: Colors.white.withValues(alpha: 0.6),
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 2,
                                        ),
                                  ).animate().fadeIn(delay: 600.ms).moveY(begin: 30, end: 0, curve: Curves.easeOutCubic),
                                ],
                              ),
                              
                              const SizedBox(height: 32),
                              
                              const TypingText(
                                words: <String>[
                                  tagline,
                                  'Architecting the future of web.',
                                  'Pixels with purpose.',
                                ],
                              ).animate().fadeIn(delay: 800.ms),
                              
                              const SizedBox(height: 50),
                              
                              // Magnetic Buttons
                              Wrap(
                                spacing: 20,
                                runSpacing: 20,
                                alignment: mobile ? WrapAlignment.start : WrapAlignment.center,
                                children: <Widget>[
                                  Magnetic(
                                    child: FilledButton(
                                      onPressed: widget.onViewProjects,
                                      style: FilledButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                        padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 24),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                      ),
                                      child: const Text('EXPLORE WORK', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1)),
                                    ),
                                  ),
                                  Magnetic(
                                    child: OutlinedButton(
                                      onPressed: () => openExternalLink(context, resumeUrl),
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(color: Colors.white24, width: 2),
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 24),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                      ),
                                      child: const Text('RESUME', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1)),
                                    ),
                                  ),
                                ],
                              ).animate().fadeIn(delay: 1.seconds).moveY(begin: 30, end: 0),
                              
                              const SizedBox(height: 40),
                              
                              // Social Icons with Magnetic feel
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _SocialIcon(icon: Icons.link, url: linkedinUrl, label: 'LinkedIn'),
                                  const SizedBox(width: 24),
                                  _SocialIcon(icon: Icons.code, url: githubUrl, label: 'GitHub'),
                                ],
                              ).animate().fadeIn(delay: 1.2.seconds),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  const _SocialIcon({required this.icon, required this.url, required this.label});
  final IconData icon;
  final String url;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Magnetic(
      range: 60,
      child: Tooltip(
        message: label,
        child: InkWell(
          onTap: () => openExternalLink(context, url),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white12),
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
        ),
      ),
    );
  }
}
