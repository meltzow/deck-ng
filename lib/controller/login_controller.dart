import 'package:deck_ng/service/services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var credService = Get.find<StorageService>();
  var authService = Get.find<AuthService>();
  var notificationService = Get.find<NotificationService>();

  var isLoading = false.obs;
  var username = ''.obs;
  var password = ''.obs;
  var url = ''.obs;
  var isUrlValid = false.obs;
  var serverInfo = ''.obs;

  var isPasswordVisible = false.obs;

  final FocusNode focusNode = FocusNode();

  Rxn<Version> nextcloudVersion = Rxn();

  void validateUrl(String value) {
    // Regex pattern to match HTTP/HTTPS URLs and IP addresses
    const urlPattern =
        r'^(https?:\/\/)?(([\da-z\.-]+)\.([a-z\.]{2,6})|(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}))(:\d+)?([\/\w \.-]*)*\/?$';
    final result = RegExp(urlPattern).hasMatch(value);
    checkCapabilties();
    isUrlValid.value = result;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  @override
  onClose() {
    focusNode.dispose();
    super.onClose();
  }

  @override
  void onReady() async {
    super.onReady();
    username.value = 'dddd';
    await readAccountData();
  }

  readAccountData() async {
    var account = credService.getAccount();

    url.value = account != null ? account.url : '';
    username.value = account != null ? account.username : '';
    password.value = account != null ? account.password : '';
  }

  login() async {
    var successful = false;
    try {
      successful =
          await authService.login(url.value, username.value, password.value);
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
      Capabilities resp = await authService.checkServer(url.value);
      serverInfo.value = resp.ocs.data.version.string;
      // _deckVersion.value = resp.ocs.data.version.string;
    } on DioException {
      serverInfo.value = 'not found';
      // _deckVersion.value = 'not found';
    }
    isLoading.value = false;
  }
}
