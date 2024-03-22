import 'package:deck_ng/service/services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var credService = Get.find<StorageService>();
  var authService = Get.find<AuthService>();
  var notificationService = Get.find<NotificationService>();

  final RxBool isLoading = RxBool(false);
  RxString usernameControllerText = ''.obs;
  var usernameController = TextEditingController();

  RxString passwordControllerText = ''.obs;
  var passwordController = TextEditingController();
  RxBool isObscure = true.obs;

  RxString urlControllerText = ''.obs;
  var urlController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final RxString serverVersion = 'not found'.obs;

  Rxn<Version> nextcloudVersion = Rxn();

  bool get serverIsValid {
    //TODO check not by String. capability ENtity must be used
    return serverVersion.value != 'not found';
  }

  @override
  void onInit() {
    urlController.addListener(() {
      urlControllerText.value = urlController.text;
    });

    usernameController.addListener(() {
      usernameControllerText.value = usernameController.text;
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
    usernameControllerText.value = account != null ? account.username : '';
    usernameController.text = usernameControllerText.value;
    passwordControllerText.value = account != null ? account.password : '';
    passwordController.text = passwordControllerText.value;
  }

  login() async {
    var successful = false;
    try {
      successful = await authService.login(urlControllerText.value,
          usernameControllerText.value, passwordControllerText.value);
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
      serverVersion.value = resp.ocs.data.version.string;
      // _deckVersion.value = resp.ocs.data.version.string;
    } on DioException {
      serverVersion.value = 'not found';
      // _deckVersion.value = 'not found';
    }
    isLoading.value = false;
  }
}
