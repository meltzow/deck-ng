import 'package:deck_ng/env/env.dart';
import 'package:deck_ng/model/models.dart';
import 'package:deck_ng/service/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:wiredash/wiredash.dart';

class TrackingService extends GetxService {
  final StorageService storageService = Get.find<StorageService>();
  final Uuid uuid = Uuid();

  enableExceptionTracking() {
    if (isOptedOut()) return;

    FlutterError.onError = (FlutterErrorDetails details) {
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
      // Optionally: log to other services like Crashlytics or Sentry
      FlutterError.dumpErrorToConsole(details);
    };
  }

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

  String _generateDistinctId() {
    return uuid.v4();
  }

  void _updateDistinctIdIfNeeded() {
    final setting = storageService.getSetting() ?? Setting('');
    final today = DateTime.now().toIso8601String().split('T').first;

    // needed for consent-less tracking
    if (setting.distinceIdLastUpdated != today) {
      setting.distinctId = _generateDistinctId();
      setting.distinceIdLastUpdated = today;
      storageService.saveSetting(setting);
      Posthog().identify(userId: setting.distinctId ?? '');
      // Wiredash.of(Get.context!).modifyMetaData((metaData) {
      //   metaData.custom['distinctId'] = setting.distinctId;
      //   return metaData;
      // });
    }
  }

  @override
  void onInit() {
    super.onInit();
    _updateDistinctIdIfNeeded();
    enableExceptionTracking();
  }

  void trackEvent(String eventName, {Map<String, dynamic>? properties}) {
    if (isOptedOut()) return;

    final distinctId = storageService.getSetting()?.distinctId ?? '';
    Posthog().capture(
      eventName: eventName,
      properties: {
        ...?properties,
        'distinct_id': distinctId,
      },
    );
  }

  void onScreenEvent(String screenName) async {
    if (isOptedOut()) return;

    final distinctId = storageService.getSetting()?.distinctId ?? '';
    Wiredash.of(Get.context!).trackEvent(screenName);
    await Posthog().screen(
      screenName: screenName,
      properties: {
        'distinct_id': distinctId,
      },
    );
  }

  void onButtonClickedEvent(String buttonName) async {
    if (isOptedOut()) return;

    final distinctId = storageService.getSetting()?.distinctId ?? '';
    Wiredash.of(Get.context!).trackEvent(buttonName);

    await Posthog().capture(
      eventName: 'ButtonClicked',
      properties: {
        'button': buttonName,
        'clicked': true,
        'distinct_id': distinctId,
      },
    );
  }
}
