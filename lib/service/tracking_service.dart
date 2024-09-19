import 'package:flutter/foundation.dart';

abstract class TrackingService {
  enableExceptionTracking();

  bool isOptedOut();

  void optOut();

  void optIn();

  void trackEvent(String eventName, {Map<String, dynamic>? properties});

  void onScreenEvent(String screenName);

  void onButtonClickedEvent(String buttonName);

  String determineBuildMode() {
    if (kReleaseMode) {
      return "Release Mode";
    } else if (kDebugMode) {
      return "Debug Mode";
    } else if (kProfileMode) {
      return "Profile Mode";
    } else {
      return "Unknown Mode";
    }
  }

  void modifyMetaData();
}
