import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            child: const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Boards'),
            ),
            onTap: () => Get.toNamed('/boards'),
          ),
          ListTile(
            title: const Text('Board 1'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Get.toNamed('/boards');
            },
          ),
          ListTile(
            title: const Text('Login'),
            onTap: () {
              Get.toNamed('/auth/login');
            },
          ),
        ],
      ),
    );
  }
}
