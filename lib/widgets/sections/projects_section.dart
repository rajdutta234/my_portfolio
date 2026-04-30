import 'package:flutter/material.dart';

import '../../core/constants/portfolio_data.dart';
import '../../models/project.dart';
import '../common/glass_container.dart';
import '../common/hover_scale.dart';
import '../common/link_utils.dart';
import '../common/reveal_on_scroll.dart';
import '../common/section_title.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1120),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const RevealOnScroll(
              child: SectionTitle(
                title: 'Projects',
                subtitle: 'Selected work with real-world use cases',
              ),
            ),
            const SizedBox(height: 18),
            ...projects.map(
              (Project project) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: RevealOnScroll(
                  child: HoverScale(
                    child: GlassContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            project.title,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.3,
                                ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            project.description,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.white70,
                                      height: 1.6,
                                      fontWeight: FontWeight.w400,
                                    ),
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: project.stack
                                .map(
                                  (String item) => Chip(
                                    label: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    side:
                                        BorderSide(color: Colors.white.withValues(alpha: 0.25)),
                                    backgroundColor:
                                        Colors.white.withValues(alpha: 0.08),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          const SizedBox(height: 18),
                          Wrap(
                            spacing: 12,
                            runSpacing: 10,
                            children: <Widget>[
                              if (project.githubUrl.isNotEmpty)
                                OutlinedButton.icon(
                                  onPressed: () => openExternalLink(
                                    context,
                                    project.githubUrl,
                                  ),
                                  icon: const Icon(Icons.code, size: 18),
                                  label: const Text(
                                    'GitHub',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      color: Colors.white.withValues(alpha: 0.4),
                                      width: 1.5,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                  ),
                                ),
                              FilledButton.tonalIcon(
                                onPressed: () => openExternalLink(
                                  context,
                                  project.demoUrl,
                                ),
                                icon: const Icon(Icons.open_in_new, size: 18),
                                label: const Text(
                                  'Visit Site',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
