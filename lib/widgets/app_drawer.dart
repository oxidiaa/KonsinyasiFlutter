import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app/routes/app_pages.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
            child: Row(
              children: [
                const Text(
                  'Beranda',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.green[100],
                  child: const Icon(Icons.person, color: Colors.green),
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.people,
              color: Colors.green,
            ),
            title: const Text(
              'Penjualan & Mitra',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () => Get.toNamed(Routes.SALES_PARTNER),
          ),
          ListTile(
            leading: const Icon(
              Icons.shopping_cart,
              color: Colors.green,
            ),
            title: const Text(
              'Pembelian & Suplier',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              Get.back();
              Get.toNamed(Routes.SUPPLIER);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.notifications,
              color: Colors.green,
            ),
            title: const Text(
              'Notifikasi & Reminder',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              // TODO: Navigate to Notifikasi & Reminder
              Get.back();
              Get.toNamed(Routes.NOTIFICATION_REMINDER);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              color: Colors.green,
            ),
            title: const Text(
              'Pengaturan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              Get.back();
              Get.toNamed(Routes.PROFILE);
            },
          ),
        ],
      ),
    );
  }
}
