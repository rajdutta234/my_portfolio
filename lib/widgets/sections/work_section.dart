import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../core/constants/portfolio_data.dart';
import '../../models/certificate.dart';
import '../../models/project.dart';
import '../../models/skill.dart';
import '../common/link_utils.dart';
import '../common/section_title.dart';
import '../common/perspective_card.dart';
import '../common/magnetic.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SectionTitle(
                title: 'Portfolio Showcase',
                subtitle:
                    'Engineering solutions with precision, scale, and high-performance standards.',
              ).animate().fadeIn().slideX(begin: -0.1),
              const SizedBox(height: 60),

              // Premium Cinematic Tab Bar
              _buildPremiumTabBar(mobile),
              
              const SizedBox(height: 80),

              // Animated Content Transition
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 600),
                switchInCurve: Curves.easeOutQuart,
                switchOutCurve: Curves.easeInQuart,
                child: [
                  _ProjectsTab(mobile: mobile, key: const ValueKey('projects')),
                  _CertificatesTab(mobile: mobile, key: const ValueKey('certs')),
                  _TechStackTab(mobile: mobile, key: const ValueKey('tech')),
                ][_activeIndex],
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildPremiumTabBar(bool mobile) {
    return Container(
      height: 70,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: TabBar(
        controller: _tabController,
        isScrollable: mobile,
        indicator: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF56F3D6), Color(0xFF00C2FF)],
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF56F3D6).withValues(alpha: 0.3),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.white54,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 13,
          letterSpacing: 2,
        ),
        tabs: const [
          Tab(text: 'PROJECTS'),
          Tab(text: 'CREDENTIALS'),
          Tab(text: 'CAPABILITIES'),
        ],
      ),
    );
  }
}

class _ProjectsTab extends StatelessWidget {
  const _ProjectsTab({required this.mobile, super.key});
  final bool mobile;

  @override
  Widget build(BuildContext context) {
    final allProjects = projects;

    // Grouping logic
    final naiyoProjects = allProjects.where((p) => [
      'OEMS Admin Panel',
      'Pharmacy Admin Management Panel',
      'Hospital Management Admin Panel',
      'Screen Recorder Doctor'
    ].contains(p.title)).toList();

    final euphoriaProjects = allProjects.where((p) => [
      'Blood Bank Management System'
    ].contains(p.title)).toList();

    final selfProjects = allProjects.where((p) => [
      'Advanced Calculator App',
      'U2Me — Dating App Prototype',
      'INEWS — Intelligent News Reader',
      'Premium E-Commerce Mobile App'
    ].contains(p.title)).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (naiyoProjects.isNotEmpty) ...[
          _buildCategoryHeader('NAIYO24 ECOSYSTEM'),
          const SizedBox(height: 40),
          _buildProjectGrid(naiyoProjects),
          const SizedBox(height: 100),
        ],
        if (euphoriaProjects.isNotEmpty) ...[
          _buildCategoryHeader('EUPHORIA GENX CONTRIBUTIONS'),
          const SizedBox(height: 40),
          _buildProjectGrid(euphoriaProjects),
          const SizedBox(height: 100),
        ],
        if (selfProjects.isNotEmpty) ...[
          _buildCategoryHeader('SELF-ENGINEERED SOLUTIONS'),
          const SizedBox(height: 40),
          _buildProjectGrid(selfProjects),
        ],
      ],
    );
  }

  Widget _buildCategoryHeader(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 6,
              height: 30,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF56F3D6), Color(0xFF00C2FF)],
                ),
                borderRadius: BorderRadius.circular(3),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF56F3D6).withValues(alpha: 0.5),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w900,
                letterSpacing: 6,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(left: 26),
          child: Container(
            width: 100,
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF56F3D6).withValues(alpha: 0.5),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProjectGrid(List<Project> projects) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final int crossAxisCount = mobile ? 1 : 2;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: projects.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 32,
            mainAxisSpacing: 40,
            childAspectRatio: mobile ? 0.9 : 1.4,
          ),
          itemBuilder: (context, index) {
            return _ProjectCard(
              project: projects[index],
              index: index,
              mobile: mobile,
            );
          },
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

  @override
  Widget build(BuildContext context) {
    return PerspectiveCard(
      maxTilt: 0.08,
      child: Magnetic(
        strength: 0.1,
        child: InkWell(
          onTap: () => _showDetails(context),
          borderRadius: BorderRadius.circular(32),
          child: Stack(
            children: [
              // Core Glass Container
              GlassmorphicContainer(
                width: double.infinity,
                height: double.infinity,
                borderRadius: 32,
                blur: 20,
                alignment: Alignment.center,
                border: 1.5,
                linearGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFFffffff).withValues(alpha: 0.05),
                    const Color(0xFFffffff).withValues(alpha: 0.01),
                  ],
                ),
                borderGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF56F3D6).withValues(alpha: 0.3),
                    const Color(0xFF00C2FF).withValues(alpha: 0.1),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image Section with Overlay
                    Expanded(
                      flex: 6,
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          image: DecorationImage(
                            image: AssetImage(project.imageUrl!),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withValues(alpha: 0.6),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Content Section
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 4, 24, 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    project.title,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                ),
                                const Icon(Icons.arrow_outward_rounded, color: Color(0xFF56F3D6), size: 22),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              project.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                                height: 1.5,
                              ),
                            ),
                            const Spacer(),
                            Wrap(
                              spacing: 8,
                              children: project.stack.take(3).map((s) => Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF56F3D6).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: const Color(0xFF56F3D6).withValues(alpha: 0.2)),
                                ),
                                child: Text(
                                  s.toUpperCase(),
                                  style: const TextStyle(
                                    color: Color(0xFF56F3D6),
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                              )).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Lighting Sweep Effect
              Positioned.fill(
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ).animate(onPlay: (c) => c.repeat())
                    .shimmer(
                      duration: 3.seconds,
                      color: Colors.white.withValues(alpha: 0.05),
                      angle: 45,
                    ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: (index * 150).ms).scale(begin: const Offset(0.9, 0.9));
  }

  void _showDetails(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.85),
      builder: (context) => _ProjectDetailDialog(project: project),
    );
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
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Material(
          color: Colors.transparent,
          child: GlassmorphicContainer(
            width: double.infinity,
            height: mobile ? double.infinity : 700,
            borderRadius: 32,
            blur: 25,
            alignment: Alignment.center,
            border: 2,
            linearGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF0D1829).withValues(alpha: 0.9),
                const Color(0xFF020C1B).withValues(alpha: 0.9),
              ],
            ),
            borderGradient: const LinearGradient(
              colors: [Color(0xFF56F3D6), Color(0xFF00C2FF)],
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(mobile ? 20 : 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'PROJECT DEEP-DIVE',
                        style: TextStyle(
                          color: const Color(0xFF56F3D6),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close_rounded, color: Colors.white54),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    project.title,
                    style: TextStyle(
                      fontSize: mobile ? 32 : 48,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 30),
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(project.imageUrl!, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    project.description,
                    style: const TextStyle(color: Colors.white70, fontSize: 16, height: 1.8),
                  ),
                  const SizedBox(height: 40),
                  _buildSectionTitle('CORE CONTRIBUTIONS'),
                  const SizedBox(height: 20),
                  ...project.contributions.map((c) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.check_circle_outline, color: Color(0xFF56F3D6), size: 18),
                        const SizedBox(width: 12),
                        Expanded(child: Text(c, style: const TextStyle(color: Colors.white))),
                      ],
                    ),
                  )),
                  const SizedBox(height: 40),
                  _buildSectionTitle('TECHNOLOGIES'),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: project.stack.map((s) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: Text(s, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    )).toList(),
                  ),
                  const SizedBox(height: 60),
                  Row(
                    children: [
                      if (project.githubUrl.isNotEmpty)
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => openExternalLink(context, project.githubUrl),
                            icon: const Icon(Icons.code_rounded),
                            label: const Text('VIEW SOURCE'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white12,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.all(20),
                            ),
                          ),
                        ),
                      if (project.demoUrl.isNotEmpty) ...[
                        const SizedBox(width: 20),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => openExternalLink(context, project.demoUrl),
                            icon: const Icon(Icons.launch_rounded),
                            label: const Text('LIVE DEMO'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF56F3D6),
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.all(20),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF56F3D6),
        fontSize: 11,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
      ),
    );
  }
}

class _CertificatesTab extends StatelessWidget {
  const _CertificatesTab({required this.mobile, super.key});
  final bool mobile;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: certificates.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: mobile ? 2 : 4,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        return _CertificateCard(certificate: certificates[index], index: index);
      },
    );
  }
}

class _CertificateCard extends StatelessWidget {
  const _CertificateCard({required this.certificate, required this.index});
  final Certificate certificate;
  final int index;

  @override
  Widget build(BuildContext context) {
    return PerspectiveCard(
      maxTilt: 0.1,
      child: GlassmorphicContainer(
        width: double.infinity,
        height: double.infinity,
        borderRadius: 20,
        blur: 10,
        alignment: Alignment.center,
        border: 1,
        linearGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFffffff).withValues(alpha: 0.05),
            const Color(0xFFffffff).withValues(alpha: 0.02),
          ],
        ),
        borderGradient: LinearGradient(
          colors: [Colors.white.withValues(alpha: 0.2), Colors.transparent],
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage(certificate.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                certificate.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: (index * 100).ms).scale(begin: const Offset(0.9, 0.9));
  }
}

class _TechStackTab extends StatelessWidget {
  const _TechStackTab({required this.mobile, super.key});
  final bool mobile;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final int crossAxisCount = mobile ? 1 : 2;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: skills.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 32,
            mainAxisSpacing: 32,
            childAspectRatio: mobile ? 1.0 : 1.5,
          ),
          itemBuilder: (context, index) {
            return _SkillCategoryCard(category: skills[index], index: index);
          },
        );
      },
    );
  }
}

class _SkillCategoryCard extends StatelessWidget {
  const _SkillCategoryCard({required this.category, required this.index});
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
        colors: [
          Colors.white.withValues(alpha: 0.05),
          Colors.white.withValues(alpha: 0.02),
        ],
      ),
      borderGradient: LinearGradient(
        colors: [const Color(0xFF56F3D6).withValues(alpha: 0.3), Colors.transparent],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(category.icon, color: const Color(0xFF56F3D6), size: 24),
                const SizedBox(width: 12),
                Text(
                  category.title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: category.skills.map((s) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(s.name, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 12)),
                            Text('${(s.proficiency * 100).toInt()}%', style: const TextStyle(color: Color(0xFF56F3D6), fontSize: 12)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Stack(
                          children: [
                            Container(
                              height: 3,
                              width: double.infinity,
                              decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(2)),
                            ),
                            FractionallySizedBox(
                              widthFactor: s.proficiency,
                              child: Container(
                                height: 3,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(colors: [Color(0xFF56F3D6), Color(0xFF00C2FF)]),
                                  borderRadius: BorderRadius.circular(2),
                                  boxShadow: [
                                    BoxShadow(color: const Color(0xFF56F3D6).withValues(alpha: 0.4), blurRadius: 8),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: (index * 150).ms).moveY(begin: 20);
  }
}
