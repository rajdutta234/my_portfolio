import 'package:flutter/foundation.dart';

class AppNotifier extends ChangeNotifier {
  int _activeSectionIndex = 0;
  bool _isCursorHovering = false;

  int get activeSectionIndex => _activeSectionIndex;
  bool get isCursorHovering => _isCursorHovering;

  set activeSectionIndex(int value) {
    if (_activeSectionIndex == value) return;
    _activeSectionIndex = value;
    notifyListeners();
  }

  set isCursorHovering(bool value) {
    if (_isCursorHovering == value) return;
    _isCursorHovering = value;
    notifyListeners();
  }
}