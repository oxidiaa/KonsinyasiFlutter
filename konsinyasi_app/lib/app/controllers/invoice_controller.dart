import 'package:get/get.dart';
import '../data/models/invoice_model.dart';
import '../data/models/product_model.dart';
import '../data/providers/api_provider.dart';

class InvoiceController extends GetxController {
  final ApiProvider apiProvider = Get.find<ApiProvider>();
  final RxList<ProductModel> products = <ProductModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString selectedMonth = ''.obs;
  final RxString partnerName = ''.obs;
  final RxString partnerId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>;
    partnerName.value = args['partnerName'];
    partnerId.value = args['partnerId'];
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      isLoading.value = true;
      final result = await apiProvider.getProducts();
      products.value = result;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load products',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void selectMonth(String month) {
    selectedMonth.value = month;
    // Implement month selection logic
  }

  void navigateToPrintInvoice() {
    Get.toNamed('/print-invoice', arguments: {
      'partnerName': partnerName.value,
      'products': products,
    });
  }
}
