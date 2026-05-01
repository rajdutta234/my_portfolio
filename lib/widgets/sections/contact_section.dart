import 'package:flutter/material.dart';

import '../../core/constants/portfolio_data.dart';
import '../common/glass_container.dart';
import '../common/link_utils.dart';
import '../common/section_title.dart';

import 'package:flutter_animate/flutter_animate.dart';

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

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1120),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
        child: Column(
          children: [
            const SectionTitle(
              title: 'GET IN TOUCH',
              subtitle: 'Let us build something meaningful together',
            ).animate().fadeIn().moveY(begin: 30, end: 0),
            const SizedBox(height: 60),
            GlassContainer(
              padding: const EdgeInsets.all(40),
              borderRadius: 32,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Social Tags
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: <Widget>[
                      _ContactChip(
                        label: 'Email',
                        value: email,
                        onPressed: () => openExternalLink(context, 'mailto:$email'),
                      ),
                      _ContactChip(
                        label: 'LinkedIn',
                        value: 'Connect',
                        onPressed: () => openExternalLink(context, linkedinUrl),
                      ),
                    ],
                  ).animate().fadeIn(delay: 200.ms),
                  
                  const SizedBox(height: 48),
                  
                  // Form
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: GlowInput(
                              child: _ModernInputField(
                                controller: _nameController,
                                hint: 'Name',
                                icon: Icons.person_outline,
                              ),
                            ),
                          ),
                          if (!mobile) const SizedBox(width: 20),
                          if (!mobile)
                            Expanded(
                              child: GlowInput(
                                child: _ModernInputField(
                                  controller: _emailController,
                                  hint: 'Email',
                                  icon: Icons.email_outlined,
                                ),
                              ),
                            ),
                        ],
                      ),
                      if (mobile) const SizedBox(height: 16),
                      if (mobile)
                        GlowInput(
                          child: _ModernInputField(
                            controller: _emailController,
                            hint: 'Email',
                            icon: Icons.email_outlined,
                          ),
                        ),
                      const SizedBox(height: 20),
                      GlowInput(
                        child: _ModernInputField(
                          controller: _messageController,
                          hint: 'Your Message',
                          icon: Icons.chat_bubble_outline,
                          maxLines: 6,
                        ),
                      ),
                    ],
                  ).animate().fadeIn(delay: 400.ms),
                  
                  const SizedBox(height: 48),
                  
                  // Submit Button
                  Magnetic(
                    child: SizedBox(
                      width: mobile ? double.infinity : 240,
                      height: 70,
                      child: FilledButton(
                        onPressed: _isSubmitting ? null : _submit,
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: _isSubmitting
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  color: Colors.black,
                                ),
                              )
                            : const Text(
                                'SEND MESSAGE',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                  letterSpacing: 1,
                                ),
                              ),
                      ),
                    ),
                  ).animate().fadeIn(delay: 600.ms),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() async {
    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.blue.withValues(alpha: 0.9),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: const Text(
          'Message sent successfully!',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
    );

    setState(() => _isSubmitting = false);
    _nameController.clear();
    _emailController.clear();
    _messageController.clear();
  }
}

class _ContactChip extends StatelessWidget {
  const _ContactChip({
    required this.label,
    required this.value,
    required this.onPressed,
  });

  final String label;
  final String value;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Magnetic(
      range: 50,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$label: ',
                style: const TextStyle(color: Colors.white38, fontWeight: FontWeight.w500),
              ),
              Text(
                value,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
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
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white38, size: 20),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white24, fontWeight: FontWeight.w400),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.03),
        contentPadding: const EdgeInsets.all(22),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.white12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.3), width: 2),
        ),
      ),
    );
  }
}
