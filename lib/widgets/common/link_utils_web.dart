// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:html' as html;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:url_launcher/url_launcher.dart';

Future<void> openExternalLink(BuildContext context, String url) async {
  try {
    final Uri uri = Uri.parse(url);
    final bool launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not open: $url'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }
}

Future<void> openAsset(BuildContext context, String assetPath) async {
  try {
    // Inform the user
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Opening resume...'),
          duration: Duration(seconds: 1),
          backgroundColor: Color(0xFF1A1A1A),
        ),
      );
    }

    // Load the asset
    final byteData = await rootBundle.load(assetPath);
    final bytes = byteData.buffer.asUint8List();
    
    // Create a blob from the bytes
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    
    // Create an anchor element and trigger open in new tab
    html.AnchorElement(href: url)
      ..setAttribute("target", "_blank")
      ..click();
    
    // Clean up the URL object after a short delay
    Future.delayed(const Duration(seconds: 1), () {
      html.Url.revokeObjectUrl(url);
    });

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Color(0xFF56F3D6), size: 20),
              SizedBox(width: 12),
              Expanded(child: Text('Resume opened in a new tab!')),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Color(0xFF1A1A1A),
        ),
      );
    }
  } catch (e) {
    // Fallback: Try launching as a data URI if blob method fails
    try {
      final byteData = await rootBundle.load(assetPath);
      final base64Pdf = base64Encode(byteData.buffer.asUint8List());
      final Uri uri = Uri.parse('data:application/pdf;base64,$base64Pdf');
      final bool launched = await launchUrl(uri);
      
      if (!launched && context.mounted) {
         throw Exception('Could not trigger download');
      }
    } catch (e2) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Download failed: $e2'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }
}
