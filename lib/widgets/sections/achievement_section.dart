import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../core/constants/portfolio_data.dart';
import '../../models/certificate.dart';
import '../common/section_title.dart';
import '../common/perspective_card.dart';

class AchievementSection extends StatelessWidget {
  const AchievementSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool mobile = MediaQuery.sizeOf(context).width < 800;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1300),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SectionTitle(
                title: 'Academic & Professional Credentials',
                subtitle: 'A validation of technical expertise, industrial training, and competitive milestones.',
              ),
              const SizedBox(height: 80),
              
              // Masonry-style Achievement Wall
              LayoutBuilder(
                builder: (context, constraints) {
                  final int crossAxisCount = mobile ? 1 : 3;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: certificates.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 30,
                      childAspectRatio: mobile ? 1.5 : 1.2,
                    ),
                    itemBuilder: (context, index) {
                      return _AchievementCard(
                        certificate: certificates[index],
                        index: index,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AchievementCard extends StatelessWidget {
  const _AchievementCard({required this.certificate, required this.index});
  final Certificate certificate;
  final int index;

  @override
  Widget build(BuildContext context) {
    return PerspectiveCard(
      maxTilt: 0.1,
      child: InkWell(
        onTap: () => _showCertificate(context),
        borderRadius: BorderRadius.circular(28),
        child: GlassmorphicContainer(
          width: double.infinity,
          height: double.infinity,
          borderRadius: 28,
          blur: 15,
          alignment: Alignment.center,
          border: 1.5,
          linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFffffff).withValues(alpha: 0.05),
              const Color(0xFFffffff).withValues(alpha: 0.02),
            ],
          ),
          borderGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF56F3D6).withValues(alpha: 0.3),
              const Color(0xFF00C2FF).withValues(alpha: 0.1),
            ],
          ),
          child: Stack(
            children: [
              // Background Image with subtle zoom
              Positioned.fill(
                child: Container(
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(certificate.imageUrl),
                      fit: BoxFit.cover,
                      opacity: 0.4,
                    ),
                  ),
                ),
              ),
              
              // Overlay Content
              Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF56F3D6).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFF56F3D6).withValues(alpha: 0.2)),
                      ),
                      child: const Icon(Icons.verified_rounded, color: Color(0xFF56F3D6), size: 18),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      certificate.title.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      certificate.issuer,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withValues(alpha: 0.6),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Glow Effect on Top Right
              Positioned(
                top: -20,
                right: -20,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF56F3D6).withValues(alpha: 0.1),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: (index * 150).ms).scale(begin: const Offset(0.9, 0.9));
  }

  void _showCertificate(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.9),
      builder: (context) => Center(
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                constraints: const BoxConstraints(maxWidth: 900, maxHeight: 700),
                margin: const EdgeInsets.all(24),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(certificate.imageUrl, fit: BoxFit.contain),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                certificate.title,
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close_rounded, color: Colors.white, size: 32),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
