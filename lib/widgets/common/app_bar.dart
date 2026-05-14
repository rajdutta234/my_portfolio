import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/responsive.dart';
import 'glass_container.dart';
import 'magnetic.dart';

class PortfolioAppBar extends StatelessWidget {
  const PortfolioAppBar({
    super.key,
    required this.items,
    required this.activeIndex,
    required this.onTap,
  });

  final List<String> items;
  final int activeIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    if (isMobile) {
      return _buildMobileAppBar(context);
    }

    return _buildDesktopIsland(context);
  }

  Widget _buildMobileAppBar(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: GlassContainer(
            borderRadius: 999,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.menu_rounded, color: Color(0xFF56F3D6), size: 24),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ).animate().scale(delay: 100.ms),
                const SizedBox(width: 8),
                Container(
                  height: 20,
                  width: 1,
                  color: Colors.white10,
                ),
                const SizedBox(width: 16),
                ...List.generate(items.length, (index) {
                  final bool isSelected = index == activeIndex;
                  return _MobileNavItem(
                    icon: _getIconForSection(items[index]),
                    isSelected: isSelected,
                    onTap: () => onTap(index),
                  ).animate().fadeIn(delay: (200 + index * 50).ms).slideX(begin: 0.2);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopIsland(BuildContext context) {
    final double screenHeight = MediaQuery.sizeOf(context).height;
    // Dynamic height based on items but capped to screen height. Reduced spacing for a sleeker profile.
    final double targetHeight = (items.length * 54.0) + 100;
    final double actualHeight = targetHeight.clamp(200.0, screenHeight * 0.85);

    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 24),
        child: Container(
          width: 70, // Slightly thinner for elegance
          height: actualHeight,
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          // Removed ClipRRect and AnimatedPositioned tracking pill
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                children: [
                  const SizedBox(height: 20),
                  // Logo
                  Magnetic(
                    child: GestureDetector(
                      onTap: () => onTap(0),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF56F3D6), Color(0xFF00C2FF)],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.code_rounded, color: Colors.black, size: 22),
                      ),
                    ),
                  ).animate().scale(duration: 600.ms, curve: Curves.easeOutBack),
                  
                  const SizedBox(height: 10),
                  
                  // Scrollable area with Clip.none to allow tooltips to overflow
                  Expanded(
                    child: SingleChildScrollView(
                      clipBehavior: Clip.none,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(items.length, (index) {
                          return Magnetic(
                            child: _DesktopNavItem(
                              title: items[index],
                              icon: _getIconForSection(items[index]),
                              isSelected: index == activeIndex,
                              onTap: () => onTap(index),
                            ),
                          ).animate().fadeIn(delay: (300 + index * 80).ms).slideY(begin: 0.1);
                        }),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.3),
    );
  }

  IconData _getIconForSection(String title) {
    switch (title.toLowerCase()) {
      case 'home': return Icons.home_rounded;
      case 'about': return Icons.person_rounded;
      case 'experience': return Icons.work_history_rounded;
      case 'work': return Icons.grid_view_rounded;
      case 'contact': return Icons.alternate_email_rounded;
      default: return Icons.circle;
    }
  }
}

class _DesktopNavItem extends StatefulWidget {
  const _DesktopNavItem({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<_DesktopNavItem> createState() => _DesktopNavItemState();
}

class _DesktopNavItemState extends State<_DesktopNavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: SizedBox(
          width: 70,
          height: 54, // Reduced fixed height for a tighter app bar
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              // Icon with Hover & Active Color Animation
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  widget.icon,
                  key: ValueKey('icon_${widget.isSelected}_$_isHovered'),
                  color: widget.isSelected || _isHovered
                      ? const Color(0xFF56F3D6)
                      : Colors.white24,
                  size: widget.isSelected || _isHovered ? 26 : 22,
                ),
              ),

              // Active Indicator Dot
              if (widget.isSelected)
                Positioned(
                  right: 8,
                  child: Container(
                    width: 5,
                    height: 5,
                    decoration: const BoxDecoration(
                      color: Color(0xFF56F3D6),
                      shape: BoxShape.circle,
                    ),
                  ).animate(onPlay: (c) => c.repeat()).scale(
                        begin: const Offset(1, 1),
                        end: const Offset(1.6, 1.6),
                        duration: 1.seconds,
                      ).fadeIn(),
                ),

              // Modern Tooltip Label
              if (_isHovered)
                Positioned(
                  left: 75, // Push label completely outside the right edge
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0C1422).withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFF56F3D6).withValues(alpha: 0.3),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF56F3D6).withValues(alpha: 0.15),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      widget.title.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 200.ms)
                      .slideX(begin: -0.15, curve: Curves.easeOutCubic),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileNavItem extends StatelessWidget {
  const _MobileNavItem({
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFF56F3D6) : Colors.white24,
              size: 20,
            ),
            const SizedBox(height: 2),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: isSelected ? 4 : 0,
              height: 4,
              decoration: const BoxDecoration(
                color: Color(0xFF56F3D6),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
