import 'package:flutter/material.dart';

import 'glass_container.dart';

class PortfolioNavBar extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final bool isCompact = MediaQuery.sizeOf(context).width < 880;

    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: GlassContainer(
          borderRadius: 999,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: isCompact
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List<Widget>.generate(
                      items.length,
                      (int index) => _NavItem(
                        title: items[index],
                        selected: index == activeIndex,
                        onTap: () => onTap(index),
                      ),
                    ),
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List<Widget>.generate(
                    items.length,
                    (int index) => _NavItem(
                      title: items[index],
                      selected: index == activeIndex,
                      onTap: () => onTap(index),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  const _NavItem({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final Color fg = widget.selected ? Colors.black : Colors.white;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: widget.selected
                ? Colors.white
                : (_hovered
                    ? Colors.white.withValues(alpha: 0.15)
                    : Colors.transparent),
            borderRadius: BorderRadius.circular(999),
            boxShadow: widget.selected
                ? <BoxShadow>[
                    BoxShadow(
                      color: Colors.white.withValues(alpha: 0.3),
                      blurRadius: 16,
                      spreadRadius: -2,
                    ),
                  ]
                : (_hovered
                    ? <BoxShadow>[
                        BoxShadow(
                          color: Colors.white.withValues(alpha: 0.15),
                          blurRadius: 12,
                          spreadRadius: -2,
                        ),
                      ]
                    : <BoxShadow>[]),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(999),
            onTap: widget.onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
              child: Text(
                widget.title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: fg,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
