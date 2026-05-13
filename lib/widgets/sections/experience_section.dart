import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../core/constants/portfolio_data.dart';
import '../../core/responsive.dart';
import '../../models/experience.dart';
import '../common/section_title.dart';
import '../common/reveal_on_scroll.dart';
import '../common/perspective_card.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1100),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const RevealOnScroll(
                child: SectionTitle(
                  title: 'Career Odyssey',
                  subtitle: 'A chronological log of engineering impact and professional growth.',
                ),
              ),
              const SizedBox(height: 80),
              Column(
                children: List.generate(experiences.length, (index) {
                  return _TimelineItem(
                    experience: experiences[index],
                    isLast: index == experiences.length - 1,
                    index: index,
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({
    required this.experience,
    required this.isLast,
    required this.index,
  });

  final Experience experience;
  final bool isLast;
  final int index;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    return Stack(
      children: [
        // Cinematic Glowing Path
        if (!isLast)
          Positioned(
            left: isMobile ? 11 : 14,
            top: 40,
            bottom: 0,
            child: Container(
              width: 3,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF56F3D6),
                    const Color(0xFF00C2FF).withValues(alpha: 0.1),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF56F3D6).withValues(alpha: 0.3),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ).animate().scaleY(
                delay: (index * 200 + 400).ms,
                duration: 800.ms,
                alignment: Alignment.topCenter,
              ),

        Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pulsing Timeline Marker
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: isMobile ? 24 : 30,
                height: isMobile ? 24 : 30,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: isMobile ? 24 : 30,
                      height: isMobile ? 24 : 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF56F3D6).withValues(alpha: 0.2),
                        border: Border.all(color: const Color(0xFF56F3D6), width: 1),
                      ),
                    ).animate(onPlay: (c) => c.repeat(reverse: true))
                    .scale(begin: const Offset(1, 1), end: const Offset(1.3, 1.3), duration: 1.5.seconds),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF56F3D6),
                      ),
                    ),
                  ],
                ),
              ).animate().scale(delay: (index * 200).ms),

              const SizedBox(width: 32),

              // Cinematic Experience Card
              Expanded(
                child: PerspectiveCard(
                  maxTilt: 0.06,
                  child: Stack(
                    children: [
                      GlassmorphicContainer(
                        width: double.infinity,
                        height: isMobile ? 700 : 320,
                        borderRadius: 24,
                        blur: 10,
                        alignment: Alignment.topLeft,
                        border: 1.5,
                        linearGradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFFffffff).withValues(alpha: 0.05),
                            const Color(0xFFffffff).withValues(alpha: 0.02),
                          ],
                        ),
                        borderGradient: LinearGradient(
                          colors: [const Color(0xFF56F3D6).withValues(alpha: 0.4), Colors.transparent],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              isMobile
                                  ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          experience.organization.toUpperCase(),
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          experience.role,
                                          style: const TextStyle(
                                            color: Color(0xFF56F3D6),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 14, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: Colors.white
                                                .withValues(alpha: 0.05),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                                color: Colors.white10),
                                          ),
                                          child: Text(
                                            experience.duration,
                                            style: const TextStyle(
                                                color: Colors.white70,
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                experience.organization
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                  fontSize: isMobile ? 18 : 24,
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.white,
                                                  letterSpacing: 1,
                                                ),
                                              ),
                                              const SizedBox(height: 6),
                                              Text(
                                                experience.role,
                                                style: const TextStyle(
                                                  color: Color(0xFF56F3D6),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  letterSpacing: 0.5,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 14, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: Colors.white
                                                .withValues(alpha: 0.05),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                                color: Colors.white10),
                                          ),
                                          child: Text(
                                            experience.duration,
                                            style: const TextStyle(
                                                color: Colors.white70,
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                              const SizedBox(height: 32),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: experience.description.map((line) => Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Icon(Icons.keyboard_arrow_right_rounded, color: Color(0xFF56F3D6), size: 18),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              line,
                                              style: const TextStyle(color: Colors.white60, fontSize: 14, height: 1.6),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      // Lighting Sweep Effect
                      Positioned.fill(
                        child: IgnorePointer(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ).animate(onPlay: (c) => c.repeat())
                            .shimmer(
                              duration: 4.seconds,
                              color: Colors.white.withValues(alpha: 0.03),
                              angle: 45,
                            ),
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: (index * 200 + 100).ms).slideX(begin: 0.05),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
