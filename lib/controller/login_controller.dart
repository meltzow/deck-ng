import 'package:deck_ng/service/Iauth_service.dart';
import 'package:deck_ng/service/Icredential_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var credService = Get.find<ICredentialService>();
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
    var credService = Get.find<ICredentialService>();
    var account = await credService.getAccount();

    urlControllerText.value = account.url;
    urlController.text = urlControllerText.value;
    nameControllerText.value = account.username;
    nameController.text = nameControllerText.value;
    passwordControllerText.value = account.password;
    passwordController.text = passwordControllerText.value;
  }

  login() async {
    var successful = await authService.login(urlControllerText.value);
    if (successful) {
      credService.saveCredentials(urlControllerText.value,
          nameControllerText.value, passwordControllerText.value, true);
      Get.toNamed('/boards');
    } else {
      Fluttertoast.showToast(
          msg: "This is Center Short Toast",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
}
