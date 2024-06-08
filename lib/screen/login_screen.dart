import 'package:deck_ng/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final LoginController _controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Obx(() => TextField(
                            controller: TextEditingController(
                                text: _controller.url.value),
                            onChanged: (value) {
                              _controller.url.value = value;
                              _controller.validateUrl(value);
                            },
                            decoration: InputDecoration(
                              labelText: 'URL or IP Address',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: Icon(Icons.link),
                            ),
                          )),
                      Obx(() => Text(
                            _controller.isUrlValid.value
                                ? _controller.serverInfo.value
                                : 'Invalid URL or IP Address',
                            style: TextStyle(
                              color: _controller.isUrlValid.value
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          )),
                      SizedBox(height: 10.0),
                      Obx(() => TextField(
                            controller: TextEditingController(
                                text: _controller.username.value),
                            onChanged: (value) =>
                                _controller.username.value = value,
                            decoration: InputDecoration(
                              labelText: 'Username',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: Icon(Icons.person),
                            ),
                          )),
                      SizedBox(height: 10.0),
                      Obx(() => TextField(
                            controller: TextEditingController(
                                text: _controller.password.value),
                            onChanged: (value) =>
                                _controller.password.value = value,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: Icon(Icons.lock),
                            ),
                          )),
                      SizedBox(height: 20.0),
                      Obx(() => ElevatedButton(
                            onPressed: _controller.isLoading.value
                                ? null
                                : _controller.login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.blueAccent, // Updated parameter
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                            ),
                            child: _controller.isLoading.value
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text('Login'),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
