import 'package:flutter/material.dart';

import '../../core/constants/portfolio_data.dart';
import '../../models/certificate.dart';
import '../common/certificate_preview_dialog.dart';
import '../common/glass_container.dart';
import '../common/hover_scale.dart';
import '../common/reveal_on_scroll.dart';
import '../common/section_title.dart';

class CertificatesSection extends StatelessWidget {
  const CertificatesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool mobile = MediaQuery.sizeOf(context).width < 760;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1120),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const RevealOnScroll(
              child: SectionTitle(
                title: 'Certificates',
                subtitle: 'Internship and training credentials',
              ),
            ),
            const SizedBox(height: 18),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: certificates.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: mobile ? 1 : 3,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: mobile ? 2.2 : 1.03,
              ),
              itemBuilder: (BuildContext context, int index) {
                final Certificate cert = certificates[index];
                return RevealOnScroll(
                  child: HoverScale(
                    onTap: () => _openCertPreview(context, cert),
                    child: GlassContainer(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                cert.imageUrl,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            cert.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            cert.issuer,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Colors.white60,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _openCertPreview(BuildContext context, Certificate cert) {
    showDialog<void>(
      context: context,
      builder: (_) => CertificatePreviewDialog(
        title: cert.title,
        imageUrl: cert.imageUrl,
      ),
    );
  }
}
