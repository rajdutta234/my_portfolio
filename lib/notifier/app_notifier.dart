import 'package:flutter/foundation.dart';

class AppNotifier extends ChangeNotifier {
  int _activeSectionIndex = 0;

  int get activeSectionIndex => _activeSectionIndex;

  set activeSectionIndex(int value) {
    if (_activeSectionIndex == value) {
      return;
    }
    _activeSectionIndex = value;
    notifyListeners();
  }
}