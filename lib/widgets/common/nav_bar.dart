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
  final Map<int, GlobalKey> _itemKeys = {};

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.items.length; i++) {
      _itemKeys[i] = GlobalKey();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final bool mobile = size.width < 760;
    final bool isCompact = size.width < 980;

    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: GlassContainer(
          borderRadius: 999,
          padding: EdgeInsets.symmetric(
            horizontal: mobile ? 12 : 10,
            vertical: mobile ? 10 : 8,
          ),
          child: mobile
              ? _MobileNav(
                  items: widget.items,
                  activeIndex: widget.activeIndex,
                  onTap: widget.onTap,
                )
              : Stack(
                  children: <Widget>[
                    _AnimatedIndicator(
                      activeIndex: widget.activeIndex,
                      itemKeys: _itemKeys,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: isCompact
                          ? null
                          : const NeverScrollableScrollPhysics(),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: _buildItems(),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  List<Widget> _buildItems() {
    return List<Widget>.generate(
      widget.items.length,
      (int index) => _NavItem(
        key: _itemKeys[index],
        title: widget.items[index],
        selected: index == widget.activeIndex,
        onTap: () => widget.onTap(index),
      ),
    );
  }
}

class _AnimatedIndicator extends StatelessWidget {
  const _AnimatedIndicator({required this.activeIndex, required this.itemKeys});
  final int activeIndex;
  final Map<int, GlobalKey> itemKeys;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([]), // We'll rely on build triggers
      builder: (context, child) {
        final RenderBox? box =
            itemKeys[activeIndex]?.currentContext?.findRenderObject()
                as RenderBox?;
        if (box == null) return const SizedBox.shrink();

        final RenderBox? parent = box.parent as RenderBox?;
        if (parent == null) return const SizedBox.shrink();

        final Offset offset = box.localToGlobal(Offset.zero, ancestor: parent);
        final Size size = box.size;

        return AnimatedPositioned(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOutBack,
          left: offset.dx,
          top: offset.dy,
          width: size.width,
          height: size.height,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(999),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.3),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _NavItem extends StatefulWidget {
  const _NavItem({
    super.key,
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
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: TextStyle(
            color: widget.selected ? Colors.black : Colors.white70,
            fontWeight: FontWeight.w800,
            fontSize: 13,
            letterSpacing: 0.8,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Text(widget.title.toUpperCase()),
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
        Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            color: Color(0xFF56F3D6),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          items[activeIndex].toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0,
            fontSize: 13,
          ),
        ),
        const Spacer(),
        PopupMenuButton<int>(
          tooltip: 'Navigate sections',
          icon: const Icon(Icons.grid_view_rounded, size: 20),
          color: const Color(0xFF101B2D),
          onSelected: onTap,
          itemBuilder: (BuildContext context) {
            return List<PopupMenuEntry<int>>.generate(
              items.length,
              (int index) => PopupMenuItem<int>(
                value: index,
                child: Text(
                  items[index],
                  style: TextStyle(
                    color: index == activeIndex
                        ? const Color(0xFF56F3D6)
                        : Colors.white,
                    fontWeight: index == activeIndex
                        ? FontWeight.w700
                        : FontWeight.w500,
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
