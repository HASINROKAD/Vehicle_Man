import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_man/app/modules/auth/auth_controller.dart';
import 'package:vehicle_man/app/routes/app_routes.dart';

class CustomHomeDrawer extends GetView<AuthController> {
  const CustomHomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40),
            ),
            arrowColor: Colors.black45,

            accountName: Obx(() => Text(controller.name.value)),
            accountEmail: Obx(() => Text(controller.emailToShow.value)),
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () {
              controller.logout();
            },
          ),
          ListTile(
            leading: const Icon(Icons.cloud, color: Colors.green),
            title: const Text(
              'Wheather',
              style: TextStyle(color: Colors.green),
            ),
            onTap: () {
              Get.toNamed(AppRoutes.weatherView);
            },
          ),
        ],
      ),
    );
  }
}
