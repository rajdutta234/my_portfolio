import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/constants/portfolio_data.dart';
import '../common/link_utils.dart';
import '../common/typing_text.dart';
import '../common/parallax_layer.dart';
import '../common/magnetic.dart';
import '../common/perspective_card.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key, required this.onViewProjects});

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
    final bool tablet = size.width >= 700 && size.width < 1100;
    final double heroHeight = size.height < 760 ? 760 : size.height;

    return MouseRegion(
      onHover: (event) => setState(() => _mousePosition = event.position),
      child: SizedBox(
        height: heroHeight,
        child: Stack(
          children: [
            ParallaxLayer(
              speed: 0.02,
              mousePosition: _mousePosition,
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: const Alignment(-0.8, -0.9),
                      radius: 1.1,
                      colors: <Color>[
                        const Color(0xFF56F3D6).withValues(alpha: 0.12),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ParallaxLayer(
              speed: -0.015,
              mousePosition: _mousePosition,
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: const Alignment(0.95, 0.9),
                      radius: 1.2,
                      colors: <Color>[
                        const Color(0xFF00C2FF).withValues(alpha: 0.1),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1120),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: mobile ? 18 : 36,
                    vertical: 24,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ParallaxLayer(
                        speed: -0.015,
                        mousePosition: _mousePosition,
                        child: Text(
                          'INNOVATE',
                          style: TextStyle(
                            fontSize: mobile
                                ? 72
                                : tablet
                                ? 140
                                : 190,
                            fontWeight: FontWeight.w900,
                            color: const Color(
                              0xFF56F3D6,
                            ).withValues(alpha: 0.06),
                            letterSpacing: mobile ? 10 : 20,
                          ),
                        ),
                      ),

                      // Floating Parallax Particles
                      ...List.generate(6, (index) {
                        final random = (index * 137) % 1000 / 1000;
                        return ParallaxLayer(
                          speed: 0.05 + (random * 0.05),
                          mousePosition: _mousePosition,
                          child: Transform.translate(
                            offset: Offset(
                              (random * 800) - 400,
                              (random * 600) - 300,
                            ),
                            child:
                                Container(
                                      width: 8 + (random * 12),
                                      height: 8 + (random * 12),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: RadialGradient(
                                          colors: [
                                            const Color(
                                              0xFF56F3D6,
                                            ).withValues(alpha: 0.4),
                                            Colors.transparent,
                                          ],
                                        ),
                                        border: Border.all(
                                          color: Colors.white.withValues(
                                            alpha: 0.1,
                                          ),
                                          width: 1,
                                        ),
                                      ),
                                    )
                                    .animate(onPlay: (c) => c.repeat())
                                    .moveY(
                                      begin: -20,
                                      end: 20,
                                      duration: (2000 + random * 2000).ms,
                                      curve: Curves.easeInOut,
                                    ),
                          ),
                        );
                      }),

                      ParallaxLayer(
                        speed: 0.03,
                        mousePosition: _mousePosition,
                        child: PerspectiveCard(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: <Color>[
                                  const Color(
                                    0xFF1E2A3E,
                                  ).withValues(alpha: 0.52),
                                  const Color(
                                    0xFF0D1829,
                                  ).withValues(alpha: 0.32),
                                ],
                              ),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.2),
                                width: 1.5,
                              ),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: const Color(
                                    0xFF56F3D6,
                                  ).withValues(alpha: 0.15),
                                  blurRadius: 40,
                                  spreadRadius: 5,
                                ),
                                BoxShadow(
                                  color: const Color(
                                    0xFF00C2FF,
                                  ).withValues(alpha: 0.08),
                                  blurRadius: 60,
                                  spreadRadius: 8,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 24,
                                  sigmaY: 24,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: mobile ? 20 : 60,
                                    vertical: mobile ? 20 : 40,
                                  ),
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      return Center(
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: ConstrainedBox(
                                            constraints: BoxConstraints(
                                              minHeight: constraints.maxHeight,
                                              maxWidth: constraints.maxWidth,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment: mobile
                                                  ? CrossAxisAlignment.start
                                                  : CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Magnetic(
                                                  child: Container(
                                                    width: mobile ? 108 : 180,
                                                    height: mobile ? 108 : 180,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color:
                                                              const Color(
                                                                0xFF00C2FF,
                                                              ).withValues(
                                                                alpha: 0.24,
                                                              ),
                                                          blurRadius: 50,
                                                          spreadRadius: 10,
                                                        ),
                                                      ],
                                                    ),
                                                    child: Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        Container(
                                                              width: mobile
                                                                  ? 108
                                                                  : 180,
                                                              height: mobile
                                                                  ? 108
                                                                  : 180,
                                                              decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                border: Border.all(
                                                                  color: Colors
                                                                      .white24,
                                                                  width: 1,
                                                                ),
                                                              ),
                                                            )
                                                            .animate(
                                                              onPlay: (c) =>
                                                                  c.repeat(),
                                                            )
                                                            .rotate(
                                                              duration:
                                                                  10.seconds,
                                                            ),
                                                        Container(
                                                              width: mobile
                                                                  ? 104
                                                                  : 172,
                                                              height: mobile
                                                                  ? 104
                                                                  : 172,
                                                              decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                border: Border.all(
                                                                  color:
                                                                      const Color(
                                                                        0xFF56F3D6,
                                                                      ).withValues(
                                                                        alpha:
                                                                            0.4,
                                                                      ),
                                                                  width: 2,
                                                                ),
                                                              ),
                                                            )
                                                            .animate(
                                                              onPlay: (c) =>
                                                                  c.repeat(),
                                                            )
                                                            .rotate(
                                                              duration:
                                                                  4.seconds,
                                                              begin: 1,
                                                              end: 0,
                                                            ),
                                                        ClipOval(
                                                          child: Image.asset(
                                                            'assets/images/profile.jpg',
                                                            width: mobile
                                                                ? 98
                                                                : 165,
                                                            height: mobile
                                                                ? 98
                                                                : 165,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ).animate().scale(
                                                  delay: 200.ms,
                                                  duration: 800.ms,
                                                  curve: Curves.easeOutBack,
                                                ),
                                                const SizedBox(height: 24),
                                                Column(
                                                  crossAxisAlignment: mobile
                                                      ? CrossAxisAlignment.start
                                                      : CrossAxisAlignment
                                                            .center,
                                                  children: [
                                                    Text(
                                                          developerName
                                                              .toUpperCase(),
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .displayMedium
                                                              ?.copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                letterSpacing:
                                                                    -2,
                                                                height: 1.0,
                                                                color: Colors
                                                                    .white,
                                                                fontSize: mobile
                                                                    ? 40
                                                                    : null,
                                                              ),
                                                        )
                                                        .animate()
                                                        .fadeIn(delay: 400.ms)
                                                        .moveY(
                                                          begin: 30,
                                                          end: 0,
                                                          curve: Curves
                                                              .easeOutCubic,
                                                        ),
                                                    const SizedBox(height: 12),
                                                    Text(
                                                          developerTitle,
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .headlineSmall
                                                              ?.copyWith(
                                                                color: Colors
                                                                    .white
                                                                    .withValues(
                                                                      alpha:
                                                                          0.72,
                                                                    ),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                letterSpacing:
                                                                    1.2,
                                                                fontSize: mobile
                                                                    ? 18
                                                                    : null,
                                                              ),
                                                        )
                                                        .animate()
                                                        .fadeIn(delay: 600.ms)
                                                        .moveY(
                                                          begin: 30,
                                                          end: 0,
                                                          curve: Curves
                                                              .easeOutCubic,
                                                        ),
                                                  ],
                                                ),
                                                const SizedBox(height: 20),
                                                const TypingText(
                                                  words: [
                                                    tagline,
                                                    'Architecting the future of web.',
                                                    'Pixels with purpose.',
                                                  ],
                                                ).animate().fadeIn(
                                                  delay: 800.ms,
                                                ),
                                                const SizedBox(height: 28),
                                                Wrap(
                                                  spacing: 12,
                                                  runSpacing: 12,
                                                  alignment: mobile
                                                      ? WrapAlignment.start
                                                      : WrapAlignment.center,
                                                  children: [
                                                    Magnetic(
                                                      child: FilledButton(
                                                        onPressed: widget
                                                            .onViewProjects,
                                                        style: FilledButton.styleFrom(
                                                          backgroundColor:
                                                              const Color(
                                                                0xFF56F3D6,
                                                              ),
                                                          foregroundColor:
                                                              const Color(
                                                                0xFF031313,
                                                              ),
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                horizontal: 34,
                                                                vertical: 20,
                                                              ),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  20,
                                                                ),
                                                          ),
                                                        ),
                                                        child: const Text(
                                                          'EXPLORE WORK',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            letterSpacing: 1,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Magnetic(
                                                      child: OutlinedButton(
                                                        onPressed: () =>
                                                            openExternalLink(
                                                              context,
                                                              resumeUrl,
                                                            ),
                                                        style: OutlinedButton.styleFrom(
                                                          side:
                                                              const BorderSide(
                                                                color: Colors
                                                                    .white24,
                                                                width: 2,
                                                              ),
                                                          foregroundColor:
                                                              Colors.white,
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                horizontal: 32,
                                                                vertical: 20,
                                                              ),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  20,
                                                                ),
                                                          ),
                                                        ),
                                                        child: const Text(
                                                          'RESUME',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            letterSpacing: 1,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ).animate().fadeIn(delay: 1.seconds).moveY(begin: 30, end: 0),
                                                const SizedBox(height: 16),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    _SocialIcon(
                                                      icon: Icons.link,
                                                      url: linkedinUrl,
                                                      label: 'LinkedIn',
                                                    ),
                                                    const SizedBox(width: 14),
                                                    _SocialIcon(
                                                      icon: Icons.facebook,
                                                      url: facebookUrl,
                                                      label: 'Facebook',
                                                    ),
                                                    const SizedBox(width: 14),
                                                    _SocialIcon(
                                                      icon: Icons
                                                          .camera_alt_rounded,
                                                      url: instagramUrl,
                                                      label: 'Instagram',
                                                    ),
                                                    const SizedBox(width: 14),
                                                    _SocialIcon(
                                                      icon: Icons.code,
                                                      url: githubUrl,
                                                      label: 'GitHub',
                                                    ),
                                                  ],
                                                ).animate().fadeIn(
                                                  delay: 1.2.seconds,
                                                ),
                                                const SizedBox(height: 36),
                                                Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                            20,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white
                                                            .withValues(
                                                              alpha: 0.03,
                                                            ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              20,
                                                            ),
                                                        border: Border.all(
                                                          color: Colors.white
                                                              .withValues(
                                                                alpha: 0.08,
                                                              ),
                                                        ),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          _buildStatItem(
                                                            context,
                                                            'PROJECTS',
                                                            projects.length
                                                                .toString(),
                                                            Icons.rocket_launch,
                                                          ),
                                                          Container(
                                                            width: 1,
                                                            height: 30,
                                                            color:
                                                                Colors.white12,
                                                          ),
                                                          _buildStatItem(
                                                            context,
                                                            'EXP',
                                                            '1+ YRS',
                                                            Icons.timeline,
                                                          ),
                                                          Container(
                                                            width: 1,
                                                            height: 30,
                                                            color:
                                                                Colors.white12,
                                                          ),
                                                          _buildStatItem(
                                                            context,
                                                            'AWARDS',
                                                            certificates.length
                                                                .toString(),
                                                            Icons.emoji_events,
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                    .animate()
                                                    .fadeIn(delay: 1.4.seconds)
                                                    .moveY(begin: 20, end: 0),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
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

  Widget _buildStatItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: const Color(0xFF56F3D6), size: 18),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 16,
            letterSpacing: 1,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.4),
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}

class _SocialIcon extends StatelessWidget {
  const _SocialIcon({
    required this.icon,
    required this.url,
    required this.label,
  });
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
              color: const Color(0xFF0D1829).withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white24),
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
        ),
      ),
    );
  }
}
