import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../core/constants/portfolio_data.dart';
import '../../models/skill.dart';
import '../common/reveal_on_scroll.dart';
import '../common/section_title.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool mobile = MediaQuery.sizeOf(context).width < 820;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1120),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const RevealOnScroll(
              child: SectionTitle(
                title: 'Expertise',
                subtitle: 'Technological stack & core competencies',
              ),
            ),
            const SizedBox(height: 48),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: skills.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: mobile ? 1 : 3,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: mobile ? 0.6 : 0.78,
              ),
              itemBuilder: (BuildContext context, int index) {
                final SkillCategory category = skills[index];
                return _SkillCategoryCard(
                  category: category,
                  index: index,
                ).animate().fadeIn(delay: (index * 200).ms).scale(begin: const Offset(0.9, 0.9));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillCategoryCard extends StatelessWidget {
  const _SkillCategoryCard({
    required this.category,
    required this.index,
  });

  final SkillCategory category;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: double.infinity,
      borderRadius: 24,
      blur: 20,
      alignment: Alignment.center,
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
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFF56F3D6).withValues(alpha: 0.5),
          const Color(0xFF00C2FF).withValues(alpha: 0.2),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF56F3D6).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    index == 0 ? Icons.code_rounded : index == 1 ? Icons.terminal_rounded : Icons.hub_rounded,
                    color: const Color(0xFF56F3D6),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    category.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                          color: Colors.white,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            ...category.skills.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.name,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Text(
                            '${(item.proficiency * 100).toInt()}%',
                            style: const TextStyle(
                              color: Color(0xFF56F3D6),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Stack(
                        children: [
                          Container(
                            height: 6,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              return Container(
                                height: 6,
                                width: constraints.maxWidth * item.proficiency,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      const Color(0xFF56F3D6),
                                      const Color(0xFF00C2FF).withValues(alpha: 0.8),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF56F3D6).withValues(alpha: 0.3),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                              )
                                  .animate()
                                  .scaleX(
                                    begin: 0,
                                    end: 1,
                                    duration: 1.5.seconds,
                                    curve: Curves.easeOutExpo,
                                    alignment: Alignment.centerLeft,
                                  )
                                  .shimmer(duration: 3.seconds, color: Colors.white24);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
