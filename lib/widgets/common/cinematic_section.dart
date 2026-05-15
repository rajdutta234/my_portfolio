import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'perspective_card.dart';
import '../../core/responsive.dart';

class CinematicSection extends StatefulWidget {
  const CinematicSection({super.key, required this.child});
  final Widget child;

  @override
  State<CinematicSection> createState() => _CinematicSectionState();
}

class _CinematicSectionState extends State<CinematicSection> {
  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedBuilder(
          animation: Scrollable.of(context).position,
          builder: (context, child) {
            final RenderBox? box = context.findRenderObject() as RenderBox?;
            double scrollSkew = 0.0;

            if (box != null && box.hasSize && box.attached) {
              final double viewportHeight = MediaQuery.sizeOf(context).height;
              final double widgetY = box.localToGlobal(Offset.zero).dy;

              // Only calculate transformation if the section is near the viewport
              if (widgetY > -viewportHeight && widgetY < viewportHeight * 2) {
                final double progress = (widgetY / viewportHeight).clamp(
                  -0.2,
                  1.2,
                );
                scrollSkew = isMobile ? 0.0 : (progress - 0.4) * 0.12;
              }
            }

            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(scrollSkew),
              alignment: Alignment.center,
              child: child,
            );
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Glass Plate Base with 3D Shadow
              Positioned.fill(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: isMobile ? 10 : 40),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.01),
                    borderRadius: BorderRadius.circular(isMobile ? 20 : 40),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.05),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 40,
                        offset: const Offset(0, 20),
                      ),
                    ],
                  ),
                ),
              ),

              // Holographic Lighting Sweep Effect
              Positioned.fill(child: _HolographicSweep(skew: 0.1)),

              // 3D Floating Architectural Element (Cinematic Focal Point)
              if (!isMobile) ...[
                Positioned(
                  right: -50,
                  bottom: -50,
                  child: _Floating3DWireframe(index: 0),
                ),
                Positioned(
                  left: -30,
                  top: 40,
                  child: _Floating3DWireframe(index: 1),
                ),
              ],

              // Interactive 3D Content Layer
              PerspectiveCard(
                maxTilt: isMobile ? 0.0 : 0.06,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: isMobile ? 40 : 100,
                    horizontal: isMobile ? 16 : 60,
                  ),
                  child: widget.child,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _HolographicSweep extends StatelessWidget {
  const _HolographicSweep({required this.skew});
  final double skew;

  @override
  Widget build(BuildContext context) {
    return Animate(
      onPlay: (c) => c.repeat(),
      effects: [
        CustomEffect(
          duration: 5.seconds,
          builder: (context, value, child) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-2.0 + value * 4, -1.0),
                  end: Alignment(-1.0 + value * 4, 1.0),
                  colors: [
                    Colors.transparent,
                    const Color(0xFF56F3D6).withValues(alpha: 0.03),
                    const Color(0xFF00C2FF).withValues(alpha: 0.05),
                    const Color(0xFF56F3D6).withValues(alpha: 0.03),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.4, 0.5, 0.6, 1.0],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _Floating3DWireframe extends StatelessWidget {
  const _Floating3DWireframe({required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Animate(
      onPlay: (c) => c.repeat(),
      effects: [
        RotateEffect(duration: 20.seconds, begin: 0, end: 1),
        MoveEffect(
          duration: 4.seconds,
          begin: const Offset(0, -20),
          end: const Offset(0, 20),
          curve: Curves.easeInOut,
        ),
      ],
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(index == 0 ? 0.5 : -0.3)
          ..rotateY(index == 0 ? -0.4 : 0.6),
        child: Container(
          width: index == 0 ? 300 : 150,
          height: index == 0 ? 300 : 150,
          decoration: BoxDecoration(
            border: Border.all(
              color:
                  (index == 0
                          ? const Color(0xFF56F3D6)
                          : const Color(0xFF00C2FF))
                      .withValues(alpha: 0.1),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color:
                        (index == 0
                                ? const Color(0xFF56F3D6)
                                : const Color(0xFF00C2FF))
                            .withValues(alpha: 0.05),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
