import 'package:get/get.dart';

class HomeController extends GetxController {
  // Observable variables for dashboard statistics
  final RxInt totalPartners = 0.obs;
  final RxInt totalProducts = 0.obs;
  final RxDouble totalSales = 0.0.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadDashboardData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Load dashboard statistics
  Future<void> loadDashboardData() async {
    isLoading.value = true;
    try {
      // TODO: Replace with actual API calls
      await Future.delayed(Duration(seconds: 1)); // Simulate network delay

      // Sample data - replace with actual data from your backend
      totalPartners.value = 15;
      totalProducts.value = 150;
      totalSales.value = 25000000;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load dashboard data',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Navigation methods
  void goToSalesPartners() {
    Get.toNamed('/sales-partner');
  }

  void goToInventory() {
    // TODO: Implement inventory route
    Get.snackbar(
      'Coming Soon',
      'Inventory management is under development',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void goToPurchase() {
    // TODO: Implement purchase route
    Get.snackbar(
      'Coming Soon',
      'Purchase management is under development',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void logout() {
    // TODO: Implement proper logout logic
    Get.offAllNamed('/login');
  }
}
