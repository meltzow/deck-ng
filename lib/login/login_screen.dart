import 'package:deck_ng/component/drawer_widget.dart';
import 'package:deck_ng/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final LoginController _controller = Get.find<LoginController>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: const Text('Nextcloud deck NG'),
      ),
      body: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Welcome back!",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    fontSize: 22,
                    color: Color(0xff000000),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Text(
                    "Login to Continue",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 18,
                      color: Color(0xffa29b9b),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Image(
                      image: const AssetImage("assets/images/placeIndex.png"),
                      height: 120,
                      width: 120,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                TextField(
                  key: const Key('serverUrl'),
                  controller: _controller.urlController,
                  focusNode: _controller.focusNode,
                  onChanged: (value) {
                    _controller.url.value = value;
                    _controller.startValidationTimer(value);
                  },
                  decoration: InputDecoration(
                    labelText: 'URL or IP Address',
                    prefixIcon: const Icon(Icons.link),
                  ),
                ),
                Obx(() => Text(
                      _controller.urlErrorMessage.value.isNotEmpty
                          ? _controller.urlErrorMessage.value
                          : _controller.nextcloudVersionString.value,
                      style: TextStyle(
                        color: _controller.isUrlValid.value
                            ? Colors.green
                            : Colors.red,
                      ),
                    )),
                const SizedBox(height: 10.0),
                TextField(
                  key: const Key('username'),
                  controller: _controller.userNameController,
                  onChanged: (value) => _controller.username.value = value,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 10.0),
                Obx(() => TextField(
                      key: const Key('password'),
                      controller: _controller.passwordController,
                      onChanged: (value) => _controller.password.value = value,
                      obscureText: !_controller.isPasswordVisible.value,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _controller.isPasswordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: _controller.togglePasswordVisibility,
                        ),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 50),
                  child: MaterialButton(
                    onPressed: _controller.login,
                    color: const Color(0xff3a57e8),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    textColor: const Color(0xffffffff),
                    height: 50,
                    minWidth: MediaQuery.of(context).size.width,
                  ),
                ),
                MaterialButton(
                  onPressed: _controller.scanBarcode,
                  color: const Color(0x2d3a57e8),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                    "Login with QR-Code",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  textColor: const Color(0xff3a57e8),
                  height: 50,
                  minWidth: MediaQuery.of(context).size.width,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
