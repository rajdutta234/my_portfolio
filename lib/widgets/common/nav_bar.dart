import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'glass_container.dart';
import '../../core/responsive.dart';
import '../../provider/portfolio_provider.dart';

class PortfolioNavBar extends ConsumerStatefulWidget {
  const PortfolioNavBar({
    super.key,
    required this.items,
    required this.activeIndex,
    required this.onTap,
  });

  final List<String> items;
  final int activeIndex;
  final ValueChanged<int> onTap;

  @override
  ConsumerState<PortfolioNavBar> createState() => _PortfolioNavBarState();
}

class _PortfolioNavBarState extends ConsumerState<PortfolioNavBar> {
  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    if (isMobile) {
      return Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Menu Button to open Drawer
              GlassContainer(
                borderRadius: 999,
                padding: const EdgeInsets.all(8),
                child: IconButton(
                  icon: const Icon(Icons.menu_rounded, color: Color(0xFF56F3D6)),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GlassContainer(
                  borderRadius: 999,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: _MobileNav(
                    items: widget.items,
                    activeIndex: widget.activeIndex,
                    onTap: widget.onTap,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 24),
        child: Container(
          width: 70,
          padding: const EdgeInsets.symmetric(vertical: 24),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(35),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logo/Home Icon
              _buildHomeIcon(),
              const SizedBox(height: 40),
              // Nav Items
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  // Modern Sliding Indicator
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.elasticOut,
                    top: widget.activeIndex * 72.0 + 12,
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFF56F3D6).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF56F3D6).withValues(alpha: 0.2),
                            blurRadius: 20,
                          ),
                        ],
                        border: Border.all(
                          color: const Color(0xFF56F3D6).withValues(alpha: 0.4),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(widget.items.length, (index) {
                      return _VerticalNavItem(
                        title: widget.items[index],
                        isSelected: index == widget.activeIndex,
                        onTap: () => widget.onTap(index),
                        icon: _getIconForSection(widget.items[index]),
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHomeIcon() {
    return InkWell(
      onTap: () => widget.onTap(0),
      onHover: (hovering) {
        ref.read(cursorHoverProvider.notifier).set(hovering);
      },
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF56F3D6), Color(0xFF00C2FF)],
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF56F3D6).withValues(alpha: 0.3),
              blurRadius: 15,
            ),
          ],
        ),
        child: const Icon(Icons.code_rounded, color: Colors.black, size: 24),
      ),
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

class _VerticalNavItem extends ConsumerWidget {
  const _VerticalNavItem({
    required this.title,
    required this.isSelected,
    required this.onTap,
    required this.icon,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Tooltip(
      message: title.toUpperCase(),
      preferBelow: false,
      margin: const EdgeInsets.only(left: 80),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: InkWell(
          onTap: onTap,
          onHover: (hovering) {
            ref.read(cursorHoverProvider.notifier).set(hovering);
          },
          borderRadius: BorderRadius.circular(15),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              icon,
              color: isSelected ? const Color(0xFF56F3D6) : Colors.white54,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileNav extends StatelessWidget {
  const _MobileNav({
    required this.items,
    required this.activeIndex,
    required this.onTap,
  });

  final List<String> items;
  final int activeIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(items.length, (index) {
          final bool isSelected = index == activeIndex;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: isSelected ? 4 : 2),
            child: InkWell(
              onTap: () => onTap(index),
              borderRadius: BorderRadius.circular(16),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutCubic,
                padding: EdgeInsets.symmetric(
                  horizontal: isSelected ? 12 : 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF56F3D6).withValues(alpha: 0.12)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF56F3D6).withValues(alpha: 0.2)
                        : Colors.transparent,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _getIconForSection(items[index]),
                      color: isSelected ? const Color(0xFF56F3D6) : Colors.white38,
                      size: 18,
                    ),
                    if (isSelected) ...[
                      const SizedBox(width: 6),
                      Text(
                        items[index].toUpperCase(),
                        style: const TextStyle(
                          color: Color(0xFF56F3D6),
                          fontWeight: FontWeight.w900,
                          fontSize: 9,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        }),
      ),
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
