import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // Observable variables
  final RxString userName = 'Ayu Herbal'.obs;
  final RxString userRole = 'Distributor Herbal Kesehatan'.obs;
  final RxString whatsapp = '0857-7838-2939'.obs;

  // Observable lists
  final RxList<Map<String, dynamic>> statistics = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize data
    loadStatistics();
  }

  void openDrawer() {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  void loadStatistics() {
    // Example data
    statistics.value = [
      {'month': 'Jan', 'value': 10},
      {'month': 'Feb', 'value': 15},
      {'month': 'Mar', 'value': 8},
    ];
  }

  void navigateToSales() {
    Get.toNamed('/sales-partner');
  }

  void navigateToInventory() {
    Get.toNamed('/inventory');
  }

  void navigateToPurchase() {
    Get.toNamed('/purchase');
  }
}
