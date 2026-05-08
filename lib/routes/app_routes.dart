import 'package:go_router/go_router.dart';
import '../screens/portfolio_page.dart';
import '../widgets/common/cinematic_loader.dart';

class AppRoutes {
  static const String root = '/';
  static const String portfolio = '/portfolio';
  static const String about = '/about';
  static const String experience = '/experience';
  static const String work = '/work';
  static const String contact = '/contact';

  static final router = GoRouter(
    initialLocation: root,
    routes: [
      GoRoute(
        path: root,
        builder: (context, state) => const CinematicLoader(),
      ),
      GoRoute(
        path: portfolio,
        builder: (context, state) => const PortfolioPage(),
      ),
      GoRoute(
        path: about,
        builder: (context, state) => const PortfolioPage(initialSectionIndex: 1),
      ),
      GoRoute(
        path: experience,
        builder: (context, state) => const PortfolioPage(initialSectionIndex: 2),
      ),
      GoRoute(
        path: work,
        builder: (context, state) => const PortfolioPage(initialSectionIndex: 3),
      ),
      GoRoute(
        path: contact,
        builder: (context, state) => const PortfolioPage(initialSectionIndex: 4),
      ),
    ],
    errorBuilder: (context, state) => const PortfolioPage(),
  );
}