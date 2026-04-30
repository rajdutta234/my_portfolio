import 'package:flutter/material.dart';

import '../../core/constants/portfolio_data.dart';
import '../common/glass_container.dart';
import '../common/link_utils.dart';
import '../common/typing_text.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.onViewProjects,
  });

  final VoidCallback onViewProjects;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final bool mobile = size.width < 700;

    return SizedBox(
      height: size.height,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: mobile ? 20 : 36,
              vertical: 24,
            ),
            child: GlassContainer(
              borderRadius: 28,
              padding: EdgeInsets.symmetric(
                horizontal: mobile ? 22 : 40,
                vertical: mobile ? 26 : 42,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment:
                    mobile ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    developerName,
                    textAlign: mobile ? TextAlign.left : TextAlign.center,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                          height: 1.1,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    developerTitle,
                    textAlign: mobile ? TextAlign.left : TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                  ),
                  const SizedBox(height: 20),
                  const TypingText(
                    words: <String>[
                      tagline,
                      'Full-stack architecture with clean UX',
                      'AI-aware web products for real users',
                    ],
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: 700,
                    child: Text(
                      tagline,
                      textAlign: mobile ? TextAlign.left : TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white.withValues(alpha: 0.7),
                            height: 1.6,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.2,
                          ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Wrap(
                    spacing: 14,
                    runSpacing: 12,
                    alignment: mobile ? WrapAlignment.start : WrapAlignment.center,
                    children: <Widget>[
                      FilledButton(
                        onPressed: onViewProjects,
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 18,
                          ),
                          elevation: 12,
                          shadowColor: Colors.white.withValues(alpha: 0.3),
                        ),
                        child: const Text(
                          'View Projects',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () => openExternalLink(context, resumeUrl),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: Colors.white.withValues(alpha: 0.5),
                            width: 2,
                          ),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 18,
                          ),
                        ),
                        child: const Text(
                          'Download Resume',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
