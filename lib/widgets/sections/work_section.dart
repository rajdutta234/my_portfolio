import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/constants/portfolio_data.dart';
import '../../models/certificate.dart';
import '../../models/project.dart';
import '../../models/skill.dart';
import '../common/glass_container.dart';
import '../common/link_utils.dart';
import '../common/section_title.dart';

class WorkSection extends StatefulWidget {
  const WorkSection({super.key});

  @override
  State<WorkSection> createState() => _WorkSectionState();
}

class _WorkSectionState extends State<WorkSection>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _activeIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() => _activeIndex = _tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool mobile = MediaQuery.sizeOf(context).width < 760;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1200),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SectionTitle(
              title: 'EXPERTISE & ACHIEVEMENTS',
              subtitle:
                  'A showcase of my projects, certifications, and technical skills',
            ).animate().fadeIn().moveX(begin: -30, end: 0),
            const SizedBox(height: 48),

            // Tab Bar
            Container(
              height: mobile ? 56 : 60,
              decoration: BoxDecoration(
                color: const Color(0xFF0D1829).withValues(alpha: 0.52),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white24),
              ),
              child: TabBar(
                controller: _tabController,
                isScrollable: mobile,
                indicator: BoxDecoration(
                  color: const Color(0xFF56F3D6),
                  borderRadius: BorderRadius.circular(16),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                labelColor: const Color(0xFF021414),
                unselectedLabelColor: Colors.white60,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                  letterSpacing: 1,
                ),
                padding: const EdgeInsets.all(4),
                tabs: const [
                  Tab(text: 'PROJECTS'),
                  Tab(text: 'CERTIFICATES'),
                  Tab(text: 'TECH STACK'),
                ],
              ),
            ),
            const SizedBox(height: 60),

            // Tab Content
            AnimatedSize(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              child: [
                _ProjectsTab(mobile: mobile),
                _CertificatesTab(mobile: mobile),
                _TechStackTab(mobile: mobile),
              ][_activeIndex],
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectsTab extends StatelessWidget {
  const _ProjectsTab({required this.mobile});
  final bool mobile;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final double itemWidth = mobile ? width : (width - 28) / 2;

        return Wrap(
          spacing: 28,
          runSpacing: 32,
          children: projects.asMap().entries.map((entry) {
            return SizedBox(
              width: itemWidth,
              child: _ProjectCard(
                project: entry.value,
                index: entry.key,
                mobile: mobile,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _CertificatesTab extends StatelessWidget {
  const _CertificatesTab({required this.mobile});
  final bool mobile;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final double itemWidth = mobile ? width : (width - 24) / 2;

        return Wrap(
          spacing: 24,
          runSpacing: 24,
          children: certificates.asMap().entries.map((entry) {
            final index = entry.key;
            final certificate = entry.value;
            return SizedBox(
              width: itemWidth,
              height: itemWidth / (mobile ? 1.25 : 1.4),
              child: _CertificateCard(certificate: certificate)
                  .animate()
                  .fadeIn(delay: (index * 100).ms)
                  .scale(begin: const Offset(0.95, 0.95)),
            );
          }).toList(),
        );
      },
    );
  }
}

class _TechStackTab extends StatelessWidget {
  const _TechStackTab({required this.mobile});
  final bool mobile;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final double itemWidth = mobile ? width : (width - 24) / 2;

        return Wrap(
          spacing: 24,
          runSpacing: 24,
          children: skills.asMap().entries.map((entry) {
            final index = entry.key;
            final category = entry.value;
            return SizedBox(
              width: itemWidth,
              child: _SkillCategoryCard(
                category: category,
                index: index,
              ).animate().fadeIn(delay: (index * 100).ms).moveY(begin: 20, end: 0),
            );
          }).toList(),
        );
      },
    );
  }
}

class _ProjectCard extends StatefulWidget {
  const _ProjectCard({
    required this.project,
    required this.index,
    required this.mobile,
  });
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
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(32),
              ),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Stack(
                  children: [
                    AnimatedScale(
                      scale: _hovered ? 1.05 : 1.0,
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOutCubic,
                      child: Image.asset(
                        widget.project.imageUrl!,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: _hovered ? 0.2 : 0.4,
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
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.project.title,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.5,
                              ),
                        ),
                      ),
                      if (widget.project.githubUrl.isNotEmpty ||
                          widget.project.demoUrl.isNotEmpty)
                        Row(
                          children: [
                            if (widget.project.githubUrl.isNotEmpty)
                              IconButton(
                                icon: const Icon(Icons.code),
                                onPressed: () => openExternalLink(
                                  context,
                                  widget.project.githubUrl,
                                ),
                                tooltip: 'Source Code',
                              ),
                            if (widget.project.demoUrl.isNotEmpty)
                              IconButton(
                                icon: const Icon(Icons.launch),
                                onPressed: () => openExternalLink(
                                  context,
                                  widget.project.demoUrl,
                                ),
                                tooltip: 'Live Demo',
                              ),
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.project.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white70,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  if (widget.project.contributions.isNotEmpty) ...[
                    const Text(
                      'KEY CONTRIBUTIONS',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 12,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...widget.project.contributions.map(
                      (c) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 6),
                              width: 5,
                              height: 5,
                              decoration: const BoxDecoration(
                                color: Colors.white38,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                c,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white70,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  if (widget.project.impact.isNotEmpty) ...[
                    const Text(
                      'IMPACT',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 12,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...widget.project.impact.map(
                      (i) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.bolt,
                              size: 14,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                i,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white70,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.project.stack
                        .map(
                          (s) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFF0D1829,
                              ).withValues(alpha: 0.62),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white24),
                            ),
                            child: Text(
                              s,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                        .toList(),
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

class _CertificateCard extends StatefulWidget {
  const _CertificateCard({required this.certificate});
  final Certificate certificate;

  @override
  State<_CertificateCard> createState() => _CertificateCardState();
}

class _CertificateCardState extends State<_CertificateCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GlassContainer(
        padding: const EdgeInsets.all(0),
        borderRadius: 24,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                widget.certificate.imageUrl,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            AnimatedOpacity(
              opacity: _hovered ? 0.9 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.certificate.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.certificate.issuer,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Icon(
                      Icons.workspace_premium,
                      color: Colors.amber,
                      size: 32,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillCategoryCard extends StatelessWidget {
  const _SkillCategoryCard({required this.category, required this.index});
  final SkillCategory category;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(category.icon, color: Colors.white, size: 20),
              const SizedBox(width: 12),
              Text(
                category.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          ...category.skills.map(
            (s) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        s.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '${(s.proficiency * 100).toInt()}%',
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: s.proficiency,
                      backgroundColor: Colors.white.withValues(alpha: 0.05),
                      valueColor: const AlwaysStoppedAnimation(Colors.white),
                      minHeight: 4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
