import 'dart:convert';

import 'package:deck_ng/service/tracking_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyController extends GetxController {
  late final WebViewController webViewController;

  @override
  void onInit() {
    super.onInit();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      );
    _loadMarkdownFromAssets();
  }

  Future<void> _loadMarkdownFromAssets() async {
    final markdownString =
        await rootBundle.loadString('assets/privacy_policy.md');
    final htmlString = md.markdownToHtml(markdownString);
    webViewController.loadRequest(Uri.dataFromString(
      htmlString,
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    ));
  }

  void optOut() {
    Get.find<TrackingService>().optOut();
    print('User opted out');
  }
}
