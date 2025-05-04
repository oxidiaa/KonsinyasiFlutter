import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.green,
            ),
            child: Row(
              children: const [
                Icon(Icons.store, color: Colors.white, size: 40),
                SizedBox(width: 12),
                Text(
                  'Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.description, color: Colors.green),
            title: const Text('Pembelian & Supliyer'),
            onTap: () {
              Get.back();
              Get.toNamed('/supplier');
            },
          ),
          // Menu dummy lain
          ListTile(
            leading: const Icon(Icons.home, color: Colors.grey),
            title: const Text('Home'),
            onTap: () {
              Get.back();
              Get.toNamed('/home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.grey),
            title: const Text('Settings'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
