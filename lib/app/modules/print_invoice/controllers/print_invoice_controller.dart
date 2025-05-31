import 'package:get/get.dart';

class PrintInvoiceController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxMap<String, dynamic> invoiceData = <String, dynamic>{}.obs;
  final RxString printerSize = 'EPSON TM-T82'.obs;
  final RxString destination = 'Local Printer'.obs;
  final RxString pages = 'All'.obs;
  final RxInt copies = 1.obs;
  final RxString layout = 'Portrait'.obs;
  final RxString color = 'Color'.obs;
  final RxString partnerName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Get invoice data from arguments
    final args = Get.arguments as Map<String, dynamic>;
    invoiceData.value = args;
    partnerName.value = args['partnerName'] ?? '';
  }

  void updatePrinterSize(String size) {
    printerSize.value = size;
  }

  void updateDestination(String dest) {
    destination.value = dest;
  }

  void updatePages(String pg) {
    pages.value = pg;
  }

  void updateCopies(int value) {
    copies.value = value;
  }

  void updateLayout(String value) {
    layout.value = value;
  }

  void updateColor(String value) {
    color.value = value;
  }

  void print() {
    isLoading.value = true;
    // TODO: Implement actual printing functionality
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
      Get.snackbar(
        'Success',
        'Invoice printed successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.back();
    });
  }

  void cancel() {
    Get.back();
  }

  void setPrinterSize(String value) {
    printerSize.value = value;
  }

  void setDestination(String value) {
    destination.value = value;
  }

  void setPages(String value) {
    pages.value = value;
  }

  void setCopies(int value) {
    copies.value = value;
  }

  void setLayout(String value) {
    layout.value = value;
  }

  void setColor(String value) {
    color.value = value;
  }

  void printInvoice() {
    // TODO: Implement actual printing functionality
    Get.snackbar(
      'Success',
      'Invoice printed successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
    Get.back();
  }
}
