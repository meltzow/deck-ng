import 'package:deck_ng/app_routes.dart';
import 'package:deck_ng/controller/drawer_controller.dart' as deck;
import 'package:deck_ng/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wiredash/wiredash.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key});

  final deck.DrawerController controller =
      Get.put<deck.DrawerController>(deck.DrawerController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          GestureDetector(
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: myTheme.primaryColor,
              ),
              child: Text('deck NG'.tr,
                  style: const TextStyle(color: Colors.white, fontSize: 24)),
            ),
            onTap: () => Get.toNamed(AppRoutes.home),
          ),
          Obx(
            () => controller.isAuth.value
                ? ListTile(
                    title: const Text('Dashboard'),
                    leading: const Icon(Icons.dashboard_outlined),
                    onTap: () {
                      Get.offNamed(AppRoutes.home);
                    },
                  )
                : const SizedBox.shrink(),
          ),
          // Obx(() => ListTile(
          //       title: const Text('settings'),
          //       leading: const Icon(Icons.settings_outlined),
          //       onTap: () {
          //         Get.toNamed(AppRoutes.settings);
          //       },
          //     )),
          Obx(
            () => ListTile(
              title: controller.isAuth.value
                  ? const Text('Logout')
                  : const Text('Login'),
              leading: controller.isAuth.value
                  ? const Icon(Icons.logout_outlined)
                  : const Icon(Icons.login_outlined),
              onTap: () {
                controller.logout();
                Get.offNamed(AppRoutes.login);
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.feedback_outlined),
            title: Text('feedback'.tr),
            onTap: () {
              Navigator.pop(context);
              Wiredash.of(context).show(inheritMaterialTheme: true);
            },
          ),
          ListTile(
            leading: const Icon(Icons.local_police_outlined),
            title: Text('licenses'.tr),
            onTap: () {
              Get.toNamed(AppRoutes.licenses);
            },
          ),
          ListTile(
            leading: const Icon(Icons.local_police_outlined),
            title: Text('privacy policy'.tr),
            onTap: () {
              Get.toNamed(AppRoutes.privacyPolicy);
            },
          ),
        ],
      ),
    );
  }
}
