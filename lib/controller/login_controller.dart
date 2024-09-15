import 'dart:async';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:deck_ng/service/services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wiredash/wiredash.dart';

class BarcodeScanData {
  late String url;
  late String username;
  late String password;

  BarcodeScanData(
      {required this.url, required this.username, required this.password});
}

class LoginController extends GetxController {
  var credService = Get.find<StorageService>();
  var authService = Get.find<AuthService>();
  var notificationService = Get.find<NotificationService>();

  final focusNode = FocusNode();
  Timer? typingTimer;

  var isLoading = false.obs;
  var username = ''.obs;
  var password = ''.obs;
  var urlController = TextEditingController();
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();

  var url = ''.obs;
  var isUrlValid = false.obs;
  var urlErrorMessage = ''.obs;

  var isPasswordVisible = false.obs;

  Rxn<Version> nextcloudVersion = Rxn();
  var nextcloudVersionString = ''.obs;
  var isFormValid = false.obs;

  @override
  void onInit() {
    super.onInit();
    urlController.addListener(() {
      url.value = urlController.text;
      validateForm();
    });

    userNameController.addListener(() {
      username.value = userNameController.text;
      validateForm();
    });

    passwordController.addListener(() {
      password.value = passwordController.text;
      validateForm();
    });

    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        typingTimer?.cancel(); // Cancel the timer if it's still running
        validateUrl(url.value);
      }
    });
  }

  void validateForm() {
    isFormValid.value = isUrlValid.value &&
        username.value.isNotEmpty &&
        password.value.isNotEmpty;
  }

  @override
  void onClose() {
    typingTimer?.cancel();
    super.onClose();
  }

  void validateUrl(String value) {
    // Check if the URL starts with "http://" or "https://"
    if (!value.startsWith('http://') && !value.startsWith('https://')) {
      urlErrorMessage.value = 'URL must start with "http://" or "https://"';
      isUrlValid.value = false;
      return;
    }

    // Regex pattern to match HTTP/HTTPS URLs and IP addresses
    const urlPattern =
        r'^(https?:\/\/)?(([\da-z\.-]+)\.([a-z\.]{2,6})|(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}))(:\d+)?([\/\w \.-]*)*\/?$';
    final result = RegExp(urlPattern).hasMatch(value);

    if (!result) {
      urlErrorMessage.value = 'Invalid URL or IP Address';
    } else {
      urlErrorMessage.value = '';
    }

    isUrlValid.value = result;
    checkCapabilties();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  @override
  void onReady() async {
    super.onReady();
    await readAccountData();
  }

  readAccountData() async {
    var account = credService.getAccount();

    url.value = account != null ? account.url : '';
    username.value = account != null ? account.username : '';
    password.value = account != null ? account.password : '';
  }

  login() async {
    isLoading.value = true;
    var successful = false;
    try {
      successful =
          await authService.login(url.value, username.value, password.value);
    } on DioException {
      // notificationService.errorMsg(
      //     "Login", "Login not Successful. ${e.message}");
    }
    if (successful) {
      await Wiredash.trackEvent('successfully login', data: {
        'url': url.value,
        'nextcloudVersion': nextcloudVersionString.value
      });
      Get.toNamed('/boards');
      notificationService.successMsg("Login", "Login Successful");
    } else {
      await Wiredash.trackEvent('not successfully login', data: {
        'url': url.value,
        'nextcloudVersion': nextcloudVersionString.value
      });
      notificationService.errorMsg(
          "Login", "Login not Successful. Please check username and password");
    }
    isLoading.value = false;
  }

  void checkCapabilties() async {
    isLoading.value = true;
    try {
      Capabilities resp = await authService.checkServer(url.value);
      nextcloudVersionString.value = resp.ocs.data.version.string;
      nextcloudVersion.value = resp.ocs.data.version;
    } on DioException {
      nextcloudVersionString.value = 'Invalid URL or IP Address';
      isUrlValid.value = false;
    }
    isLoading.value = false;
  }

  void startValidationTimer(String value) {
    typingTimer?.cancel();
    typingTimer = Timer(const Duration(seconds: 2), () {
      validateUrl(value);
    });
  }

  Future<void> scanBarcode() async {
    try {
      var result = await BarcodeScanner.scan();
      //nc://login/user:admin&password:AZdNL-cA5gw-teTtT-6e38a-zcL8a&server:http://192.168.178.81:8080
      if (result.rawContent.isNotEmpty) {
        // Assuming the barcode contains URL, username, and password separated by commas
        BarcodeScanData data = parseBarcode(result.rawContent);
        urlController.text = data.url;
        userNameController.text = data.username;
        passwordController.text = data.password;
        await Wiredash.trackEvent('wants to login with barcode');
        login();
      } else {
        notificationService.errorMsg("Login", "Invalid barcode format");
        await Wiredash.trackEvent('unsuccessfully login with barcode');
      }
    } catch (e) {
      notificationService.errorMsg("Login", "Failed to scan barcode: $e");
      await Wiredash.trackEvent('unsuccessfully login with barcode');
    }
  }

  BarcodeScanData parseBarcode(String barcode) {
    const prefix = "nc://login/";
    if (!barcode.startsWith(prefix)) {
      throw const FormatException("Invalid barcode format");
    }

    final content = barcode.substring(prefix.length);
    final parts = content.split('&');

    if (parts.length != 3) {
      throw const FormatException("Invalid barcode format");
    }

    final userPart = parts[0].replaceFirst('user:', '');
    final passwordPart = parts[1].replaceFirst('password:', '');
    final serverPart = parts[2].replaceFirst('server:', '');

    final username = userPart;
    final password = passwordPart;
    final server = serverPart;

    return BarcodeScanData(url: server, username: username, password: password);
  }
}
