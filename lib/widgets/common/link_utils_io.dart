import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<void> openExternalLink(BuildContext context, String url) async {
  final Uri uri = Uri.parse(url);
  final bool launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
  if (!launched && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Could not open: $url')),
    );
  }
}

Future<void> openAsset(BuildContext context, String assetPath) async {
  try {
    // Load the asset
    final byteData = await rootBundle.load(assetPath);
    
    // Save to a temporary directory first
    final dir = await getTemporaryDirectory();
    final fileName = assetPath.split('/').last;
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(byteData.buffer.asUint8List());

    if (context.mounted) {
      // Inform the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preparing resume...'),
          duration: Duration(seconds: 1),
          backgroundColor: Color(0xFF1A1A1A),
        ),
      );

      // On mobile, the most "proper" way to "download" is to trigger the share sheet.
      // This allows the user to "Save to Files", "Save to Drive", or "Download".
      // ignore: deprecated_member_use
      await Share.shareXFiles(
        [XFile(file.path, name: 'Raj_Dutta_Resume.pdf')],
        text: 'My Resume',
        subject: 'Resume - Raj Dutta',
      );
      
      // Optionally, we can also try to open it directly if the user prefers viewing
      // but Share already provides a preview in most cases.
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not process resume: $e'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }
}
