import 'package:flutter/material.dart';

import '../../core/constants/portfolio_data.dart';
import '../common/glass_container.dart';
import '../common/link_utils.dart';
import '../common/reveal_on_scroll.dart';
import '../common/section_title.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
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
    final bool mobile = MediaQuery.sizeOf(context).width < 900;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1120),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: RevealOnScroll(
          child: GlassContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SectionTitle(
                  title: 'Contact',
                  subtitle: 'Let us build something meaningful together',
                ),
                const SizedBox(height: 18),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: <Widget>[
                    ActionChip(
                      label: const Text(
                        email,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      backgroundColor: Colors.white.withValues(alpha: 0.08),
                      side: BorderSide(color: Colors.white.withValues(alpha: 0.25)),
                      onPressed: () => openExternalLink(context, 'mailto:$email'),
                    ),
                    ActionChip(
                      label: const Text(
                        'LinkedIn',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      backgroundColor: Colors.white.withValues(alpha: 0.08),
                      side: BorderSide(color: Colors.white.withValues(alpha: 0.25)),
                      onPressed: () => openExternalLink(context, linkedinUrl),
                    ),
                    ActionChip(
                      label: const Text(
                        'GitHub',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      backgroundColor: Colors.white.withValues(alpha: 0.08),
                      side: BorderSide(color: Colors.white.withValues(alpha: 0.25)),
                      onPressed: () => openExternalLink(context, githubUrl),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Flex(
                  direction: mobile ? Axis.vertical : Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          _InputField(
                            controller: _nameController,
                            hint: 'Your name',
                          ),
                          const SizedBox(height: 12),
                          _InputField(
                            controller: _emailController,
                            hint: 'Your email',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: mobile ? 0 : 12, height: mobile ? 12 : 0),
                    Expanded(
                      child: _InputField(
                        controller: _messageController,
                        hint: 'Message',
                        maxLines: 5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                FilledButton(
                  onPressed: _submit,
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                    elevation: 12,
                    shadowColor: Colors.white.withValues(alpha: 0.3),
                  ),
                  child: const Text(
                    'Send Message',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Thanks! Your message has been captured locally.'),
      ),
    );

    _nameController.clear();
    _emailController.clear();
    _messageController.clear();
  }
}

class _InputField extends StatelessWidget {
  const _InputField({
    required this.controller,
    required this.hint,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String hint;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.white54,
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.05),
        contentPadding: const EdgeInsets.all(14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.15)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.4), width: 2),
        ),
      ),
    );
  }
}
