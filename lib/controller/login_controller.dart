import 'package:deck_ng/service/Icredential_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class LoginController extends GetxController {
  final RxBool isLoading = RxBool(true);
  RxString nameControllerText = ''.obs;
  var nameController = TextEditingController();
  RxString passwordControllerText = ''.obs;
  var passwordController = TextEditingController();
  RxString urlControllerText = ''.obs;
  var urlController = TextEditingController();

  final LocalAuthentication auth = LocalAuthentication();
  Rx<_SupportState> _supportState = _SupportState.unknown.obs;
  Rx<bool>? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  Rx<bool> _isAuthenticating = Rx(false);

  @override
  void onInit() {
    urlController.addListener(() {
      urlControllerText.value = urlController.text;
    });

    // debounce(urlControllerText, (_) {
    //   print("debouce$_");
    // }, time: const Duration(seconds: 1));

    nameController.addListener(() {
      nameControllerText.value = nameController.text;
    });

    // debounce(nameControllerText, (_) {
    //   print("debouce$_");
    // }, time: Duration(seconds: 1));

    passwordController.addListener(() {
      passwordControllerText.value = passwordController.text;
    });

    // debounce(passwordControllerText, (_) {
    //   print("debouce$_");
    // }, time: Duration(seconds: 1));

    super.onInit();

    auth.isDeviceSupported().then(
          (bool isSupported) => _supportState = isSupported
              ? _SupportState.supported.obs
              : _SupportState.unsupported.obs,
        );
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
    var credService = Get.find<ICredentialService>();
    credService.saveCredentials(urlControllerText.value,
        nameControllerText.value, passwordControllerText.value, true);
    Get.toNamed('/boards');
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}
