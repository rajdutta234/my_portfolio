import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../core/constants/portfolio_data.dart';
import '../notifier/app_notifier.dart';
import '../widgets/sections/about_section.dart';
import '../widgets/sections/contact_section.dart';
import '../widgets/sections/experience_section.dart';
import '../widgets/sections/footer_section.dart';
import '../widgets/sections/hero_section.dart';
import '../widgets/sections/projects_section.dart';
import '../widgets/sections/skills_section.dart';
import '../widgets/common/animated_background.dart';
import '../widgets/common/nav_bar.dart';
import '../widgets/common/custom_cursor.dart';
import '../widgets/common/noise_overlay.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key, this.initialSectionIndex});

  final int? initialSectionIndex;

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys =
      List<GlobalKey>.generate(navItems.length, (_) => GlobalKey());

  bool _initialJumpHandled = false;
  double _scrollProgress = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _initialJumpHandled || widget.initialSectionIndex == null) {
        return;
      }
      _initialJumpHandled = true;
      context.read<AppNotifier>().activeSectionIndex = widget.initialSectionIndex!;
      _scrollToSection(widget.initialSectionIndex!);
    });
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_handleScroll)
      ..dispose();
    super.dispose();
  }

  void _handleScroll() {
    final AppNotifier notifier = context.read<AppNotifier>();

    if (_scrollController.hasClients) {
      setState(() {
        _scrollProgress = (_scrollController.offset / _scrollController.position.maxScrollExtent).clamp(0, 1);
      });
    }

    for (int i = 0; i < _sectionKeys.length; i++) {
      final BuildContext? context = _sectionKeys[i].currentContext;
      if (context == null) {
        continue;
      }

      final RenderObject? object = context.findRenderObject();
      if (object is! RenderBox || !object.attached) {
        continue;
      }

      final double top = object.localToGlobal(Offset.zero).dy;
      if (top <= 180 && top > -420 && notifier.activeSectionIndex != i) {
        notifier.activeSectionIndex = i;
      }
    }
  }

  Future<void> _scrollToSection(int index) async {
    final BuildContext? context = _sectionKeys[index].currentContext;
    if (context == null) {
      return;
    }

    await Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
      alignment: index == 0 ? 0 : 0.06,
    );
  }

  @override
  Widget build(BuildContext context) {
    final int activeIndex = context.watch<AppNotifier>().activeSectionIndex;

    return Scaffold(
      body: CustomCursor(
        child: Stack(
          children: <Widget>[
            const Positioned.fill(child: AnimatedBackground()),
            const Positioned.fill(child: NoiseOverlay()),
            
            // Decorative blobs
            Positioned(
              top: -130,
              right: -80,
              child: IgnorePointer(
                child: Container(
                  width: 380,
                  height: 380,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: <Color>[
                        Colors.blue.withValues(alpha: 0.15),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            
            Positioned.fill(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: <Widget>[
                    HeroSection(
                      key: _sectionKeys[0],
                      onViewProjects: () => _scrollToSection(4),
                    ),
                    _SectionWrapper(key: _sectionKeys[1], child: const AboutSection()),
                    _SectionWrapper(key: _sectionKeys[2], child: const SkillsSection()),
                    _SectionWrapper(key: _sectionKeys[3], child: const ExperienceSection()),
                    _SectionWrapper(key: _sectionKeys[4], child: const ProjectsSection()),
                    _SectionWrapper(key: _sectionKeys[5], child: const ContactSection()),
                    const FooterSection(),
                  ],
                ),
              ),
            ),

            // Scroll progress indicator
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 4,
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: _scrollProgress,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue, Colors.purple],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            PortfolioNavBar(
              items: navItems,
              activeIndex: activeIndex,
              onTap: _scrollToSection,
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionWrapper extends StatelessWidget {
  const _SectionWrapper({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child.animate().fadeIn(duration: 800.ms).moveY(begin: 40, end: 0, curve: Curves.easeOutCubic);
  }
}
