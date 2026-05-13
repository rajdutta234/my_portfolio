import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../core/constants/portfolio_data.dart';
import '../../core/responsive.dart';
import '../../notifier/app_notifier.dart';
import '../../provider/portfolio_provider.dart';
import '../common/link_utils.dart';
import '../common/section_title.dart';
import '../common/magnetic.dart';

class ContactSection extends ConsumerStatefulWidget {
  const ContactSection({super.key});

  @override
  ConsumerState<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends ConsumerState<ContactSection> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    final contactState = ref.watch(contactNotifierProvider);

    // Listen for success or error to show notifications
    ref.listen<ContactState>(contactNotifierProvider, (previous, next) {
      if (next.isSuccess) {
        _showNotification('TRANSMISSION SUCCESSFUL', isError: false);
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
        ref.read(contactNotifierProvider.notifier).resetStatus();
      } else if (next.error != null) {
        _showNotification('SIGNAL INTERRUPTED: ${next.error!}', isError: true);
      }
    });

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1100),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
          child: Column(
            children: [
              const SectionTitle(
                title: 'Neural Connection',
                subtitle:
                    "Synchronize your vision with my engineering capabilities.",
              ),
              const SizedBox(height: 80),

              isMobile ? _buildMobileLayout(contactState.isLoading) : _buildDesktopLayout(contactState.isLoading),
            ],
          ),
        ),
      ),
    );
  }

  void _showNotification(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: GlassmorphicContainer(
          width: double.infinity,
          height: 80,
          borderRadius: 20,
          blur: 20,
          alignment: Alignment.center,
          border: 1,
          linearGradient: LinearGradient(
            colors: [
              const Color(0xFF0D1829),
              isError ? Colors.red.withValues(alpha: 0.1) : const Color(0xFF020C1B)
            ],
          ),
          borderGradient: LinearGradient(
            colors: [
              isError ? Colors.red : const Color(0xFF56F3D6),
              Colors.transparent
            ],
          ),
          child: Center(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isError ? Colors.redAccent : const Color(0xFF56F3D6),
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(bool isLoading) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              _ContactAnchor(
                icon: const Icon(
                  Icons.alternate_email_rounded,
                  color: Color(0xFF56F3D6),
                ),
                title: 'DIRECT PROTOCOL',
                value: email,
                onTap: () => openExternalLink(context, 'mailto:$email'),
              ),
              const SizedBox(height: 24),
              _ContactAnchor(
                icon: const FaIcon(
                  FontAwesomeIcons.linkedinIn,
                  color: Color(0xFF00C2FF),
                ),
                title: 'PROFESSIONAL NODE',
                value: 'LinkedIn Profile',
                onTap: () => openExternalLink(context, linkedinUrl),
              ),
              const SizedBox(height: 24),
              _ContactAnchor(
                icon: const FaIcon(
                  FontAwesomeIcons.github,
                  color: Colors.white,
                ),
                title: 'SOURCE REPOSITORY',
                value: 'GitHub Workspace',
                onTap: () => openExternalLink(context, githubUrl),
              ),
              const SizedBox(height: 24),
              _ContactAnchor(
                icon: const FaIcon(
                  FontAwesomeIcons.instagram,
                  color: Colors.pinkAccent,
                ),
                title: 'SOCIAL FREQUENCY',
                value: '@_raj_dutta_',
                onTap: () => openExternalLink(context, instagramUrl),
              ),
            ],
          ),
        ),
        const SizedBox(width: 60),
        Expanded(flex: 3, child: _buildMessageForm(context, isLoading)),
      ],
    );
  }

  Widget _buildMobileLayout(bool isLoading) {
    return Column(
      children: [
        _buildMessageForm(context, isLoading),
        const SizedBox(height: 48),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: [
            _buildSmallAnchor(FontAwesomeIcons.linkedinIn, linkedinUrl),
            _buildSmallAnchor(FontAwesomeIcons.github, githubUrl),
            _buildSmallAnchor(FontAwesomeIcons.instagram, instagramUrl),
            _buildSmallAnchor(FontAwesomeIcons.facebook, facebookUrl),
            _buildSmallAnchor(Icons.email_rounded, 'mailto:$email'),
          ],
        ),
      ],
    );
  }

  Widget _buildSmallAnchor(dynamic icon, String url) {
    return Magnetic(
      child: IconButton(
        onPressed: () => openExternalLink(context, url),
        onHover: (hovering) {
          ref.read(cursorHoverProvider.notifier).set(hovering);
        },
        icon: icon is IconData
            ? Icon(icon, color: const Color(0xFF56F3D6), size: 24)
            : FaIcon(
                icon as FaIconData?,
                color: const Color(0xFF56F3D6),
                size: 24,
              ),
        style: IconButton.styleFrom(
          backgroundColor: Colors.white.withValues(alpha: 0.05),
          padding: const EdgeInsets.all(20),
        ),
      ),
    );
  }

  Widget _buildMessageForm(BuildContext context, bool isLoading) {
    final bool isMobile = Responsive.isMobile(context);
    return GlassmorphicContainer(
      width: double.infinity,
      height: isMobile ? 700 : 600,
      borderRadius: 32,
      blur: 25,
      alignment: Alignment.topLeft,
      border: 1.5,
      linearGradient: LinearGradient(
        colors: [
          Colors.white.withValues(alpha: 0.05),
          Colors.white.withValues(alpha: 0.01),
        ],
      ),
      borderGradient: LinearGradient(
        colors: [
          const Color(0xFF56F3D6).withValues(alpha: 0.2),
          Colors.transparent,
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'INITIATE ENQUIRY',
              style: TextStyle(
                color: Color(0xFF56F3D6),
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
              ),
            ),
            const SizedBox(height: 40),
            _buildInput(
              _nameController,
              'FULL NAME',
              Icons.person_outline_rounded,
            ),
            const SizedBox(height: 24),
            _buildInput(
              _emailController,
              'SECURE EMAIL',
              Icons.alternate_email_rounded,
            ),
            const SizedBox(height: 24),
            _buildInput(
              _messageController,
              'MESSAGE PAYLOAD',
              Icons.chat_bubble_outline_rounded,
              maxLines: 4,
            ),
            const Spacer(),
            _buildDispatchButton(isLoading),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 300.ms).moveY(begin: 30);
  }

  Widget _buildInput(
    TextEditingController controller,
    String label,
    IconData icon, {
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white38,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white, fontSize: 15),
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: const Color(0xFF56F3D6).withValues(alpha: 0.4),
              size: 18,
            ),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.03),
            contentPadding: const EdgeInsets.all(20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFF56F3D6), width: 1),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDispatchButton(bool isLoading) {
    return Magnetic(
      child: Container(
        width: double.infinity,
        height: 64,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF56F3D6), Color(0xFF00C2FF)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF56F3D6).withValues(alpha: 0.3),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: isLoading ? null : _submit,
          onHover: (hovering) {
            ref.read(cursorHoverProvider.notifier).set(hovering);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.black,
                    strokeWidth: 2,
                  ),
                )
              : const Text(
                  'DISPATCH MESSAGE',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
        ),
      ),
    );
  }

  void _submit() {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _messageController.text.isEmpty) {
      _showNotification('INCOMPLETE DATA: ALL FIELDS REQUIRED', isError: true);
      return;
    }

    ref.read(contactNotifierProvider.notifier).sendMessage(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      message: _messageController.text.trim(),
    );
  }
}

class _ContactAnchor extends ConsumerWidget {
  const _ContactAnchor({
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  });
  final Widget icon;
  final String title;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Magnetic(
      child: InkWell(
        onTap: onTap,
        onHover: (hovering) {
          ref.read(cursorHoverProvider.notifier).set(hovering);
        },
        borderRadius: BorderRadius.circular(20),
        child: GlassmorphicContainer(
          width: double.infinity,
          height: 100,
          borderRadius: 20,
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
            colors: [Colors.white10, Colors.transparent],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                icon,
                const SizedBox(width: 20),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white38,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        value,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
