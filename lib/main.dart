import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'notifier/app_notifier.dart';
import 'routes/app_routes.dart';
import 'screens/portfolio_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppNotifier>(
      create: (_) => AppNotifier(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Raj Dutta | Portfolio',
        theme: AppTheme.darkTheme,
        initialRoute: AppRoutes.home,
        onGenerateRoute: (RouteSettings settings) {
          final String? name = settings.name;
          if (name == AppRoutes.about) {
            return MaterialPageRoute<void>(
              builder: (_) => const PortfolioPage(initialSectionIndex: 1),
              settings: settings,
            );
          }
          if (name == AppRoutes.skills) {
            return MaterialPageRoute<void>(
              builder: (_) => const PortfolioPage(initialSectionIndex: 2),
              settings: settings,
            );
          }
          if (name == AppRoutes.experience) {
            return MaterialPageRoute<void>(
              builder: (_) => const PortfolioPage(initialSectionIndex: 3),
              settings: settings,
            );
          }
          if (name == AppRoutes.projects) {
            return MaterialPageRoute<void>(
              builder: (_) => const PortfolioPage(initialSectionIndex: 4),
              settings: settings,
            );
          }
          if (name == AppRoutes.certificates) {
            return MaterialPageRoute<void>(
              builder: (_) => const PortfolioPage(initialSectionIndex: 5),
              settings: settings,
            );
          }
          if (name == AppRoutes.contact) {
            return MaterialPageRoute<void>(
              builder: (_) => const PortfolioPage(initialSectionIndex: 6),
              settings: settings,
            );
          }

          return MaterialPageRoute<void>(
            builder: (_) => const PortfolioPage(),
            settings: settings,
          );
        },
      ),
    );
  }
}
