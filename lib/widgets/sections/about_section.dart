import 'package:flutter/material.dart';

import '../../core/constants/portfolio_data.dart';
import '../common/glass_container.dart';
import '../common/reveal_on_scroll.dart';
import '../common/section_title.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
          child: Column(
            children: [
              // Main Bio Card
              RevealOnScroll(
                child: GlassContainer(
                  padding: const EdgeInsets.all(48),
                  borderRadius: 32,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SectionTitle(
                        title: 'About Me',
                        subtitle: 'Building production-grade applications with purpose',
                      ),
                      const SizedBox(height: 48),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Neon Accent Bar
                          Container(
                            width: 3,
                            height: 140,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFF56F3D6),
                                  Colors.transparent,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(2),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF56F3D6).withValues(alpha: 0.3),
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 40),
                          Expanded(
                            child: Text(
                              aboutText,
                              style: const TextStyle(
                                color: Colors.white,
                                height: 1.8,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              
              // Personal & Hobbies Cards
              RevealOnScroll(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: GlassContainer(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
                        borderRadius: 24,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const _InfoSubTitle(title: 'PERSONAL DETAILS'),
                            const SizedBox(height: 28),
                            const _InfoRow(label: 'Born', value: '02 November 2005'),
                            const _InfoRow(label: 'Nationality', value: 'Indian'),
                            const _InfoRow(label: 'Languages', value: 'English, Hindi, Bengali'),
                            const _InfoRow(label: 'Location', value: 'Kolkata, India'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 32),
                    Expanded(
                      flex: 2,
                      child: GlassContainer(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
                        borderRadius: 24,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const _InfoSubTitle(title: 'BEYOND CODE'),
                            const SizedBox(height: 28),
                            const _HobbyItem(icon: Icons.videocam_rounded, label: 'Content Creator'),
                            const _HobbyItem(icon: Icons.sports_soccer_rounded, label: 'Football & Badminton'),
                            const _HobbyItem(icon: Icons.flight_rounded, label: 'Travel Lifestyle'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoSubTitle extends StatelessWidget {
  const _InfoSubTitle({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFF56F3D6), width: 1.5),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF56F3D6),
          fontWeight: FontWeight.w900,
          fontSize: 12,
          letterSpacing: 2.5,
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label: ',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.35), fontSize: 13),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

class _HobbyItem extends StatelessWidget {
  const _HobbyItem({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF56F3D6), size: 18),
          ),
          const SizedBox(width: 16),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
