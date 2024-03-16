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
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          GestureDetector(
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: myTheme.primaryColor,
              ),
              child: Text('dashboard'.tr),
            ),
            onTap: () => Get.toNamed('/'),
          ),
          ListTile(
            leading: const Icon(Icons.note_add),
            title: const Text('Board 1'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Get.toNamed('/boards');
            },
          ),
          ListTile(
            title: const Text('settings'),
            leading: const Icon(Icons.settings_outlined),
            onTap: () {
              Get.toNamed('/settings');
            },
          ),
          Obx(
            () => ListTile(
              title: controller.isAuth.value
                  ? const Text('Logout')
                  : const Text('Login'),
              leading: const Icon(Icons.login_outlined),
              onTap: () {
                controller.logout();
                Get.toNamed('/auth/login');
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.rate_review_outlined),
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
              Get.toNamed('/licenses');
            },
          ),
        ],
      ),
    );
  }
}
