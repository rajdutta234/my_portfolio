import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/constants/portfolio_data.dart';
import '../common/link_utils.dart';
import '../common/typing_text.dart';
import '../common/parallax_layer.dart';
import '../common/magnetic.dart';

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

                      ParallaxLayer(
                        speed: 0.03,
                        mousePosition: _mousePosition,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: <Color>[
                                const Color(0xFF1E2A3E).withValues(alpha: 0.52),
                                const Color(0xFF0D1829).withValues(alpha: 0.32),
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
                              filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: mobile
                                      ? 20
                                      : tablet
                                      ? 34
                                      : 60,
                                  vertical: mobile
                                      ? 34
                                      : tablet
                                      ? 52
                                      : 80,
                                ),
                                child: LayoutBuilder(
                                  builder:
                                      (
                                        BuildContext context,
                                        BoxConstraints constraints,
                                      ) {
                                        return SingleChildScrollView(
                                          physics:
                                              const ClampingScrollPhysics(),
                                          child: ConstrainedBox(
                                            constraints: BoxConstraints(
                                              minHeight: constraints.maxHeight,
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
                                                    width: mobile
                                                        ? 108
                                                        : tablet
                                                        ? 146
                                                        : 180,
                                                    height: mobile
                                                        ? 108
                                                        : tablet
                                                        ? 146
                                                        : 180,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      boxShadow: <BoxShadow>[
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
                                                                  : tablet
                                                                  ? 146
                                                                  : 180,
                                                              height: mobile
                                                                  ? 108
                                                                  : tablet
                                                                  ? 146
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

                                                        ClipOval(
                                                          child: Image.asset(
                                                            'assets/images/profile.jpg',
                                                            width: mobile
                                                                ? 98
                                                                : tablet
                                                                ? 132
                                                                : 165,
                                                            height: mobile
                                                                ? 98
                                                                : tablet
                                                                ? 132
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

                                                SizedBox(
                                                  height: mobile ? 32 : 48,
                                                ),

                                                Column(
                                                  crossAxisAlignment: mobile
                                                      ? CrossAxisAlignment.start
                                                      : CrossAxisAlignment
                                                            .center,
                                                  children: [
                                                    Text(
                                                          developerName
                                                              .toUpperCase(),
                                                          textAlign: mobile
                                                              ? TextAlign.left
                                                              : TextAlign
                                                                    .center,
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
                                                                    : tablet
                                                                    ? 56
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
                                                          textAlign: mobile
                                                              ? TextAlign.left
                                                              : TextAlign
                                                                    .center,
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

                                                SizedBox(
                                                  height: mobile ? 26 : 32,
                                                ),

                                                const TypingText(
                                                  words: <String>[
                                                    tagline,
                                                    'Architecting the future of web.',
                                                    'Pixels with purpose.',
                                                  ],
                                                ).animate().fadeIn(
                                                  delay: 800.ms,
                                                ),

                                                SizedBox(
                                                  height: mobile ? 34 : 50,
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 0,
                                                        vertical: 8,
                                                      ),
                                                  child: Wrap(
                                                    spacing: 12,
                                                    runSpacing: 12,
                                                    alignment: mobile
                                                        ? WrapAlignment.start
                                                        : WrapAlignment.center,
                                                    children: <Widget>[
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
                                                                  horizontal:
                                                                      34,
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
                                                                  FontWeight
                                                                      .w900,
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
                                                                  horizontal:
                                                                      32,
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
                                                                  FontWeight
                                                                      .w900,
                                                              letterSpacing: 1,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ).animate().fadeIn(delay: 1.seconds).moveY(begin: 30, end: 0),
                                                SizedBox(
                                                  height: mobile ? 20 : 28,
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    _SocialIcon(
                                                      icon: Icons.link,
                                                      url: linkedinUrl,
                                                      label: 'LinkedIn',
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
                                              ],
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
