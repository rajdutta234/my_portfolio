import 'package:flutter/material.dart';

import '../../core/constants/portfolio_data.dart';
import '../../models/skill.dart';
import '../common/glass_container.dart';
import '../common/reveal_on_scroll.dart';
import '../common/section_title.dart';

import 'package:flutter_animate/flutter_animate.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool mobile = MediaQuery.sizeOf(context).width < 820;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1120),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const RevealOnScroll(
              child: SectionTitle(
                title: 'Skills',
                subtitle: 'Frontend, backend, and data expertise',
              ),
            ),
            const SizedBox(height: 24),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: skills.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: mobile ? 1 : 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: mobile ? 1.4 : 0.85,
              ),
              itemBuilder: (BuildContext context, int index) {
                final SkillCategory category = skills[index];
                return _SkillCategoryCard(
                  category: category,
                  index: index,
                ).animate().fadeIn(delay: (index * 150).ms).moveY(begin: 30, end: 0);
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
    return GlassContainer(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  index == 0 ? Icons.web : index == 1 ? Icons.dns : Icons.storage,
                  color: Colors.white70,
                  size: 20,
                ),
              ),
              const SizedBox(width: 14),
              Text(
                category.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ...category.skills.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          '${(item.proficiency * 100).toInt()}%',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.5),
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
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
                                gradient: const LinearGradient(
                                  colors: [Colors.white70, Colors.white],
                                ),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    blurRadius: 10,
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
                                );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
