import 'package:flutter/material.dart';

import '../../core/constants/portfolio_data.dart';
import '../common/glass_container.dart';
import '../common/link_utils.dart';
import '../common/typing_text.dart';
import '../common/video_background.dart';

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
      child: Stack(
        children: [
          const VideoBackground(
            assetPath: 'assets/videos/tech_video.mp4',
            opacity: 0.15,
          ),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1120),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: mobile ? 20 : 36,
                  vertical: 24,
                ),
                child: GlassContainer(
                  borderRadius: 32,
                  padding: EdgeInsets.symmetric(
                    horizontal: mobile ? 22 : 40,
                    vertical: mobile ? 26 : 42,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: mobile
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.center,
                    children: <Widget>[
                      // Profile Image
                      Container(
                        width: mobile ? 100 : 140,
                        height: mobile ? 100 : 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.2),
                            width: 4,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withValues(alpha: 0.3),
                              blurRadius: 30,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/profile.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.person,
                                    size: 60, color: Colors.white24),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        developerName,
                        textAlign: mobile ? TextAlign.left : TextAlign.center,
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1,
                              height: 1.1,
                              color: Colors.white,
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
                      const SizedBox(height: 32),
                      Wrap(
                        spacing: 16,
                        runSpacing: 14,
                        alignment:
                            mobile ? WrapAlignment.start : WrapAlignment.center,
                        children: <Widget>[
                          FilledButton(
                            onPressed: onViewProjects,
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 36,
                                vertical: 20,
                              ),
                              elevation: 12,
                              shadowColor: Colors.white.withValues(alpha: 0.3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              'View Projects',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                                fontSize: 16,
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
                                horizontal: 36,
                                vertical: 20,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              'Download Resume',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                                fontSize: 16,
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
        ],
      ),
    );
  }
}
