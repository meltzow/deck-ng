import 'package:deck_ng/privacy_policy/privacy_policy_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
