import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/portfolio_data.dart';
import '../models/project.dart';

class PortfolioState {
  final String selectedCategory;
  final List<Project> filteredProjects;

  PortfolioState({
    required this.selectedCategory,
    required this.filteredProjects,
  });

  PortfolioState copyWith({
    String? selectedCategory,
    List<Project>? filteredProjects,
  }) {
    return PortfolioState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      filteredProjects: filteredProjects ?? this.filteredProjects,
    );
  }
}

class PortfolioNotifier extends Notifier<PortfolioState> {
  @override
  PortfolioState build() {
    return PortfolioState(
      selectedCategory: 'ALL',
      filteredProjects: projects,
    );
  }

  void setCategory(String category) {
    if (state.selectedCategory == category) return;
    
    List<Project> filtered;
    if (category == 'ALL') {
      filtered = projects;
    } else {
      filtered = projects.where((p) {
        return p.stack.any((s) => s.toUpperCase().contains(category.toUpperCase()));
      }).toList();
    }
    
    state = state.copyWith(
      selectedCategory: category,
      filteredProjects: filtered,
    );
  }
}

final portfolioProvider = NotifierProvider<PortfolioNotifier, PortfolioState>(() {
  return PortfolioNotifier();
});

// App Navigation state Notifiers
class ActiveSectionNotifier extends Notifier<int> {
  @override
  int build() => 0;
  void set(int value) => state = value;
}

final activeSectionProvider = NotifierProvider<ActiveSectionNotifier, int>(() {
  return ActiveSectionNotifier();
});

class CursorHoverNotifier extends Notifier<bool> {
  @override
  bool build() => false;
  void set(bool value) => state = value;
}

final cursorHoverProvider = NotifierProvider<CursorHoverNotifier, bool>(() {
  return CursorHoverNotifier();
});
