// Platform-specific implementation is provided by conditional imports.
import 'package:flutter/material.dart';

import 'link_utils_io.dart'
    if (dart.library.html) 'link_utils_web.dart' as platform_link;

Future<void> openExternalLink(BuildContext context, String url) =>
    platform_link.openExternalLink(context, url);

Future<void> openAsset(BuildContext context, String assetPath) =>
    platform_link.openAsset(context, assetPath);
