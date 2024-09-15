import 'package:deck_ng/component/drawer_widget.dart';
import 'package:deck_ng/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final LoginController _controller = Get.find<LoginController>();
  final GlobalKey _tooltipKey = GlobalKey();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: const Text('deck NG'),
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Text(
                    'Welcome back to deck NG!',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20.0),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
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
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
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
                            onChanged: (value) =>
                                _controller.username.value = value,
                            decoration: InputDecoration(
                              labelText: 'Username',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: const Icon(Icons.person),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Obx(() => TextField(
                                key: const Key('password'),
                                controller: _controller.passwordController,
                                onChanged: (value) =>
                                    _controller.password.value = value,
                                obscureText:
                                    !_controller.isPasswordVisible.value,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  prefixIcon: const Icon(Icons.lock),
                                  suffixIcon: Row(
                                    mainAxisSize: MainAxisSize
                                        .min, // Prevent icon overflow
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          _controller.isPasswordVisible.value
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                        onPressed: _controller
                                            .togglePasswordVisibility,
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                          const SizedBox(height: 20.0),
                          Center(
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                Obx(() => ElevatedButton(
                                      onPressed: _controller.isFormValid.value
                                          ? _controller.login
                                          : null,
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15.0),
                                      ),
                                      child: _controller.isLoading.value
                                          ? const CircularProgressIndicator(
                                              color: Colors.white)
                                          : const Text('Login'),
                                    )),
                                const SizedBox(width: 10.0),
                                ElevatedButton.icon(
                                  onPressed: _controller.scanBarcode,
                                  icon: const Icon(Icons.qr_code_scanner),
                                  label: const Text('Login with Barcode'),
                                )
                              ]))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
