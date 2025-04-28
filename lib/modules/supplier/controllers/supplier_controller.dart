import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupplierController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<Map<String, dynamic>> suppliers = <Map<String, dynamic>>[].obs;
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadSuppliers();
    searchController.addListener(() {
      searchQuery.value = searchController.text;
      filterSuppliers();
    });
  }

  // List of all suppliers (unfiltered)
  final List<Map<String, dynamic>> _allSuppliers = [
    {'id': 1, 'name': 'Al-jazira', 'products': []},
    {'id': 2, 'name': 'Supliyer B', 'products': []},
    {'id': 3, 'name': 'Supliyer C', 'products': []},
    {'id': 4, 'name': 'Supliyer D', 'products': []},
    {'id': 5, 'name': 'Supliyer E', 'products': []},
    {'id': 6, 'name': 'Supliyer F', 'products': []},
    {'id': 7, 'name': 'Supliyer G', 'products': []},
    {'id': 8, 'name': 'Supliyer H', 'products': []},
    {'id': 9, 'name': 'Supliyer I', 'products': []},
    {'id': 10, 'name': 'Supliyer J', 'products': []},
    {'id': 11, 'name': 'Supliyer K', 'products': []},
    {'id': 12, 'name': 'Supliyer L', 'products': []},
    {'id': 13, 'name': 'Supliyer M', 'products': []},
    {'id': 14, 'name': 'Supliyer N', 'products': []},
    {'id': 15, 'name': 'Supliyer O', 'products': []},
  ];

  void loadSuppliers() {
    try {
      isLoading.value = true;
      suppliers.value = List.from(_allSuppliers);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load suppliers',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void filterSuppliers() {
    if (searchQuery.value.isEmpty) {
      suppliers.value = List.from(_allSuppliers);
      return;
    }

    final query = searchQuery.value.toLowerCase();
    suppliers.value = _allSuppliers.where((supplier) {
      final name = supplier['name'].toString().toLowerCase();
      return name.contains(query);
    }).toList();
  }

  void viewProducts(int supplierId) {
    final supplier = _allSuppliers.firstWhere(
      (s) => s['id'] == supplierId,
      orElse: () => {},
    );

    if (supplier.isEmpty) {
      Get.snackbar(
        'Error',
        'Supplier not found',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // TODO: Navigate to supplier products page
    Get.toNamed('/supplier-products', arguments: supplier);
  }

  void addSupplier() {
    Get.dialog(
      AlertDialog(
        title: const Text('Add New Supplier'),
        content: const Text('Add supplier feature coming soon'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void editSupplier(int supplierId) {
    Get.dialog(
      AlertDialog(
        title: const Text('Edit Supplier'),
        content: const Text('Edit supplier feature coming soon'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void deleteSupplier(int supplierId) {
    Get.dialog(
      AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this supplier?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Remove from both lists
              _allSuppliers.removeWhere((s) => s['id'] == supplierId);
              suppliers.removeWhere((s) => s['id'] == supplierId);
              Get.back();
              Get.snackbar(
                'Success',
                'Supplier deleted successfully',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
