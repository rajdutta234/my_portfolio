import 'package:flutter/material.dart';

import '../../core/constants/portfolio_data.dart';
import '../common/glass_container.dart';
import '../common/reveal_on_scroll.dart';
import '../common/section_title.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1120),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: RevealOnScroll(
          child: GlassContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SectionTitle(
                  title: 'About Me',
                  subtitle: 'Who I am and how I build',
                ),
                const SizedBox(height: 22),
                Text(
                  aboutText,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white70,
                        height: 1.8,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.2,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
