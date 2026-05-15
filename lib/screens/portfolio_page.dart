import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/responsive.dart';
import '../core/constants/portfolio_data.dart';
import '../provider/portfolio_provider.dart';
import '../widgets/sections/about_section.dart';
import '../widgets/sections/contact_section.dart';
import '../widgets/sections/experience_section.dart';
import '../widgets/sections/footer_section.dart';
import '../widgets/sections/hero_section.dart';
import '../widgets/sections/work_section.dart';
import '../widgets/common/animated_background.dart';
import '../widgets/common/app_bar.dart';
import '../widgets/common/cyber_cursor.dart';
import '../widgets/common/noise_overlay.dart';
import '../widgets/common/cinematic_section.dart';

class PortfolioPage extends ConsumerStatefulWidget {
  const PortfolioPage({super.key, this.initialSectionIndex});

  final int? initialSectionIndex;

  @override
  ConsumerState<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends ConsumerState<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = List<GlobalKey>.generate(
    navItems.length,
    (_) => GlobalKey(),
  );

  bool _initialJumpHandled = false;
  final ValueNotifier<double> _scrollProgress = ValueNotifier<double>(0);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted ||
          _initialJumpHandled ||
          widget.initialSectionIndex == null) {
        return;
      }
      _initialJumpHandled = true;
      ref.read(activeSectionProvider.notifier).set(widget.initialSectionIndex!);
      _scrollToSection(widget.initialSectionIndex!);
    });
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_handleScroll)
      ..dispose();
    _scrollProgress.dispose();
    super.dispose();
  }

  Widget _buildAmbientGlow(double size, Color color) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: [color, Colors.transparent]),
        ),
      ),
    );
  }

  void _handleScroll() {
    if (_scrollController.hasClients) {
      _scrollProgress.value =
          (_scrollController.offset /
                  _scrollController.position.maxScrollExtent)
              .clamp(0, 1);
    }

    // ULTIMATE FOOLPROOF SCROLLSPY ALGORITHM
    // 1. We determine what section the user is actually looking at by checking if it contains the "Focus Line"
    // 2. We handle the bottom of the page independently of maxScrollExtent to prevent jitter.
    
    final double viewportHeight = MediaQuery.sizeOf(context).height;
    final double focusLine = viewportHeight * 0.4; // 40% down the screen
    
    int bestMatchIndex = ref.read(activeSectionProvider);

    for (int i = 0; i < _sectionKeys.length; i++) {
      final BuildContext? sectionContext = _sectionKeys[i].currentContext;
      if (sectionContext == null) continue;

      final RenderBox? box = sectionContext.findRenderObject() as RenderBox?;
      if (box == null || !box.attached) continue;

      final Offset position = box.localToGlobal(Offset.zero);
      final double sectionTop = position.dy;
      final double sectionBottom = sectionTop + box.size.height;

      // --- SPECIAL BOTTOM SECTION RULE ---
      // If we are evaluating the very last section (Contact), we check if it is fully resting
      // at the bottom of the screen. This bypasses the need for it to stretch up to the focus line.
      if (i == _sectionKeys.length - 1) {
        if (sectionTop < viewportHeight && sectionBottom <= viewportHeight + 150) {
          bestMatchIndex = i;
          break; // The user has reached the bottom of the page
        }
      }

      // --- STANDARD RULE ---
      // Does this section contain the focus line?
      if (sectionTop <= focusLine && sectionBottom > focusLine) {
        bestMatchIndex = i;
        break; // We found the section! Stop searching.
      }
    }

    // Fallback safety for absolute top
    if (_scrollController.offset <= 50) {
      bestMatchIndex = 0;
    }

    final int currentActiveIndex = ref.read(activeSectionProvider);
    if (bestMatchIndex != currentActiveIndex) {
      ref.read(activeSectionProvider.notifier).set(bestMatchIndex);
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
    final int activeIndex = ref.watch(activeSectionProvider);
    final bool isMobile = Responsive.isMobile(context);

    return Scaffold(
      key: const ValueKey('portfolio_scaffold'),
      drawer: isMobile
          ? Drawer(
              backgroundColor: const Color(0xFF0A0A0A),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: const Color(0xFF56F3D6).withValues(alpha: 0.1),
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF56F3D6).withValues(alpha: 0.1),
                            Colors.transparent,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFF56F3D6),
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.code_rounded,
                                color: Color(0xFF56F3D6),
                                size: 32,
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'RAJ DUTTA',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 4,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: navItems.length,
                        itemBuilder: (context, index) {
                          final bool isSelected = activeIndex == index;
                          return ListTile(
                            selected: isSelected,
                            selectedTileColor: const Color(
                              0xFF56F3D6,
                            ).withValues(alpha: 0.05),
                            leading: Icon(
                              _getIconForSection(navItems[index]),
                              color: isSelected
                                  ? const Color(0xFF56F3D6)
                                  : Colors.white54,
                            ),
                            title: Text(
                              navItems[index].toUpperCase(),
                              style: TextStyle(
                                color: isSelected
                                    ? const Color(0xFF56F3D6)
                                    : Colors.white70,
                                fontWeight: isSelected
                                    ? FontWeight.w900
                                    : FontWeight.w500,
                                letterSpacing: 2,
                                fontSize: 13,
                              ),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              _scrollToSection(index);
                            },
                          );
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Text(
                        '© 2026 RAJ DUTTA',
                        style: TextStyle(
                          color: Colors.white24,
                          fontSize: 10,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
      body: CyberCursor(
        child: Stack(
          children: <Widget>[
            // RepaintBoundary for expensive background layers
            RepaintBoundary(
              child: Stack(
                children: [
                  const Positioned.fill(child: AnimatedBackground()),
                  const Positioned.fill(child: NoiseOverlay()),
                ],
              ),
            ),

            // Optimized Ambient Glows
            RepaintBoundary(
              child: Stack(
                children: [
                  Positioned(
                    top: -130,
                    right: -80,
                    child: _buildAmbientGlow(
                      380,
                      const Color(0xFF00C2FF).withValues(alpha: 0.1),
                    ),
                  ),
                  Positioned(
                    bottom: 200,
                    left: -100,
                    child: _buildAmbientGlow(
                      450,
                      const Color(0xFF56F3D6).withValues(alpha: 0.06),
                    ),
                  ),
                ],
              ),
            ),

            Positioned.fill(
              child: CustomScrollView(
                controller: _scrollController,
                cacheExtent:
                    3000, // Pre-build slivers so GlobalKeys are available for navigation
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: RepaintBoundary(
                      child: HeroSection(
                        key: _sectionKeys[0],
                        onViewProjects: () => _scrollToSection(3),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: RepaintBoundary(
                      child: CinematicSection(
                        key: _sectionKeys[1],
                        child: const AboutSection(),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: RepaintBoundary(
                      child: CinematicSection(
                        key: _sectionKeys[2],
                        child: const ExperienceSection(),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: RepaintBoundary(
                      child: CinematicSection(
                        key: _sectionKeys[3],
                        child: const WorkSection(),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: RepaintBoundary(
                      child: CinematicSection(
                        key: _sectionKeys[4],
                        child: const ContactSection(),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: RepaintBoundary(child: FooterSection()),
                  ),
                  // Bottom spacing for smoother scroll end
                  const SliverPadding(padding: EdgeInsets.only(bottom: 50)),
                ],
              ),
            ),

            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ValueListenableBuilder<double>(
                valueListenable: _scrollProgress,
                builder: (context, progress, _) {
                  return Container(
                    height: isMobile ? 3 : 4,
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor: progress,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              const Color(0xFF56F3D6).withValues(alpha: 0.95),
                              const Color(0xFF00C2FF).withValues(alpha: 0.95),
                            ],
                          ),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: const Color(
                                0xFF00C2FF,
                              ).withValues(alpha: 0.45),
                              blurRadius: 12,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            PortfolioAppBar(
              items: navItems,
              activeIndex: activeIndex,
              onTap: _scrollToSection,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForSection(String title) {
    switch (title.toLowerCase()) {
      case 'home':
        return Icons.home_rounded;
      case 'about':
        return Icons.person_rounded;
      case 'experience':
        return Icons.work_history_rounded;
      case 'work':
        return Icons.grid_view_rounded;
      case 'contact':
        return Icons.alternate_email_rounded;
      default:
        return Icons.circle;
    }
  }
}
