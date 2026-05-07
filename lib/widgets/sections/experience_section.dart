import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/constants/portfolio_data.dart';
import '../../models/experience.dart';
import '../common/glass_container.dart';
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
                  title: 'Experience',
                  subtitle: 'Internships and practical product development',
                ),
              ),
              const SizedBox(height: 60),
              // Using a standard Column instead of ListView.builder for transparency in layout
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
    final bool mobile = MediaQuery.sizeOf(context).width < 760;

    return Stack(
      children: [
        // Timeline Connector Line
        if (!isLast)
          Positioned(
            left: mobile ? 6 : 8,
            top: 24,
            bottom: 0,
            child: Container(
              width: 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF56F3D6),
                    const Color(0xFF56F3D6).withValues(alpha: 0.1),
                  ],
                ),
              ),
            ),
          ).animate().scaleY(
                delay: (index * 150 + 400).ms,
                duration: 600.ms,
                alignment: Alignment.topCenter,
              ),

        Padding(
          padding: EdgeInsets.only(bottom: mobile ? 32 : 50),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timeline Dot
              Container(
                margin: const EdgeInsets.only(top: 6),
                width: mobile ? 14 : 18,
                height: mobile ? 14 : 18,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF56F3D6),
                  border: Border.all(color: const Color(0xFF0D1829), width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF56F3D6).withValues(alpha: 0.5),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ).animate().scale(delay: (index * 150).ms, duration: 400.ms),

              const SizedBox(width: 24),

              // Content Card
              Expanded(
                child: PerspectiveCard(
                  maxTilt: 0.05,
                  child: GlassContainer(
                    padding: EdgeInsets.all(mobile ? 20 : 32),
                    borderRadius: 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Organization & Duration
                        Wrap(
                          spacing: 12,
                          runSpacing: 10,
                          alignment: WrapAlignment.spaceBetween,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              experience.organization,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: -0.5,
                                    fontSize: mobile ? 18 : 22,
                                  ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF0D1829).withValues(alpha: 0.8),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: const Color(0xFF56F3D6).withValues(alpha: 0.2)),
                              ),
                              child: Text(
                                experience.duration,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF56F3D6),
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Role
                        Text(
                          experience.role,
                          style: TextStyle(
                            color: const Color(0xFF56F3D6).withValues(alpha: 0.9),
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Description Bullets
                        ...experience.description.map(
                          (line) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Container(
                                    width: 6,
                                    height: 6,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF56F3D6),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    line,
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.75),
                                      height: 1.6,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ).animate().fadeIn(delay: (index * 150 + 100).ms).moveX(begin: 30, end: 0),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
