import 'package:get/get.dart';
import '../data/models/invoice_model.dart';
import '../data/models/product_model.dart';

class InvoiceController extends GetxController {
  final RxList<InvoiceModel> invoices = <InvoiceModel>[].obs;
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
    loadDummyInvoices();
  }

  void loadDummyInvoices() {
    invoices.value = [
      InvoiceModel(
        id: '1',
        partnerId: '1',
        date: DateTime.now(),
        products: [
          ProductModel(
            id: '1',
            name: 'Product A',
            initialQuantity: 10,
            newQuantity: 5,
            totalStock: 15,
            price: 100000,
          ),
          ProductModel(
            id: '2',
            name: 'Product B',
            initialQuantity: 20,
            newQuantity: 8,
            totalStock: 28,
            price: 150000,
          ),
        ],
      ),
      InvoiceModel(
        id: '2',
        partnerId: '1',
        date: DateTime.now().subtract(const Duration(days: 30)),
        products: [
          ProductModel(
            id: '3',
            name: 'Product C',
            initialQuantity: 15,
            newQuantity: 7,
            totalStock: 22,
            price: 75000,
          ),
        ],
      ),
    ];
  }

  void filterByMonth(String month) {
    selectedMonth.value = month;
    // Implementasi filter berdasarkan bulan bisa ditambahkan di sini
  }

  void printInvoice(String invoiceId) {
    // Implementasi print invoice bisa ditambahkan di sini
    Get.toNamed('/print-invoice', arguments: {'invoiceId': invoiceId});
  }

  void navigateToPrintInvoice() {
    Get.toNamed('/print-invoice', arguments: {
      'partnerName': partnerName.value,
      'products': invoices.value.first.products,
    });
  }
}
