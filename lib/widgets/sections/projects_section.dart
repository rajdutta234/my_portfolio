import 'package:flutter/material.dart';

import '../../core/constants/portfolio_data.dart';
import '../../models/project.dart';
import '../common/glass_container.dart';
import '../common/link_utils.dart';
import '../common/section_title.dart';

import 'package:flutter_animate/flutter_animate.dart';
import '../common/magnetic.dart';

import '../common/perspective_scroll.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool mobile = MediaQuery.sizeOf(context).width < 700;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1200),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SectionTitle(
              title: 'SELECTED PROJECTS',
              subtitle: 'Blending aesthetics with functionality',
            ).animate().fadeIn().moveX(begin: -30, end: 0),
            const SizedBox(height: 60),
            ...projects.asMap().entries.map(
              (entry) {
                final int index = entry.key;
                final Project project = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: PerspectiveScroll(
                    child: _ProjectCard(project: project, index: index, mobile: mobile),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  const _ProjectCard({required this.project, required this.index, required this.mobile});
  final Project project;
  final int index;
  final bool mobile;

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GlassContainer(
        padding: const EdgeInsets.all(0),
        borderRadius: 32,
        child: Column(
          children: [
            // Image with Zoom Effect
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Stack(
                  children: [
                    AnimatedScale(
                      scale: _hovered ? 1.1 : 1.0,
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOutCubic,
                      child: Image.asset(
                        widget.project.imageUrl!,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Gradient Overlay that fades out on hover
                    AnimatedOpacity(
                      opacity: _hovered ? 0.3 : 0.6,
                      duration: const Duration(milliseconds: 400),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Content
            Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.project.title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                          letterSpacing: -1,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.project.description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white60,
                          height: 1.7,
                        ),
                  ),
                  const SizedBox(height: 32),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: widget.project.stack
                        .map((s) => Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.05),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.white12),
                              ),
                              child: Text(s, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 48),
                  Wrap(
                    spacing: 20,
                    runSpacing: 16,
                    children: [
                      SizedBox(
                        width: widget.mobile ? double.infinity : null,
                        child: Magnetic(
                          child: OutlinedButton.icon(
                            onPressed: () => openExternalLink(context, widget.project.githubUrl),
                            icon: const Icon(Icons.code),
                            label: const Text('SOURCE'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 30),
                              side: const BorderSide(color: Colors.white24, width: 2),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: widget.mobile ? double.infinity : null,
                        child: Magnetic(
                          child: FilledButton.icon(
                            onPressed: () => openExternalLink(context, widget.project.demoUrl),
                            icon: const Icon(Icons.launch),
                            label: const Text('LIVE DEMO'),
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 30),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

