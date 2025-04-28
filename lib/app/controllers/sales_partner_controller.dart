import 'package:get/get.dart';
import '../data/models/partner_model.dart';

class SalesPartnerController extends GetxController {
  final RxList<PartnerModel> partners = <PartnerModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadDummyPartners();
  }

  void loadDummyPartners() {
    partners.value = [
      PartnerModel(
        id: '1',
        name: 'A. Afina F',
        address: 'Jl. Example No. 1',
        phone: '08123456789',
        email: 'afina@example.com',
      ),
      PartnerModel(
        id: '2',
        name: 'Outlet B',
        address: 'Jl. Example No. 2',
        phone: '08234567890',
        email: 'outletb@example.com',
      ),
      PartnerModel(
        id: '3',
        name: 'Outlet C',
        address: 'Jl. Example No. 3',
        phone: '08345678901',
        email: 'outletc@example.com',
      ),
      PartnerModel(
        id: '4',
        name: 'Toko D',
        address: 'Jl. Example No. 4',
        phone: '08456789012',
        email: 'tokod@example.com',
      ),
      PartnerModel(
        id: '5',
        name: 'Warung E',
        address: 'Jl. Example No. 5',
        phone: '08567890123',
        email: 'warunge@example.com',
      ),
    ];
  }

  void searchPartners(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      loadDummyPartners();
    } else {
      final filteredList = partners
          .where((partner) =>
              partner.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      partners.value = filteredList;
    }
  }

  void createPartner(PartnerModel partner) {
    try {
      // Generate ID untuk partner baru
      final newId = (partners.length + 1).toString();
      final newPartner = PartnerModel(
        id: newId,
        name: partner.name,
        address: partner.address,
        phone: partner.phone,
        email: partner.email,
      );
      partners.add(newPartner);
      Get.back();
      Get.snackbar(
        'Sukses',
        'Partner berhasil ditambahkan',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal menambahkan partner',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void updatePartner(PartnerModel partner) {
    try {
      final index = partners.indexWhere((p) => p.id == partner.id);
      if (index != -1) {
        partners[index] = partner;
        Get.back();
        Get.snackbar(
          'Sukses',
          'Partner berhasil diupdate',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal mengupdate partner',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void deletePartner(String id) {
    try {
      partners.removeWhere((partner) => partner.id == id);
      Get.back();
      Get.snackbar(
        'Sukses',
        'Partner berhasil dihapus',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal menghapus partner',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void navigateToInvoice(String partnerId, String partnerName) {
    Get.toNamed('/invoice', arguments: {
      'partnerId': partnerId,
      'partnerName': partnerName,
    });
  }
}
