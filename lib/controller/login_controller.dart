import 'package:deck_ng/service/Iauth_service.dart';
import 'package:deck_ng/service/Icredential_service.dart';
import 'package:deck_ng/service/Inotification_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var credService = Get.find<IStorageService>();
  var authService = Get.find<IAuthService>();
  var notificationService = Get.find<INotificationService>();

  final RxBool isLoading = RxBool(false);
  RxString nameControllerText = ''.obs;
  var nameController = TextEditingController();
  RxString passwordControllerText = ''.obs;
  var passwordController = TextEditingController();
  RxString urlControllerText = ''.obs;
  var urlController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final RxString _serverVersion = 'not found'.obs;
  // final RxString _deckVersion = 'nothing found'.obs;

  String get serverVersion => _serverVersion.value;
  // String get deckVersion => _deckVersion.value;
  bool get serverIsValid {
    //TODO check not by String. capability ENtity must be used
    return _serverVersion.value != 'not found';
  }

  @override
  void onInit() {
    urlController.addListener(() {
      urlControllerText.value = urlController.text;
    });

    nameController.addListener(() {
      nameControllerText.value = nameController.text;
    });

    passwordController.addListener(() {
      passwordControllerText.value = passwordController.text;
    });

    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        checkCapabilties();
      }
    });

    super.onInit();
  }

  @override
  onClose() {
    focusNode.dispose();
    super.onClose();
  }

  @override
  void onReady() async {
    super.onReady();
    await readAccountData();
  }

  readAccountData() async {
    var account = credService.getAccount();

    urlControllerText.value = account != null ? account.url : '';
    urlController.text = urlControllerText.value;
    nameControllerText.value = account != null ? account.username : '';
    nameController.text = nameControllerText.value;
    passwordControllerText.value = account != null ? account.password : '';
    passwordController.text = passwordControllerText.value;
  }

  login() async {
    var successful = false;
    try {
      successful = await authService.login(urlControllerText.value,
          nameControllerText.value, passwordControllerText.value);
      if (successful) {
        Get.toNamed('/boards');
        notificationService.successMsg("Login", "Login Successful");
      } else {
        notificationService.errorMsg("Login",
            "Login not Successful. Please check username and password");
      }
    } on DioException catch (e) {
      notificationService.errorMsg(
          "Login", "Login not Successful. ${e.message}");
    }
  }

  void checkCapabilties() async {
    isLoading.value = true;
    try {
      Capabilities resp =
          await authService.checkServer(urlControllerText.value);
      _serverVersion.value = resp.ocs.data.version.string;
      // _deckVersion.value = resp.ocs.data.version.string;
    } on DioException {
      _serverVersion.value = 'not found';
      // _deckVersion.value = 'not found';
    }
    isLoading.value = false;
  }
}
