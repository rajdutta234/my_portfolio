import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/constants/portfolio_data.dart';
import '../../models/certificate.dart';
import '../../models/project.dart';
import '../../models/skill.dart';
import '../common/glass_container.dart';
import '../common/link_utils.dart';
import '../common/section_title.dart';
import '../common/perspective_card.dart';

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
      constraints: const BoxConstraints(maxWidth: 1300),
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
        // 3 columns on desktop for "slightly smaller" cards
        final int crossAxisCount = mobile ? 1 : 3;
        final double spacing = mobile ? 24.0 : 32.0;
        final double itemWidth =
            (width - (spacing * (crossAxisCount - 1))) / crossAxisCount;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: projects.asMap().entries.map((entry) {
            final index = entry.key;
            final project = entry.value;
            return SizedBox(
              width: itemWidth,
              child: _ProjectCard(
                project: project,
                index: index,
                mobile: mobile,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({
    required this.project,
    required this.index,
    required this.mobile,
  });
  final Project project;
  final int index;
  final bool mobile;

  void _showProjectDetails(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.85),
      builder: (context) => _ProjectDetailDialog(project: project),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PerspectiveCard(
      maxTilt: 0.1,
      child: InkWell(
        onTap: () => _showProjectDetails(context),
        borderRadius: BorderRadius.circular(28),
        child: GlassContainer(
          padding: const EdgeInsets.all(0),
          borderRadius: 28,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                child: AspectRatio(
                  aspectRatio: 16 / 10,
                  child: Image.asset(
                    project.imageUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      project.stack.take(3).join(' • '),
                      style: const TextStyle(
                        color: Color(0xFF56F3D6),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: (index * 80).ms).moveY(begin: 30, end: 0);
  }
}

class _ProjectDetailDialog extends StatelessWidget {
  const _ProjectDetailDialog({required this.project});
  final Project project;

  @override
  Widget build(BuildContext context) {
    final bool mobile = MediaQuery.sizeOf(context).width < 760;

    return Center(
      child: Container(
        margin: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxWidth: 900),
        child: Material(
          color: Colors.transparent,
          child: PerspectiveCard(
            maxTilt: 0.04,
            child: GlassContainer(
              padding: const EdgeInsets.all(0),
              borderRadius: 32,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Image
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                          child: AspectRatio(
                            aspectRatio: mobile ? 4 / 3 : 21 / 9,
                            child: Image.asset(project.imageUrl!, fit: BoxFit.cover),
                          ),
                        ),
                        Positioned(
                          top: 16,
                          right: 16,
                          child: CircleAvatar(
                            backgroundColor: Colors.black54,
                            child: IconButton(
                              icon: const Icon(Icons.close, color: Colors.white),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(mobile ? 24 : 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  project.title,
                                  style: TextStyle(
                                    fontSize: mobile ? 24 : 36,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: -1,
                                  ),
                                ),
                              ),
                              if (project.githubUrl.isNotEmpty)
                                _DialogIconButton(
                                  icon: Icons.code,
                                  onPressed: () => openExternalLink(context, project.githubUrl),
                                ),
                              if (project.demoUrl.isNotEmpty) ...[
                                const SizedBox(width: 12),
                                _DialogIconButton(
                                  icon: Icons.launch,
                                  onPressed: () => openExternalLink(context, project.demoUrl),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 24),
                          Text(
                            project.description,
                            style: TextStyle(
                              fontSize: mobile ? 14 : 16,
                              color: Colors.white70,
                              height: 1.6,
                            ),
                          ),
                          const SizedBox(height: 32),
                          if (project.contributions.isNotEmpty) ...[
                            const Text(
                              'KEY CONTRIBUTIONS',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 13,
                                letterSpacing: 2,
                                color: Color(0xFF56F3D6),
                              ),
                            ),
                            const SizedBox(height: 16),
                            ...project.contributions.map(
                              (c) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 6),
                                      child: Icon(Icons.check_circle,
                                          size: 16, color: Color(0xFF56F3D6)),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Text(
                                        c,
                                        style: const TextStyle(color: Colors.white70, height: 1.4),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                          const SizedBox(height: 32),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: project.stack
                                .map(
                                  (s) => Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.05),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: Colors.white12),
                                    ),
                                    child: Text(
                                      s,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
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
            ),
          ),
        ),
      ),
    );
  }
}

class _DialogIconButton extends StatelessWidget {
  const _DialogIconButton({required this.icon, required this.onPressed});
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF56F3D6).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF56F3D6).withValues(alpha: 0.3)),
      ),
      child: IconButton(
        icon: Icon(icon, color: const Color(0xFF56F3D6), size: 20),
        onPressed: onPressed,
      ),
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
        final int crossAxisCount = mobile ? 2 : 4;
        final double spacing = 20.0;
        final double itemWidth = (width - (spacing * (crossAxisCount - 1))) / crossAxisCount;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: certificates.asMap().entries.map((entry) {
            final index = entry.key;
            final certificate = entry.value;
            return SizedBox(
              width: itemWidth,
              height: itemWidth * 0.8,
              child: PerspectiveCard(
                maxTilt: 0.1,
                child: _CertificateCard(certificate: certificate),
              )
                  .animate()
                  .fadeIn(delay: (index * 50).ms)
                  .scale(begin: const Offset(0.9, 0.9)),
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
              child: PerspectiveCard(
                maxTilt: 0.05,
                child: _SkillCategoryCard(
                  category: category,
                  index: index,
                ),
              ).animate().fadeIn(delay: (index * 100).ms).moveY(begin: 20, end: 0),
            );
          }).toList(),
        );
      },
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
