import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalesPartnerController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<Map<String, dynamic>> partners = <Map<String, dynamic>>[].obs;
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadPartners();
    searchController.addListener(() {
      searchQuery.value = searchController.text;
      filterPartners();
    });
  }

  // List of all partners (unfiltered)
  final List<Map<String, dynamic>> _allPartners = [
    {
      'id': 1,
      'name': 'Toko Sejahtera',
      'address': 'Jl. Raya Bogor No. 123',
      'phone': '08123456789',
      'email': 'sejahtera@email.com',
    },
    {
      'id': 2,
      'name': 'Warung Barokah',
      'address': 'Jl. Sudirman No. 45',
      'phone': '08234567890',
      'email': 'barokah@email.com',
    },
    {
      'id': 3,
      'name': 'Minimarket Makmur',
      'address': 'Jl. Gatot Subroto No. 67',
      'phone': '08345678901',
      'email': 'makmur@email.com',
    },
    {
      'id': 4,
      'name': 'Toko Berkah',
      'address': 'Jl. Ahmad Yani No. 89',
      'phone': '08456789012',
      'email': 'berkah@email.com',
    },
    {
      'id': 5,
      'name': 'Warung Jaya',
      'address': 'Jl. Diponegoro No. 34',
      'phone': '08567890123',
      'email': 'jaya@email.com',
    },
  ];

  void loadPartners() {
    try {
      isLoading.value = true;
      partners.value = List.from(_allPartners);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load partners',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void filterPartners() {
    if (searchQuery.value.isEmpty) {
      partners.value = List.from(_allPartners);
      return;
    }

    final query = searchQuery.value.toLowerCase();
    partners.value = _allPartners.where((partner) {
      final name = partner['name'].toString().toLowerCase();
      final address = partner['address'].toString().toLowerCase();
      final phone = partner['phone'].toString().toLowerCase();
      final email = partner['email'].toString().toLowerCase();

      return name.contains(query) ||
          address.contains(query) ||
          phone.contains(query) ||
          email.contains(query);
    }).toList();
  }

  void goToInvoice(int partnerId) {
    final partner = _allPartners.firstWhere(
      (p) => p['id'] == partnerId,
      orElse: () => {},
    );

    if (partner.isEmpty) {
      Get.snackbar(
        'Error',
        'Partner not found',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    Get.toNamed('/invoice', arguments: partnerId);
  }

  void addPartner() {
    Get.snackbar(
      'Info',
      'Add partner feature coming soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void editPartner(int partnerId) {
    Get.snackbar(
      'Info',
      'Edit partner feature coming soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void deletePartner(int partnerId) {
    Get.dialog(
      AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this partner?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Remove from both lists
              _allPartners.removeWhere((p) => p['id'] == partnerId);
              partners.removeWhere((p) => p['id'] == partnerId);
              Get.back();
              Get.snackbar(
                'Success',
                'Partner deleted successfully',
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
