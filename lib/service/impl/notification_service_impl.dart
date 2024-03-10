import 'package:deck_ng/service/Inotification_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationService implements INotificationService {
  @override
  successMsg(String title, String message) {
    Get.showSnackbar(
      GetSnackBar(
        title: title,
        message: message,
        icon: const Icon(Icons.update),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  errorMsg(String title, String msg) {
    Get.showSnackbar(
      GetSnackBar(
        title: title,
        message: msg,
        icon: const Icon(Icons.update),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
