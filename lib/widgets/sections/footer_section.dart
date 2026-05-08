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
            color: const Color(0xFF56F3D6).withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF56F3D6).withValues(alpha: 0.02),
            Colors.transparent,
          ],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 80),
      child: Column(
        children: <Widget>[
          // Glowing Social Links
          Wrap(
            spacing: 24,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: <Widget>[
              _buildSocialLink(context, 'LINKEDIN', linkedinUrl),
              _buildSocialLink(context, 'GITHUB', githubUrl),
              _buildSocialLink(context, 'INSTAGRAM', instagramUrl),
              _buildSocialLink(context, 'FACEBOOK', facebookUrl),
              _buildSocialLink(context, 'EMAIL', 'mailto:$email'),
            ],
          ),
          const SizedBox(height: 60),

          Text(
            'DESIGNED & ENGINEERED BY $developerName',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 4,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '',
            style: TextStyle(
              color: const Color(0xFF56F3D6).withValues(alpha: 0.4),
              fontSize: 9,
              fontFamily: 'monospace',
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialLink(BuildContext context, String label, String url) {
    return InkWell(
      onTap: () => openExternalLink(context, url),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF56F3D6).withValues(alpha: 0.1),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}
