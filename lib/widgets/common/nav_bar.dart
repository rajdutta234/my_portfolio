import 'package:flutter/material.dart';
import 'glass_container.dart';

class PortfolioNavBar extends StatefulWidget {
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
  State<PortfolioNavBar> createState() => _PortfolioNavBarState();
}

class _PortfolioNavBarState extends State<PortfolioNavBar> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final bool mobile = size.width < 760;

    if (mobile) {
      return Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(16),
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
              ...List.generate(widget.items.length, (index) {
                return _VerticalNavItem(
                  title: widget.items[index],
                  isSelected: index == widget.activeIndex,
                  onTap: () => widget.onTap(index),
                  icon: _getIconForSection(widget.items[index]),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHomeIcon() {
    return Container(
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

class _VerticalNavItem extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Tooltip(
      message: title.toUpperCase(),
      preferBelow: false,
      margin: const EdgeInsets.only(left: 80),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF56F3D6).withValues(alpha: 0.1) : Colors.transparent,
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
    return Row(
      children: <Widget>[
        const Icon(Icons.code_rounded, color: Color(0xFF56F3D6), size: 18),
        const SizedBox(width: 12),
        Text(
          items[activeIndex].toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            letterSpacing: 2.0,
            fontSize: 12,
            color: Colors.white,
          ),
        ),
        const Spacer(),
        PopupMenuButton<int>(
          tooltip: 'Navigate',
          icon: const Icon(Icons.menu_rounded, color: Colors.white, size: 24),
          color: const Color(0xFF020C1B),
          onSelected: onTap,
          itemBuilder: (BuildContext context) {
            return List<PopupMenuEntry<int>>.generate(
              items.length,
              (int index) => PopupMenuItem<int>(
                value: index,
                child: Text(
                  items[index].toUpperCase(),
                  style: TextStyle(
                    color: index == activeIndex ? const Color(0xFF56F3D6) : Colors.white70,
                    fontWeight: index == activeIndex ? FontWeight.w900 : FontWeight.w500,
                    fontSize: 11,
                    letterSpacing: 1,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
