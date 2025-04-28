import 'package:get/get.dart';

class PrintInvoiceController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxMap<String, dynamic> invoiceData = <String, dynamic>{}.obs;
  final RxString printerSize = 'EPSON TM-T82'.obs;
  final RxInt copies = 1.obs;
  final RxString layout = 'Portrait'.obs;
  final RxBool isColor = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Get invoice data from arguments
    final args = Get.arguments as Map<String, dynamic>;
    invoiceData.value = args;
  }

  void updatePrinterSize(String size) {
    printerSize.value = size;
  }

  void updateCopies(int value) {
    copies.value = value;
  }

  void updateLayout(String value) {
    layout.value = value;
  }

  void toggleColor() {
    isColor.value = !isColor.value;
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
}
