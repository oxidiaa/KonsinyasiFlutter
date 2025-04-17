import 'package:get/get.dart';
import '../data/models/partner_model.dart';
import '../data/providers/api_provider.dart';

class SalesPartnerController extends GetxController {
  final ApiProvider apiProvider = Get.find<ApiProvider>();
  final RxList<PartnerModel> partners = <PartnerModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadPartners();
  }

  Future<void> loadPartners() async {
    try {
      isLoading.value = true;
      final result = await apiProvider.getPartners();
      partners.value = result;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load partners',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void searchPartners(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      loadPartners();
    } else {
      partners.value = partners
          .where((partner) =>
              partner.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void navigateToInvoice(String partnerId, String partnerName) {
    Get.toNamed('/invoice', arguments: {
      'partnerId': partnerId,
      'partnerName': partnerName,
    });
  }

  void editPartner(PartnerModel partner) {
    // Implement edit partner logic
  }

  void deletePartner(String partnerId) {
    // Implement delete partner logic
  }
}
