import 'package:get/get.dart';
import 'package:intl/intl.dart';

// Model Product
class Product {
  final String name;
  final int initialQuantity;
  final int newQuantity;
  final int totalStock;

  Product({
    required this.name,
    required this.initialQuantity,
    required this.newQuantity,
    required this.totalStock,
  });
}

// Model Invoice
class Invoice {
  final DateTime date;
  final List<Product> products;

  Invoice({
    required this.date,
    required this.products,
  });
}

class InvoiceController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString selectedMonth = ''.obs;
  final RxString partnerName = ''.obs;
  final invoices = <Invoice>[].obs;

  @override
  void onInit() {
    super.onInit();
    final partnerId = Get.arguments as int;
    loadPartnerData(partnerId);
    loadInvoices();
  }

  void loadPartnerData(int partnerId) {
    // Dummy partner data for testing
    partnerName.value = 'Partner $partnerId';
  }

  void loadInvoices() {
    isLoading.value = true;
    // Dummy invoice and product data for testing
    invoices.value = [
      Invoice(
        date: DateTime.now(),
        products: [
          Product(
            name: 'Product 1',
            initialQuantity: 100,
            newQuantity: 75,
            totalStock: 25,
          ),
          Product(
            name: 'Product 2',
            initialQuantity: 50,
            newQuantity: 30,
            totalStock: 20,
          ),
        ],
      ),
    ];
    isLoading.value = false;
  }

  void filterByMonth(String month) {
    selectedMonth.value = month;
    // TODO: Implement actual filtering logic if needed
  }

  void navigateToPrintInvoice() {
    Get.toNamed('/print-invoice', arguments: {
      'partnerName': partnerName.value,
      'invoices': invoices,
      'month': selectedMonth.value,
    });
  }
}
