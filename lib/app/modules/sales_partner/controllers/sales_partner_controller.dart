import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SalesPartnerController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<PartnerModel> partners = <PartnerModel>[].obs;
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPartners();
    searchController.addListener(() {
      searchQuery.value = searchController.text;
      filterPartners();
    });
  }

  // List of all partners (unfiltered)
  final List<PartnerModel> _allPartners = [];

  // Fetch data mitra dari tabel SQL 'mitra'
  Future<void> fetchPartners() async {
    try {
      isLoading.value = true;
      final supabase = Supabase.instance.client;
      final response = await supabase.from('mitra').select().execute();
      if (response.error != null) {
        Get.snackbar(
          'Error',
          response.error!.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
      final List<dynamic> data = response.data;
      _allPartners.clear();
      _allPartners.addAll(data.map((item) => PartnerModel(
            id: item['id'].toString(),
            name: item['nama_mtr'] ?? '',
            address: item['alamat_mtr'],
            phone: item['telepon_mtr'],
            email: item['email_mtr'],
          )));
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
      final name = partner.name.toLowerCase();
      final address = (partner.address ?? '').toLowerCase();
      final phone = (partner.phone ?? '').toLowerCase();
      final email = (partner.email ?? '').toLowerCase();

      return name.contains(query) ||
          address.contains(query) ||
          phone.contains(query) ||
          email.contains(query);
    }).toList();
  }

  void searchPartners(String query) {
    searchQuery.value = query;
    filterPartners();
  }

  void navigateToInvoice(String partnerId, String partnerName) {
    Get.toNamed('/invoice', arguments: int.tryParse(partnerId) ?? partnerId);
    // Jika ingin mengirim partnerName juga:
    // Get.toNamed('/invoice', arguments: {'id': partnerId, 'name': partnerName});
  }

  // Update mitra di database
  Future<void> updatePartner(PartnerModel updatedPartner) async {
    final supabase = Supabase.instance.client;
    try {
      isLoading.value = true;
      final response = await supabase
          .from('mitra')
          .update({
            'nama_mtr': updatedPartner.name,
            'alamat_mtr': updatedPartner.address,
            'telepon_mtr': updatedPartner.phone,
            'email_mtr': updatedPartner.email,
          })
          .eq('id', updatedPartner.id)
          .execute();
      if (response.error != null) {
        Get.snackbar(
          'Error',
          response.error!.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
      await fetchPartners();
      Get.back();
      Get.snackbar(
        'Success',
        'Partner updated successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Tambah mitra ke database
  Future<void> createPartner(PartnerModel newPartner) async {
    final supabase = Supabase.instance.client;
    try {
      isLoading.value = true;
      final response = await supabase.from('mitra').insert({
        'nama_mtr': newPartner.name,
        'alamat_mtr': newPartner.address,
        'telepon_mtr': newPartner.phone,
        'email_mtr': newPartner.email,
      }).execute();
      if (response.error != null) {
        Get.snackbar(
          'Error',
          response.error!.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
      await fetchPartners();
      Get.back();
      Get.snackbar(
        'Success',
        'Partner added successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Hapus mitra dari database
  Future<void> deletePartner(String partnerId) async {
    final supabase = Supabase.instance.client;
    try {
      isLoading.value = true;
      final response =
          await supabase.from('mitra').delete().eq('id', partnerId).execute();
      if (response.error != null) {
        Get.snackbar(
          'Error',
          response.error!.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
      await fetchPartners();
      Get.back();
      Get.snackbar(
        'Success',
        'Partner deleted successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}

// Model PartnerModel sesuai tabel mitra
class PartnerModel {
  final String id;
  final String name;
  final String? address;
  final String? phone;
  final String? email;

  PartnerModel({
    required this.id,
    required this.name,
    this.address,
    this.phone,
    this.email,
  });
}
