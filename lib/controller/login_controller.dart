import 'package:deck_ng/service/Iauth_service.dart';
import 'package:deck_ng/service/Icredential_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var credService = Get.find<IStorageService>();
  var authService = Get.find<IAuthService>();

  final RxBool isLoading = RxBool(true);
  RxString nameControllerText = ''.obs;
  var nameController = TextEditingController();
  RxString passwordControllerText = ''.obs;
  var passwordController = TextEditingController();
  RxString urlControllerText = ''.obs;
  var urlController = TextEditingController();
  final FocusNode focusNode = FocusNode();

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
      //FIXME: if focus lost => check server url for validation
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
        Get.showSnackbar(
          const GetSnackBar(
            title: 'Login',
            message: 'Login Successful',
            icon: Icon(Icons.login),
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        Get.showSnackbar(
          const GetSnackBar(
            title: 'Login',
            message: 'Login not Successful',
            icon: Icon(Icons.update),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } on DioException catch (e) {
      Get.showSnackbar(
        const GetSnackBar(
          title: 'Login',
          message: 'Login not Successful',
          icon: Icon(Icons.update),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
