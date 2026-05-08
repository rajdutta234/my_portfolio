import 'package:flutter/material.dart';

import '../../core/constants/portfolio_data.dart';
import '../common/link_utils.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 36),
      child: Column(
        children: <Widget>[
          Wrap(
            spacing: 16,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: () => openExternalLink(context, linkedinUrl),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                child: const Text(
                  'LinkedIn',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => openExternalLink(context, githubUrl),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                child: const Text(
                  'GitHub',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => openExternalLink(context, instagramUrl),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                child: const Text(
                  'Instagram',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => openExternalLink(context, facebookUrl),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                child: const Text(
                  'Facebook',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => openExternalLink(context, 'mailto:$email'),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                child: const Text(
                  'Email',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '© ${DateTime.now().year} $developerName • Full Stack Developer',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontWeight: FontWeight.w400,
                ),
          ),
        ],
      ),
    );
  }
}
