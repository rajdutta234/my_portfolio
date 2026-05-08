import 'package:flutter/material.dart';
import '../common/skills_constellation.dart';

import '../../core/constants/portfolio_data.dart';
import '../common/reveal_on_scroll.dart';
import '../common/section_title.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
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
            SizedBox(
              height: 600,
              width: double.infinity,
              child: SkillsConstellation(
                skills: skills.expand((e) => e.skills.map((s) => s.name)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
