import 'package:deck_ng/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wiredash/wiredash.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

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
            title: const Text('language'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
            },
          ),
          ListTile(
            title: const Text('settings'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
            },
          ),
          ListTile(
            title: const Text('Login'),
            onTap: () {
              Get.toNamed('/auth/login');
            },
          ),
          ListTile(
            leading: const Icon(Icons.rate_review_outlined),
            title: const Text('feedback'),
            onTap: () {
              Navigator.pop(context);
              Wiredash.of(context).show(inheritMaterialTheme: true);
            },
          ),
        ],
      ),
    );
  }
}
