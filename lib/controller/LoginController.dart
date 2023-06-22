import 'package:deck_ng/model/board.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  RxString nameControllerText = ''.obs;
  TextEditingController nameController = TextEditingController();
  RxString passwordControllerText = ''.obs;
  TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    nameController.addListener(() {
      nameControllerText.value = nameController.text;
    });

    debounce(nameControllerText, (_) {
      print("debouce$_");
    }, time: Duration(seconds: 1));

    passwordController.addListener(() {
      passwordControllerText.value = passwordController.text;
    });

    debounce(passwordControllerText, (_) {
      print("debouce$_");
    }, time: Duration(seconds: 1));

    super.onInit();
  }

}
