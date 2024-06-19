import 'package:deck_ng/model/models.dart';
import 'package:deck_ng/service/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  var storageService = Get.find<StorageService>();
  var notificationService = Get.find<NotificationService>();

  RxString nameControllerText = ''.obs;
  var nameController = TextEditingController();

  RxString passwordControllerText = ''.obs;
  var passwordController = TextEditingController();
  RxBool isObscure = true.obs;

  RxString urlControllerText = ''.obs;
  var urlController = TextEditingController();
  final RxString _serverVersion = 'not found'.obs;
  // final RxString _deckVersion = 'nothing found'.obs;

  String get serverVersion => _serverVersion.value;
  // String get deckVersion => _deckVersion.value;
  bool get serverIsValid {
    //TODO check not by String. capability ENtity must be used
    return _serverVersion.value != 'not found';
  }

  @override
  void onReady() async {
    super.onReady();
    await readAccountData();
  }

  readAccountData() async {
    var account = storageService.getAccount();

    urlControllerText.value = account != null ? account.url : '';
    urlController.text = urlControllerText.value;
    nameControllerText.value = account != null ? account.username : '';
    nameController.text = nameControllerText.value;
    passwordControllerText.value = account != null ? account.password : '';
    passwordController.text = passwordControllerText.value;
  }

  changeLanguage(String v) {
    Get.updateLocale(Locale(v));
    storageService.saveSetting(Setting(v));
  }
}
