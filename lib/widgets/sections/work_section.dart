import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

import '../../core/constants/portfolio_data.dart';
import '../../core/responsive.dart';
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
    final bool isMobile = Responsive.isMobile(context);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1300),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
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
              _buildPremiumTabBar(isMobile),

              const SizedBox(height: 80),

              // Animated Content Transition
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 600),
                switchInCurve: Curves.easeOutQuart,
                switchOutCurve: Curves.easeInQuart,
                child: [
                  _ProjectsTab(
                    isMobile: isMobile,
                    key: const ValueKey('projects'),
                  ),
                  _CertificatesTab(
                    isMobile: isMobile,
                    key: const ValueKey('certs'),
                  ),
                  _TechStackTab(
                    isMobile: isMobile,
                    key: const ValueKey('tech'),
                  ),
                ][_activeIndex],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPremiumTabBar(bool isMobile) {
    return Container(
      height: isMobile ? 55 : 70,
      padding: EdgeInsets.all(isMobile ? 4 : 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: TabBar(
        controller: _tabController,
        isScrollable: false,
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
        labelStyle: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: isMobile ? 11 : 13,
          letterSpacing: isMobile ? 1 : 2,
        ),
        tabs: const [
          Tab(text: 'PROJECTS'),
          Tab(text: 'CERTIFICATES'),
          Tab(text: 'SKILLS'),
        ],
      ),
    );
  }
}

class _ProjectsTab extends StatelessWidget {
  const _ProjectsTab({required this.isMobile, super.key});
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final allProjects = projects;

    // Grouping logic
    final naiyoProjects = allProjects
        .where(
          (p) => [
            'OEMS Admin Panel',
            'Pharmacy Admin Management Panel',
            'Hospital Management Admin Panel',
            'Screen Recorder Doctor',
          ].contains(p.title),
        )
        .toList();

    final euphoriaProjects = allProjects
        .where((p) => ['Blood Bank Management System'].contains(p.title))
        .toList();

    final selfProjects = allProjects
        .where(
          (p) => [
            'Advanced Calculator App',
            'U2Me — Dating App Prototype',
            'INEWS — Intelligent News Reader',
            'Premium E-Commerce Mobile App',
          ].contains(p.title),
        )
        .toList();

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
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isMobile ? 14 : 16,
                  fontWeight: FontWeight.w900,
                  letterSpacing: isMobile ? 2 : 6,
                ),
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
        final bool isMobile = Responsive.isMobile(context);
        final bool isTablet = Responsive.isTablet(context);
        final bool isLargeDesktop = constraints.maxWidth > 1400;

        int crossAxisCount = 1;
        if (isLargeDesktop) {
          crossAxisCount = 3;
        } else if (isTablet || !isMobile) {
          crossAxisCount = 2;
        }

        double aspectRatio = 1.4;
        if (isMobile) {
          aspectRatio = 0.85;
        } else if (isTablet) {
          aspectRatio = 1.1;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: projects.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: isMobile ? 20 : 32,
            mainAxisSpacing: isMobile ? 30 : 40,
            childAspectRatio: aspectRatio,
          ),
          itemBuilder: (context, index) {
            return _ProjectCard(
              project: projects[index],
              index: index,
              isMobile: isMobile,
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
    required this.isMobile,
  });
  final Project project;
  final int index;
  final bool isMobile;

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
                    blur: 10,
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
                          flex: isMobile ? 5 : 6,
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
                          flex: isMobile ? 5 : 4,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                              isMobile ? 16 : 24,
                              4,
                              isMobile ? 16 : 24,
                              isMobile ? 16 : 24,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        project.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: isMobile ? 18 : 22,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white,
                                          letterSpacing: -0.5,
                                        ),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_outward_rounded,
                                      color: Color(0xFF56F3D6),
                                      size: 20,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  project.description,
                                  maxLines: isMobile ? 2 : 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: isMobile ? 12 : 13,
                                    height: 1.4,
                                  ),
                                ),
                                const Spacer(),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 4,
                                  children: project.stack
                                      .take(isMobile ? 2 : 3)
                                      .map(
                                        (s) => Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(
                                              0xFF56F3D6,
                                            ).withValues(alpha: 0.1),
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(
                                              color: const Color(
                                                0xFF56F3D6,
                                              ).withValues(alpha: 0.2),
                                            ),
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
                                        ),
                                      )
                                      .toList(),
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
                      child:
                          Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                              )
                              .animate(onPlay: (c) => c.repeat())
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
        )
        .animate()
        .fadeIn(delay: (index * 150).ms)
        .scale(begin: const Offset(0.9, 0.9));
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
    final bool isMobile = Responsive.isMobile(context);

    return Center(
      child: Container(
        margin: EdgeInsets.all(isMobile ? 0 : 24),
        constraints: BoxConstraints(
          maxWidth: 1000,
          maxHeight: isMobile ? double.infinity : MediaQuery.sizeOf(context).height * 0.9,
        ),
        child: Material(
          color: Colors.transparent,
          child: GlassmorphicContainer(
            width: double.infinity,
            height: isMobile ? double.infinity : 700, // Providing a concrete value to avoid double? issue
            borderRadius: isMobile ? 0 : 32,
            blur: 20,
            alignment: Alignment.center,
            border: isMobile ? 0 : 2,
            linearGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF0D1829).withValues(alpha: 0.98),
                const Color(0xFF020C1B).withValues(alpha: 0.98),
              ],
            ),
            borderGradient: const LinearGradient(
              colors: [Color(0xFF56F3D6), Color(0xFF00C2FF)],
            ),
            child: Column(
              children: [
                // Sticky Header
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    isMobile ? 20 : 40,
                    isMobile ? 50 : 20,
                    isMobile ? 20 : 20,
                    10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'PROJECT DEEP-DIVE',
                        style: TextStyle(
                          color: Color(0xFF56F3D6),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white.withValues(alpha: 0.05),
                        ),
                        icon: const Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(
                      isMobile ? 20 : 40,
                      0,
                      isMobile ? 20 : 40,
                      40,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.title,
                          style: TextStyle(
                            fontSize: isMobile ? 32 : 44,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            height: 1.1,
                            letterSpacing: -1,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Hero(
                          tag: 'project_image_${project.title}',
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                image: DecorationImage(
                                  image: AssetImage(project.imageUrl!),
                                  fit: BoxFit.cover,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF56F3D6).withValues(alpha: 0.1),
                                    blurRadius: 30,
                                    spreadRadius: -10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          project.description,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: isMobile ? 15 : 16,
                            height: 1.8,
                          ),
                        ),
                        const SizedBox(height: 40),
                        _buildSectionTitle('KEY CONTRIBUTIONS'),
                        const SizedBox(height: 20),
                        ...project.contributions.map(
                          (c) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 4),
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF56F3D6),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    c,
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.9),
                                      fontSize: 14,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        _buildSectionTitle('TECH STACK'),
                        const SizedBox(height: 20),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: project.stack
                              .map(
                                (s) => Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.05),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.white.withValues(alpha: 0.1),
                                    ),
                                  ),
                                  child: Text(
                                    s,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 60),
                        Row(
                          children: [
                            if (project.githubUrl.isNotEmpty)
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () =>
                                      openExternalLink(context, project.githubUrl),
                                  icon: const Icon(Icons.code_rounded),
                                  label: const Text('SOURCE'),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    side: const BorderSide(color: Colors.white10),
                                    padding: const EdgeInsets.symmetric(vertical: 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                ),
                              ),
                            if (project.demoUrl.isNotEmpty) ...[
                              if (project.githubUrl.isNotEmpty)
                                const SizedBox(width: 16),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF56F3D6)
                                            .withValues(alpha: 0.3),
                                        blurRadius: 20,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: ElevatedButton.icon(
                                    onPressed: () =>
                                        openExternalLink(context, project.demoUrl),
                                    icon: const Icon(Icons.rocket_launch_rounded),
                                    label: const Text('LIVE DEMO'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF56F3D6),
                                      foregroundColor: Colors.black,
                                      padding: const EdgeInsets.symmetric(vertical: 20),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
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
              ],
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
  const _CertificatesTab({required this.isMobile, super.key});
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!isMobile) ...[
          const SizedBox(
            height: 250,
            child: RepaintBoundary(
              child: ModelViewer(
                src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb', // Placeholder
                alt: 'Certificates',
                autoRotate: true,
                cameraControls: false,
                disableZoom: true,
                shadowIntensity: 1,
                environmentImage: 'neutral',
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: certificates.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isMobile ? 2 : 4,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            return _CertificateCard(certificate: certificates[index], index: index);
          },
        ),
      ],
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
            blur: 5,
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
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(delay: (index * 100).ms)
        .scale(begin: const Offset(0.9, 0.9));
  }
}

class _TechStackTab extends StatelessWidget {
  const _TechStackTab({required this.isMobile, super.key});
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = Responsive.isMobile(context);
        
        return Column(
          children: [
            if (!isMobile) ...[
              const SizedBox(
                height: 300,
                child: RepaintBoundary(
                  child: ModelViewer(
                    src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb', // Placeholder, will use tech model
                    alt: 'Tech Stack',
                    autoRotate: true,
                    cameraControls: false,
                    disableZoom: true,
                    shadowIntensity: 1,
                    environmentImage: 'neutral',
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: skills.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMobile ? 1 : 2,
                crossAxisSpacing: 32,
                mainAxisSpacing: 32,
                childAspectRatio: isMobile ? 1.0 : 1.5,
              ),
              itemBuilder: (context, index) {
                return _SkillCategoryCard(category: skills[index], index: index);
              },
            ),
          ],
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
      blur: 10,
      alignment: Alignment.center,
      border: 1.5,
      linearGradient: LinearGradient(
        colors: [
          Colors.white.withValues(alpha: 0.05),
          Colors.white.withValues(alpha: 0.02),
        ],
      ),
      borderGradient: LinearGradient(
        colors: [
          const Color(0xFF56F3D6).withValues(alpha: 0.3),
          Colors.transparent,
        ],
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
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: category.skills
                      .map(
                        (s) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    s.name,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${(s.proficiency * 100).toInt()}%',
                                    style: const TextStyle(
                                      color: Color(0xFF56F3D6),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Stack(
                                children: [
                                  Container(
                                    height: 3,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white10,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  FractionallySizedBox(
                                    widthFactor: s.proficiency,
                                    child: Container(
                                      height: 3,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF56F3D6),
                                            Color(0xFF00C2FF),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(2),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(
                                              0xFF56F3D6,
                                            ).withValues(alpha: 0.4),
                                            blurRadius: 8,
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
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: (index * 150).ms).moveY(begin: 20);
  }
}
