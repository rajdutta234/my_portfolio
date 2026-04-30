import 'package:flutter/material.dart';

class RevealOnScroll extends StatefulWidget {
  const RevealOnScroll({
    super.key,
    required this.child,
    this.offset = const Offset(0, 0.08),
    this.duration = const Duration(milliseconds: 650),
  });

  final Widget child;
  final Offset offset;
  final Duration duration;

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll> {
  bool _isVisible = false;
  ScrollPosition? _position;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ScrollableState? scrollable = Scrollable.maybeOf(context);
    final ScrollPosition? next = scrollable?.position;

    if (_position != next) {
      _position?.removeListener(_checkVisibility);
      _position = next;
      _position?.addListener(_checkVisibility);
      WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());
    }
  }

  void _checkVisibility() {
    if (_isVisible || !mounted) {
      return;
    }

    final RenderObject? object = context.findRenderObject();
    if (object is! RenderBox || !object.attached) {
      return;
    }

    final Size size = object.size;
    final Offset global = object.localToGlobal(Offset.zero);
    final double viewportHeight = MediaQuery.sizeOf(context).height;

    final bool visible = global.dy < viewportHeight * 0.88 &&
        global.dy + size.height > viewportHeight * 0.1;

    if (visible) {
      setState(() {
        _isVisible = true;
      });
      _position?.removeListener(_checkVisibility);
    }
  }

  @override
  void dispose() {
    _position?.removeListener(_checkVisibility);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      duration: widget.duration,
      curve: Curves.easeOutCubic,
      offset: _isVisible ? Offset.zero : widget.offset,
      child: AnimatedOpacity(
        duration: widget.duration,
        curve: Curves.easeOut,
        opacity: _isVisible ? 1 : 0,
        child: widget.child,
      ),
    );
  }
}
