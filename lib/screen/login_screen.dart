import 'package:deck_ng/component/drawer_widget.dart';
import 'package:deck_ng/component/loading_indicator.dart';
import 'package:deck_ng/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller =
      Get.put<LoginController>(LoginController());

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(),
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Image(
                  image: AssetImage("assets/images/icon.png"),
                  height: 90,
                  width: 90,
                  fit: BoxFit.cover,
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 30),
                  child: Text(
                    "deck NG",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize: 20,
                      color: Color(0xff3a57e8),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'sign in'.tr,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize: 24,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: TextFormField(
                    validator: (value) {
                      return 'ffffl';
                    },
                    focusNode: controller.focusNode,
                    controller: controller.urlController,
                    obscureText: false,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      hintText: "enter nextcloud server url".tr,
                      labelText: "Nextcloud server url".tr,
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                      ),
                      isDense: false,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      prefixIcon: const Icon(Icons.insert_link, size: 24),
                    ),
                  ),
                ),
                Obx(
                  () => controller.isLoading.value
                      ? const LoadingIndicator()
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: ListTile(
                                title: const Text("Nextcloud server"),
                                subtitle: Text(controller.serverVersion),
                                // )),
                                // Expanded(
                                //     child: ListTile(
                                //   title: const Text("deck version"),
                                //   subtitle: Text(controller.serverVersion),
                                trailing: controller.serverIsValid
                                    ? const Icon(Icons.verified_outlined)
                                    : const Icon(Icons.error_outline),
                              ))
                            ],
                          )),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                  child: TextFormField(
                    controller: controller.nameController,
                    obscureText: false,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      labelText: "username",
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                      ),
                      isDense: false,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      prefixIcon: const Icon(Icons.person, size: 24),
                    ),
                  ),
                ),
                Obx(() => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 0),
                      child: TextFormField(
                        controller: controller.passwordController,
                        obscureText: controller.isObscure.value,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          labelText: "Password".tr,
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                          ),
                          isDense: false,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          prefixIcon:
                              const Icon(Icons.admin_panel_settings, size: 24),
                          suffixIcon: IconButton(
                              icon: Icon(controller.isObscure.value
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                controller.isObscure.value =
                                    !controller.isObscure.value;
                              }),
                        ),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 1,
                        child: MaterialButton(
                          onPressed: () {
                            controller.login();
                          },
                          color: Theme.of(context).colorScheme.primary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          padding: const EdgeInsets.all(16),
                          textColor: const Color(0xffffffff),
                          height: 40,
                          minWidth: 140,
                          child: Text(
                            "Login".tr,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
