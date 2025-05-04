import 'package:get/get.dart';

class PaymentItem {
  final String id;
  final String name;
  bool isRead;

  PaymentItem({
    required this.id,
    required this.name,
    this.isRead = false,
  });
}

class NotificationReminderController extends GetxController {
  // Observable list of payment items
  final _paymentItems = <PaymentItem>[].obs;

  // Getter for payment items
  List<PaymentItem> get paymentItems => _paymentItems;

  // Unread count getter
  int get unreadCount => _paymentItems.where((item) => !item.isRead).length;

  @override
  void onInit() {
    super.onInit();
    _loadPaymentItems();
  }

  // Load initial payment items data
  void _loadPaymentItems() {
    _paymentItems.value = [
      PaymentItem(id: '1', name: 'Outlet L', isRead: false),
      PaymentItem(id: '2', name: 'Supliyer D', isRead: false),
      PaymentItem(id: '3', name: 'Supliyer A', isRead: false),
      PaymentItem(id: '4', name: 'Outlet E', isRead: false),
      PaymentItem(id: '5', name: 'Outlet J', isRead: false),
      PaymentItem(id: '6', name: 'Outlet A', isRead: false),
    ];
  }

  // Handle mark all as read
  void onMarkAllAsRead() {
    for (var item in _paymentItems) {
      item.isRead = true;
    }
    _paymentItems.refresh();
  }

  // Handle payment item tap
  void onPaymentItemTap(PaymentItem item) {
    final index = _paymentItems.indexWhere((element) => element.id == item.id);
    if (index != -1) {
      _paymentItems[index].isRead = true;
      _paymentItems.refresh();

      // Here you can add navigation or additional logic for tapping on a payment item
      Get.snackbar(
        'Payment Item Tapped',
        'You tapped on ${item.name}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Handle penjualan tap
  void onPenjualanTap() {
    Get.toNamed('/penjualan-list');
  }

  // Handle pembelian tap
  void onPembelianTap() {
    Get.toNamed('/pembelian-list');
  }
}
