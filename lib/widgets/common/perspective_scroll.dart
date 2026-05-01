import 'package:flutter/material.dart';

class PerspectiveScroll extends StatefulWidget {
  const PerspectiveScroll({super.key, required this.child});
  final Widget child;

  @override
  State<PerspectiveScroll> createState() => _PerspectiveScrollState();
}

class _PerspectiveScrollState extends State<PerspectiveScroll> {
  ScrollPosition? _scrollPosition;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _removeListener();
    _scrollPosition = Scrollable.maybeOf(context)?.position;
    _addListener();
  }

  void _addListener() {
    _scrollPosition?.addListener(_onScroll);
  }

  void _removeListener() {
    _scrollPosition?.removeListener(_onScroll);
  }

  void _onScroll() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _removeListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final RenderBox? box = context.findRenderObject() as RenderBox?;
        double skew = 0.0;

        if (box != null && box.hasSize && _scrollPosition != null) {
          final double viewportHeight = _scrollPosition!.viewportDimension;
          final double widgetY = box.localToGlobal(Offset.zero).dy;
          final double progress = (widgetY / viewportHeight).clamp(-0.2, 1.2);
          skew = (progress - 0.5) * 0.1;
        }

        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(skew),
          alignment: Alignment.center,
          child: widget.child,
        );
      },
    );
  }
}
