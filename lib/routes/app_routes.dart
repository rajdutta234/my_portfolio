import 'package:flutter/material.dart';
import '../screens/portfolio_page.dart';
import '../widgets/common/cinematic_loader.dart';

class AppRoutes {
  static const String portfolio = '/portfolio';
  static const String loading = '/';
  static const String home = '/portfolio';
  static const String about = '/about';
  static const String skills = '/skills';
  static const String experience = '/experience';
  static const String projects = '/projects';
  static const String certificates = '/certificates';
  static const String achievements = '/achievements';
  static const String work = '/work';
  static const String contact = '/contact';


  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final String? name = settings.name;

    if (name == loading) {
      return MaterialPageRoute<void>(
        builder: (_) => const CinematicLoader(),
        settings: settings,
      );
    }
    if (name == about) {
      return MaterialPageRoute<void>(
        builder: (_) => const PortfolioPage(initialSectionIndex: 1),
        settings: settings,
      );
    }
    if (name == experience) {
      return MaterialPageRoute<void>(
        builder: (_) => const PortfolioPage(initialSectionIndex: 2),
        settings: settings,
      );
    }
    if (name == achievements || name == certificates) {
      return MaterialPageRoute<void>(
        builder: (_) => const PortfolioPage(initialSectionIndex: 4),
        settings: settings,
      );
    }
    if (name == contact) {
      return MaterialPageRoute<void>(
        builder: (_) => const PortfolioPage(initialSectionIndex: 5),
        settings: settings,
      );
    }

    return MaterialPageRoute<void>(
      builder: (_) => const PortfolioPage(),
      settings: settings,
    );
  }
}
