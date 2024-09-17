import 'package:get/get.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:wiredash/wiredash.dart';

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
        'foo': 'bar',
        'number': 1337,
        'clicked': true,
      },
    );
  }
}
