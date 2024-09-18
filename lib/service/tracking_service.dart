import 'package:deck_ng/env/env.dart';
import 'package:deck_ng/model/models.dart';
import 'package:deck_ng/service/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:wiredash/wiredash.dart';

void reportException(FlutterErrorDetails details) {
  if (Get.find<TrackingService>().isOptedOut()) return;

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
  final StorageService storageService = Get.find<StorageService>();

  bool isOptedOut() {
    return storageService.getSetting()?.optOut ?? false;
  }

  void optOut() {
    final setting = storageService.getSetting() ?? Setting('');
    setting.optOut = true;
    storageService.saveSetting(setting);
  }

  void optIn() {
    final setting = storageService.getSetting() ?? Setting('');
    setting.optOut = false;
    storageService.saveSetting(setting);
  }

  onScreenEvent(String screenName) async {
    if (isOptedOut()) return;

    Wiredash.of(Get.context!).trackEvent(screenName);
    await Posthog().screen(
      screenName: 'Dashboard Screen',
    );
  }

  onButtonClickedEvent(String buttonName) async {
    if (isOptedOut()) return;

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
