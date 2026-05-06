import 'package:flutter/material.dart';
import '../screens/portfolio_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String about = '/about';
  static const String skills = '/skills';
  static const String experience = '/experience';
  static const String projects = '/projects';
  static const String certificates = '/certificates';
  static const String work = '/work';
  static const String contact = '/contact';


  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final String? name = settings.name;

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
    if (name == work || name == projects || name == skills || name == certificates) {
      return MaterialPageRoute<void>(
        builder: (_) => const PortfolioPage(initialSectionIndex: 3),
        settings: settings,
      );
    }
    if (name == contact) {
      return MaterialPageRoute<void>(
        builder: (_) => const PortfolioPage(initialSectionIndex: 4),
        settings: settings,
      );
    }

    return MaterialPageRoute<void>(
      builder: (_) => const PortfolioPage(),
      settings: settings,
    );
  }
}
