import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/constants/portfolio_data.dart';
import '../common/glass_container.dart';
import '../common/link_utils.dart';
import '../common/section_title.dart';
import '../common/glow_input.dart';
import '../common/magnetic.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool mobile = MediaQuery.sizeOf(context).width < 900;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1100),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 100),
          child: Column(
            children: [
              const SectionTitle(
                title: 'Get In Touch',
                subtitle: "Let's build something exceptional together",
              ).animate().fadeIn().moveY(begin: 30, end: 0),
              const SizedBox(height: 60),
              
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!mobile)
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _ContactInfoCard(
                            icon: Icons.email_rounded,
                            title: 'Email Me',
                            value: email,
                            onTap: () => openExternalLink(context, 'mailto:$email'),
                          ),
                          const SizedBox(height: 24),
                          _ContactInfoCard(
                            icon: Icons.link_rounded,
                            title: 'LinkedIn',
                            value: 'Connect on LinkedIn',
                            onTap: () => openExternalLink(context, linkedinUrl),
                          ),
                          const SizedBox(height: 24),
                          _ContactInfoCard(
                            icon: Icons.facebook_rounded,
                            title: 'Facebook',
                            value: 'Raj Dutta',
                            onTap: () => openExternalLink(context, facebookUrl),
                          ),
                          const SizedBox(height: 24),
                          _ContactInfoCard(
                            icon: Icons.camera_alt_rounded,
                            title: 'Instagram',
                            value: '@_raj_dutta_',
                            onTap: () => openExternalLink(context, instagramUrl),
                          ),
                          const SizedBox(height: 24),
                          _ContactInfoCard(
                            icon: Icons.code_rounded,
                            title: 'GitHub',
                            value: 'rajdutta234',
                            onTap: () => openExternalLink(context, githubUrl),
                          ),
                        ],
                      ).animate().fadeIn(delay: 200.ms).moveX(begin: -30, end: 0),
                    ),
                  
                  if (!mobile) const SizedBox(width: 48),
                  
                  Expanded(
                    flex: 3,
                    child: GlassContainer(
                      padding: const EdgeInsets.all(40),
                      borderRadius: 32,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'SEND A MESSAGE',
                            style: TextStyle(
                              color: Color(0xFF56F3D6),
                              fontWeight: FontWeight.w900,
                              fontSize: 12,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 32),
                          Row(
                            children: [
                              Expanded(
                                child: GlowInput(
                                  child: _ModernInputField(
                                    controller: _nameController,
                                    hint: 'Full Name',
                                    icon: Icons.person_outline_rounded,
                                  ),
                                ),
                              ),
                              if (!mobile) const SizedBox(width: 20),
                              if (!mobile)
                                Expanded(
                                  child: GlowInput(
                                    child: _ModernInputField(
                                      controller: _emailController,
                                      hint: 'Email Address',
                                      icon: Icons.alternate_email_rounded,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          if (mobile) const SizedBox(height: 20),
                          if (mobile)
                            GlowInput(
                              child: _ModernInputField(
                                controller: _emailController,
                                hint: 'Email Address',
                                icon: Icons.alternate_email_rounded,
                              ),
                            ),
                          const SizedBox(height: 20),
                          GlowInput(
                            child: _ModernInputField(
                              controller: _messageController,
                              hint: 'How can I help you?',
                              icon: Icons.chat_bubble_outline_rounded,
                              maxLines: 5,
                            ),
                          ),
                          const SizedBox(height: 40),
                          Magnetic(
                            child: SizedBox(
                              width: double.infinity,
                              height: 64,
                              child: FilledButton(
                                onPressed: _isSubmitting ? null : _submit,
                                style: FilledButton.styleFrom(
                                  backgroundColor: const Color(0xFF56F3D6),
                                  foregroundColor: const Color(0xFF031313),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 0,
                                ),
                                child: _isSubmitting
                                    ? const SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 3,
                                          color: Color(0xFF031313),
                                        ),
                                      )
                                    : const Text(
                                        'DISPATCH MESSAGE',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 15,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(delay: 400.ms).moveY(begin: 30, end: 0),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() async {
    if (_nameController.text.isEmpty || _emailController.text.isEmpty || _messageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF56F3D6),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: const Text(
          'Message transmitted successfully!',
          style: TextStyle(color: Color(0xFF031313), fontWeight: FontWeight.w800),
        ),
      ),
    );

    setState(() => _isSubmitting = false);
    _nameController.clear();
    _emailController.clear();
    _messageController.clear();
  }
}

class _ContactInfoCard extends StatelessWidget {
  const _ContactInfoCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Magnetic(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: GlassContainer(
          padding: const EdgeInsets.all(24),
          borderRadius: 24,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF56F3D6).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: const Color(0xFF56F3D6), size: 24),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.4),
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModernInputField extends StatelessWidget {
  const _ModernInputField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xFF56F3D6).withValues(alpha: 0.5), size: 20),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.2), fontWeight: FontWeight.w400),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.02),
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.white10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF56F3D6), width: 1.5),
        ),
      ),
    );
  }
}
