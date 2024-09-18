import 'dart:convert';

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
    // Implement your opt-out logic here
    print('User opted out');
    // For example, you can update a setting in GetStorage or call an API
  }
}

class PrivacyPolicyScreen extends GetView<PrivacyPolicyController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datenschutzerklärung'),
      ),
      body: Column(
        children: [
          Expanded(
            child: WebViewWidget(
              controller: Get.find<PrivacyPolicyController>().webViewController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Get.find<PrivacyPolicyController>().optOut();
              },
              child: Text('Opt-Out'),
            ),
          ),
        ],
      ),
    );
  }
}
