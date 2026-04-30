import 'dart:async';

import 'package:flutter/material.dart';

class TypingText extends StatefulWidget {
  const TypingText({
    super.key,
    required this.words,
    this.typingDelay = const Duration(milliseconds: 85),
    this.holdDelay = const Duration(milliseconds: 1100),
  });

  final List<String> words;
  final Duration typingDelay;
  final Duration holdDelay;

  @override
  State<TypingText> createState() => _TypingTextState();
}

class _TypingTextState extends State<TypingText> {
  Timer? _timer;
  String _value = '';
  int _wordIndex = 0;
  int _charIndex = 0;
  bool _deleting = false;

  @override
  void initState() {
    super.initState();
    _tick();
  }

  void _tick() {
    _timer?.cancel();
    _timer = Timer(widget.typingDelay, () {
      if (!mounted || widget.words.isEmpty) {
        return;
      }

      final String current = widget.words[_wordIndex];

      setState(() {
        if (!_deleting) {
          _charIndex++;
          _value = current.substring(0, _charIndex.clamp(0, current.length));
          if (_charIndex >= current.length) {
            _deleting = true;
            _timer?.cancel();
            _timer = Timer(widget.holdDelay, _tick);
            return;
          }
        } else {
          _charIndex--;
          _value = current.substring(0, _charIndex.clamp(0, current.length));
          if (_charIndex <= 0) {
            _deleting = false;
            _wordIndex = (_wordIndex + 1) % widget.words.length;
          }
        }
      });

      _tick();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Colors.white70,
          letterSpacing: 0.3,
        ),
        children: <InlineSpan>[
          TextSpan(text: _value),
          const TextSpan(text: ' |', style: TextStyle(color: Colors.white54)),
        ],
      ),
    );
  }
}
