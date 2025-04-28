import 'package:get/get.dart';

class InvoiceController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList products = [].obs;
  final RxString selectedMonth = ''.obs;
  final RxMap partner = {}.obs;

  @override
  void onInit() {
    super.onInit();
    // Get partner ID from arguments
    final partnerId = Get.arguments as int;
    loadPartnerData(partnerId);
    loadProducts();
  }

  void loadPartnerData(int partnerId) {
    // Dummy partner data for testing
    partner.value = {
      'id': partnerId,
      'name': 'Partner $partnerId',
      'address': 'Jl. Example No. $partnerId',
      'phone': '08123456789',
    };
  }

  void loadProducts() {
    isLoading.value = true;
    // Dummy product data for testing
    products.value = [
      {
        'id': 1,
        'name': 'Product 1',
        'initial_qty': 100,
        'current_qty': 75,
        'total_stock': 25,
      },
      {
        'id': 2,
        'name': 'Product 2',
        'initial_qty': 50,
        'current_qty': 30,
        'total_stock': 20,
      },
    ];
    isLoading.value = false;
  }

  void selectMonth(String month) {
    selectedMonth.value = month;
    // TODO: Implement filtering by month
  }

  void printInvoice() {
    Get.toNamed('/print-invoice', arguments: {
      'partner': partner.value,
      'products': products,
      'month': selectedMonth.value,
    });
  }
}
