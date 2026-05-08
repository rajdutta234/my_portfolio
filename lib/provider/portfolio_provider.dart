import 'package:flutter/material.dart';
import '../core/constants/portfolio_data.dart';
import '../models/project.dart';

class PortfolioProvider extends ChangeNotifier {
  String _selectedCategory = 'ALL';
  List<Project> _filteredProjects = projects;

  String get selectedCategory => _selectedCategory;
  List<Project> get filteredProjects => _filteredProjects;

  void setCategory(String category) {
    if (_selectedCategory == category) return;
    _selectedCategory = category;
    
    if (category == 'ALL') {
      _filteredProjects = projects;
    } else {
      _filteredProjects = projects.where((p) {
        return p.stack.any((s) => s.toUpperCase().contains(category.toUpperCase()));
      }).toList();
    }
    notifyListeners();
  }
}
