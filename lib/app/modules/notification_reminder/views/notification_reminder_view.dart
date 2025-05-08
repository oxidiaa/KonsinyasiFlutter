import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/notification_reminder_controller.dart';

class NotificationReminderView extends GetView<NotificationReminderController> {
  const NotificationReminderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Notifikasi & Remainder',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Get.toNamed('/home'); // Navigate back to the home page
          },
        ),
      ),
      body: Column(
        children: [
          _buildListSection(),
          _buildPaymentStatusSection(),
          Expanded(child: _buildPaymentsList()),
        ],
      ),
    );
  }

  Widget _buildListSection() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _buildListTile(
            icon: Icons.description,
            title: 'List Tagihan Penjualan',
            onTap: () {
              Get.toNamed('/billing'); // Add route navigation
            },
          ),
          const Divider(height: 1, indent: 20, endIndent: 20),
          _buildListTile(
            icon: Icons.description,
            title: 'List Tagihan Pembelian',
            onTap: () {
              Get.toNamed('/bill-pembelian'); // Add route navigation
            },
          ),
        ],
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF1B9570).withOpacity(0.1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(icon, color: const Color(0xFF1B9570), size: 24),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.black),
      onTap: onTap,
    );
  }

  Widget _buildPaymentStatusSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.black12, width: 1),
          bottom: BorderSide(color: Colors.black12, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Status Pembayaran',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          GestureDetector(
            onTap: controller.onMarkAllAsRead,
            child: Text(
              'Tandai Sudah Dibaca (${controller.unreadCount})',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF1B9570),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentsList() {
    return Obx(() => ListView.builder(
          itemCount: controller.paymentItems.length,
          itemBuilder: (context, index) {
            final item = controller.paymentItems[index];
            return _buildPaymentItem(item);
          },
        ));
  }

  Widget _buildPaymentItem(PaymentItem item) {
    return Container(
      color: item.isRead ? Colors.white : const Color(0xFFDCF1E9),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF1B9570).withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Icon(
            Icons.account_balance_wallet,
            color: Color(0xFF1B9570),
            size: 24,
          ),
        ),
        title: Text(
          item.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          'Pembayaran Lunas',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        onTap: () => controller.onPaymentItemTap(item),
      ),
    );
  }
}
