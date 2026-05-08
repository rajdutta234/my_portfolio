import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../core/constants/portfolio_data.dart';
import '../common/reveal_on_scroll.dart';
import '../common/section_title.dart';
import '../common/perspective_card.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool mobile = MediaQuery.sizeOf(context).width < 800;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 120),
          child: Column(
            children: [
              const SectionTitle(
                title: 'Professional Profile',
                subtitle:
                    'A brief overview of my technical journey and engineering philosophy.',
              ),
              const SizedBox(height: 80),

              // Main Bio Card
              RevealOnScroll(
                child: Stack(
                  children: [
                    GlassmorphicContainer(
                      width: double.infinity,
                      height: mobile ? 700 : 400,
                      borderRadius: 32,
                      blur: 20,
                      alignment: Alignment.center,
                      border: 1.5,
                      linearGradient: LinearGradient(
                        colors: [
                          const Color(0xFFffffff).withValues(alpha: 0.05),
                          const Color(0xFFffffff).withValues(alpha: 0.02),
                        ],
                      ),
                      borderGradient: LinearGradient(
                        colors: [
                          const Color(0xFF56F3D6).withValues(alpha: 0.3),
                          Colors.transparent,
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(mobile ? 24 : 48),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (!mobile) ...[
                              _buildProfileIcon(),
                              const SizedBox(width: 48),
                            ],
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'THE ENGINEER BEHIND THE CODE',
                                    style: TextStyle(
                                      color: const Color(0xFF56F3D6),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 4,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Text(
                                    aboutText,
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.8),
                                      height: 1.8,
                                      fontSize: mobile ? 16 : 18,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    // Lighting Sweep
                    Positioned.fill(
                      child: IgnorePointer(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ).animate(onPlay: (c) => c.repeat())
                          .shimmer(
                            duration: 5.seconds,
                            color: Colors.white.withValues(alpha: 0.03),
                            angle: 45,
                          ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Stats Dashboard
              RevealOnScroll(child: _StatsDashboard(mobile: mobile)),

              const SizedBox(height: 40),

              // Personal & Hobbies Cards
              RevealOnScroll(
                child: mobile
                    ? Column(
                        children: [
                          _PersonalInfoCard(),
                          const SizedBox(height: 24),
                          _HobbiesCard(),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _PersonalInfoCard()),
                          const SizedBox(width: 40),
                          Expanded(child: _HobbiesCard()),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileIcon() {
    return Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            color: const Color(0xFF56F3D6).withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              color: const Color(0xFF56F3D6).withValues(alpha: 0.2),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Image.asset(
              'assets/images/profile_picture_photo.jpeg',
              fit: BoxFit.cover,
            ),
          ),
        )
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .moveY(
          begin: -10,
          end: 10,
          duration: 3.seconds,
          curve: Curves.easeInOut,
        );
  }
}

class _StatsDashboard extends StatelessWidget {
  const _StatsDashboard({required this.mobile});
  final bool mobile;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 24,
      runSpacing: 24,
      children: [
        _buildStatItem('1+', 'YEARS EXP', Icons.bolt_rounded),
        _buildStatItem('12+', 'PROJECTS', Icons.rocket_launch_rounded),
        _buildStatItem('5+', 'CERTIFICATES', Icons.verified_rounded),
        _buildStatItem('100%', 'COMMITMENT', Icons.favorite_rounded),
      ],
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return PerspectiveCard(
      maxTilt: 0.15,
      child: GlassmorphicContainer(
        width: mobile ? double.infinity : 270,
        height: 140,
        borderRadius: 24,
        blur: 15,
        alignment: Alignment.center,
        border: 1,
        linearGradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.05),
            Colors.white.withValues(alpha: 0.02),
          ],
        ),
        borderGradient: const LinearGradient(
          colors: [Colors.white24, Colors.transparent],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFF56F3D6), size: 32),
            const SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withValues(alpha: 0.5),
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PersonalInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 320,
      borderRadius: 24,
      blur: 20,
      alignment: Alignment.center,
      border: 1.5,
      linearGradient: LinearGradient(
        colors: [
          Colors.white.withValues(alpha: 0.05),
          Colors.white.withValues(alpha: 0.02),
        ],
      ),
      borderGradient: const LinearGradient(
        colors: [Colors.white10, Colors.transparent],
      ),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader('IDENTIFICATION'),
            const SizedBox(height: 32),
            _buildRow('NAME', developerName),
            _buildRow('BORN', '02 NOV 2005'),
            _buildRow('CITY', 'KOLKATA, IND'),
            _buildRow('STATUS', 'BCA STUDENT'),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF56F3D6),
        fontSize: 11,
        fontWeight: FontWeight.bold,
        letterSpacing: 3,
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white38,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _HobbiesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 320,
      borderRadius: 24,
      blur: 20,
      alignment: Alignment.center,
      border: 1.5,
      linearGradient: LinearGradient(
        colors: [
          Colors.white.withValues(alpha: 0.05),
          Colors.white.withValues(alpha: 0.02),
        ],
      ),
      borderGradient: const LinearGradient(
        colors: [Colors.white10, Colors.transparent],
      ),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'BEYOND CODE',
              style: TextStyle(
                color: Color(0xFF56F3D6),
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
              ),
            ),
            const SizedBox(height: 32),
            _buildHobby(Icons.videocam_rounded, 'CONTENT CREATION'),
            _buildHobby(Icons.sports_soccer_rounded, 'SPORTS (FOOTBALL)'),
            _buildHobby(Icons.flight_rounded, 'TRAVEL & EXPLORATION'),
            _buildHobby(Icons.music_note_rounded, 'LO-FI ENTHUSIAST'),
          ],
        ),
      ),
    );
  }

  Widget _buildHobby(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF56F3D6), size: 20),
          const SizedBox(width: 16),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
