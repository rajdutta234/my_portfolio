import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      body: Stack(
        children: <Widget>[
          const Positioned.fill(child: AnimatedBackground()),
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
                      Colors.white.withValues(alpha: 0.22),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -170,
            left: -120,
            child: IgnorePointer(
              child: Container(
                width: 440,
                height: 440,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: <Color>[
                      Colors.white.withValues(alpha: 0.14),
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
                  Container(
                    key: _sectionKeys[0],
                    child: HeroSection(
                      onViewProjects: () => _scrollToSection(4),
                    ),
                  ),
                  Container(key: _sectionKeys[1], child: const AboutSection()),
                  Container(key: _sectionKeys[2], child: const SkillsSection()),
                  Container(
                    key: _sectionKeys[3],
                    child: const ExperienceSection(),
                  ),
                  Container(key: _sectionKeys[4], child: const ProjectsSection()),
                  Container(key: _sectionKeys[5], child: const ContactSection()),
                  const FooterSection(),
                ],
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
    );
  }
}
