import 'package:deck_ng/env/env.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:wiredash/wiredash.dart';

void reportException(FlutterErrorDetails details) {
  // Send an event to PostHog with error details
  Posthog().capture(
    eventName: 'Exception',
    properties: {
      'error': details.exceptionAsString(),
      'stack_trace': details.stack.toString(),
      'library': details.library.toString(),
      'context': details.context!.toDescription(),
      'information': details.informationCollector.toString(),
      'appVersion': Env.VERSION,
    },
  );
}

class TrackingService extends GetxService {
  onScreenEvent(String screenName) async {
    Wiredash.of(Get.context!).trackEvent(screenName);
    await Posthog().screen(
      screenName: 'Dashboard Screen',
    );
  }

  onButtonClickedEvent(String buttonName) async {
    Wiredash.of(Get.context!).trackEvent(buttonName);

    await Posthog().capture(
      eventName: 'ButtonClicked',
      properties: {
        'button': buttonName,
        'number': 1337,
        'clicked': true,
      },
    );
  }
}
