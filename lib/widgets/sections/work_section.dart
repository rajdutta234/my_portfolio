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

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1300),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SectionTitle(
                title: 'Expertise & Work',
                subtitle:
                    'A professional showcase of my projects, certifications, and technical proficiencies',
              ).animate().fadeIn().moveX(begin: -30, end: 0),
              const SizedBox(height: 60),

              // Premium Tab Bar
              Container(
                height: mobile ? 56 : 64,
                decoration: BoxDecoration(
                  color: const Color(0xFF0D1829).withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white12),
                ),
                child: TabBar(
                  controller: _tabController,
                  isScrollable: mobile,
                  indicator: BoxDecoration(
                    color: const Color(0xFF56F3D6),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF56F3D6).withValues(alpha: 0.3),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  labelColor: const Color(0xFF021414),
                  unselectedLabelColor: Colors.white60,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 13,
                    letterSpacing: 1.5,
                  ),
                  padding: const EdgeInsets.all(6),
                  tabs: const [
                    Tab(text: 'PROJECTS'),
                    Tab(text: 'CERTIFICATES'),
                    Tab(text: 'SKILLS'),
                  ],
                ),
              ),
              const SizedBox(height: 60),

              // Animated Content
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
        final int crossAxisCount = mobile ? 1 : 3;
        final double spacing = 32.0;
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
      barrierColor: Colors.black.withValues(alpha: 0.9),
      builder: (context) => _ProjectDetailDialog(project: project),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PerspectiveCard(
      maxTilt: 0.08,
      child: InkWell(
        onTap: () => _showProjectDetails(context),
        borderRadius: BorderRadius.circular(28),
        child: GlassContainer(
          padding: EdgeInsets.zero,
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
                padding: const EdgeInsets.all(24),
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
                    const SizedBox(height: 10),
                    Text(
                      project.stack.take(3).join(' • '),
                      style: const TextStyle(
                        color: Color(0xFF56F3D6),
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
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
              padding: EdgeInsets.zero,
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
                          top: 20,
                          right: 20,
                          child: CircleAvatar(
                            backgroundColor: Colors.black54,
                            child: IconButton(
                              icon: const Icon(Icons.close, color: Colors.white, size: 20),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(mobile ? 24 : 48),
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
                              height: 1.7,
                              letterSpacing: 0.2,
                            ),
                          ),
                          const SizedBox(height: 40),
                          if (project.contributions.isNotEmpty) ...[
                            const Text(
                              'PROJECT CONTRIBUTIONS',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 13,
                                letterSpacing: 2.5,
                                color: Color(0xFF56F3D6),
                              ),
                            ),
                            const SizedBox(height: 20),
                            ...project.contributions.map(
                              (c) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 4),
                                      child: Icon(Icons.bolt_rounded,
                                          size: 18, color: Color(0xFF56F3D6)),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        c,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          height: 1.5,
                                          fontSize: 14.5,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                          const SizedBox(height: 40),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: project.stack
                                .map(
                                  (s) => Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.05),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: Colors.white10),
                                    ),
                                    child: Text(
                                      s,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0.5,
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
        final double spacing = 24.0;
        final double itemWidth = (width - (spacing * (crossAxisCount - 1))) / crossAxisCount;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: certificates.asMap().entries.map((entry) {
            final index = entry.key;
            final certificate = entry.value;
            return SizedBox(
              width: itemWidth,
              height: itemWidth * 0.85,
              child: PerspectiveCard(
                maxTilt: 0.12,
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
        final double itemWidth = mobile ? width : (width - 32) / 2;

        return Wrap(
          spacing: 32,
          runSpacing: 32,
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
        padding: EdgeInsets.zero,
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
              opacity: _hovered ? 0.95 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF0D1829).withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.certificate.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.certificate.issuer,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Icon(
                      Icons.verified_user_rounded,
                      color: Color(0xFF56F3D6),
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
      padding: const EdgeInsets.all(32),
      borderRadius: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF56F3D6).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(category.icon, color: const Color(0xFF56F3D6), size: 22),
              ),
              const SizedBox(width: 16),
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
          const SizedBox(height: 32),

          ...category.skills.map(
            (s) => Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        s.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '${(s.proficiency * 100).toInt()}%',
                        style: TextStyle(
                          color: const Color(0xFF56F3D6).withValues(alpha: 0.7),
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
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
                      FractionallySizedBox(
                        widthFactor: s.proficiency,
                        child: Container(
                          height: 6,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF56F3D6), Color(0xFF00C2FF)],
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF56F3D6).withValues(alpha: 0.3),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
