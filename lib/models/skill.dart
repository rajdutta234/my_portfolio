import 'package:flutter/material.dart';

class SkillItem {
  const SkillItem({
    required this.name,
    required this.icon,
    required this.proficiency,
  });

  final String name;
  final IconData icon;
  final double proficiency;
}

class SkillCategory {
  const SkillCategory({
    required this.title,
    required this.skills,
    required this.icon,
  });

  final String title;
  final List<SkillItem> skills;
  final IconData icon;
}

