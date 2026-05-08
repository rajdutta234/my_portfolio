import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

import '../../core/constants/portfolio_data.dart';
import '../common/link_utils.dart';
import '../common/parallax_layer.dart';
import '../common/magnetic.dart';
import '../common/perspective_card.dart';
import '../common/developer_terminal.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key, required this.onViewProjects});

  final VoidCallback onViewProjects;

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  Offset _mousePosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final bool mobile = size.width < 800;
    final double heroHeight = size.height < 800 ? 800 : size.height;

    return MouseRegion(
      onHover: (event) => setState(() => _mousePosition = event.position),
      child: Container(
        constraints: BoxConstraints(minHeight: heroHeight),
        child: Stack(
          children: [
            // 3D Model Background (Cinematic Workspace)
            if (!mobile)
              Positioned(
                right: -100,
                top: 0,
                bottom: 0,
                width: size.width * 0.6,
                child: Opacity(
                  opacity: 0.6,
                  child: ModelViewer(
                    src:
                        'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
                    alt: 'Developer Workspace',
                    autoRotate: true,
                    cameraControls: false,
                    disableZoom: true,
                    shadowIntensity: 1,
                    environmentImage: 'neutral',
                  ),
                ),
              ).animate().fadeIn(duration: 2.seconds),

            // Deep Background Parallax Layers
            ParallaxLayer(
              speed: 0.01,
              mousePosition: _mousePosition,
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(-0.7, -0.6),
                    radius: 1.2,
                    colors: [
                      const Color(0xFF56F3D6).withValues(alpha: 0.08),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Hero Content Area
            Align(
              alignment: Alignment.topLeft,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 1200,
                  minHeight: heroHeight,
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: mobile ? 20 : 250,
                    right: mobile ? 20 : 40,
                    top: mobile ? 80 : 140,
                    bottom: 40,
                  ),
                  child: mobile
                      ? _buildMobileLayout(context)
                      : _buildDesktopLayout(context, size),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, Size size) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Left Column: Identity & Terminal
        Expanded(
          flex: 5,
          child: PerspectiveCard(
            maxTilt: 0.03,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildIdentity(context),
                const SizedBox(height: 40),
                const DeveloperTerminal(),
                const SizedBox(height: 40),
                _buildActionButtons(context),
              ],
            ),
          ),
        ),

        // Right Column: Holographic Profile
        Expanded(
          flex: 4,
          child: Center(child: _buildHolographicProfile(context)),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 60),
          _buildHolographicProfile(context),
          const SizedBox(height: 40),
          _buildIdentity(context),
          const SizedBox(height: 30),
          _buildActionButtons(context),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildIdentity(BuildContext context) {
    final bool mobile = MediaQuery.sizeOf(context).width < 800;

    return Column(
      crossAxisAlignment: mobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          'HELLO, I AM',
          style: TextStyle(
            color: const Color(0xFF56F3D6),
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
        ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.2),
        const SizedBox(height: 12),
        Text(
          developerName.toUpperCase(),
          textAlign: mobile ? TextAlign.center : TextAlign.start,
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontWeight: FontWeight.w900,
            fontSize: mobile ? 40 : 84,
            letterSpacing: -2,
            height: 1.1,
            color: Colors.white,
          ),
        ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.1),
        const SizedBox(height: 16),
        SizedBox(
          height: 40,
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: mobile ? 18 : 28,
              fontWeight: FontWeight.bold,
              color: Colors.white70,
              fontFamily: 'monospace',
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText('Full Stack Developer'),
                TypewriterAnimatedText('Flutter Engineer'),
                TypewriterAnimatedText('AI Solutions Architect'),
                TypewriterAnimatedText('Cross Platform Specialist'),
              ],
              repeatForever: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHolographicProfile(BuildContext context) {
    final bool mobile = MediaQuery.sizeOf(context).width < 800;
    final double radius = mobile ? 140 : 260;

    return PerspectiveCard(
      child: Magnetic(
        child: SizedBox(
          width: radius * 1.8,
          height: radius * 1.8,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Multiple Orbiting Rings (Elite Layering)
              _buildOrbitingRing(
                radius * 1.3,
                1.0,
                15,
                const Color(0xFF56F3D6).withValues(alpha: 0.1),
              ),
              _buildOrbitingRing(
                radius * 1.1,
                -0.8,
                12,
                const Color(0xFF00C2FF).withValues(alpha: 0.15),
              ),
              _buildOrbitingRing(
                radius * 0.9,
                1.2,
                8,
                const Color(0xFF56F3D6).withValues(alpha: 0.2),
              ),

              // Floating Code Snippets with advanced motion
              ..._buildFloatingCodeSnippets(),

              // Profile Image with Cinematic Glow
              Container(
                    width: radius,
                    height: radius,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF56F3D6).withValues(alpha: 0.2),
                          blurRadius: 50,
                          spreadRadius: 5,
                        ),
                        BoxShadow(
                          color: const Color(0xFF00C2FF).withValues(alpha: 0.1),
                          blurRadius: 80,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/profile.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .moveY(
                    begin: -10,
                    end: 10,
                    duration: 4.seconds,
                    curve: Curves.easeInOut,
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrbitingRing(
    double radius,
    double speed,
    int duration,
    Color color,
  ) {
    return Container(
          width: radius,
          height: radius,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 1.0),
          ),
        )
        .animate(onPlay: (c) => c.repeat())
        .rotate(duration: duration.seconds, begin: 0, end: speed);
  }

  List<Widget> _buildFloatingCodeSnippets() {
    return [
      _FloatingSnippet(
        text: 'flutter_animate',
        offset: const Offset(-120, -100),
        delay: 0,
      ),
      _FloatingSnippet(
        text: 'Flask',
        offset: const Offset(140, -60),
        delay: 500,
      ),
      _FloatingSnippet(
        text: 'Riverpod',
        offset: const Offset(-130, 80),
        delay: 1000,
      ),
      _FloatingSnippet(
        text: 'FastAPI',
        offset: const Offset(110, 110),
        delay: 1500,
      ),
    ];
  }

  Widget _buildActionButtons(BuildContext context) {
    final bool mobile = MediaQuery.sizeOf(context).width < 800;

    return Wrap(
      spacing: 20,
      runSpacing: 20,
      alignment: mobile ? WrapAlignment.center : WrapAlignment.start,
      children: [
        Magnetic(
          child: ElevatedButton(
            onPressed: widget.onViewProjects,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF56F3D6),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 22),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'EXPLORE WORK',
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
            ),
          ),
        ),
        Magnetic(
          child: OutlinedButton(
            onPressed: () => openExternalLink(context, resumeUrl),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white24, width: 2),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 22),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'RESUME',
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
            ),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 1.seconds).moveY(begin: 20);
  }
}

class _FloatingSnippet extends StatelessWidget {
  const _FloatingSnippet({
    required this.text,
    required this.offset,
    required this.delay,
  });
  final String text;
  final Offset offset;
  final int delay;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
          offset: offset,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white10),
            ),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white38,
                fontSize: 10,
                fontFamily: 'monospace',
              ),
            ),
          ),
        )
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .moveY(begin: -10, end: 10, duration: 2.seconds, delay: delay.ms)
        .fadeIn(duration: 1.seconds);
  }
}
