import 'package:get/get.dart';
import '../data/models/product_model.dart';

class PrintInvoiceController extends GetxController {
  final RxString partnerName = ''.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;
  final RxString printerSize = 'EPSON TM-T82'.obs;
  final RxString destination = 'Local Printer'.obs;
  final RxString pages = 'All'.obs;
  final RxInt copies = 1.obs;
  final RxString layout = 'Portrait'.obs;
  final RxString color = 'Color'.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>;
    partnerName.value = args['partnerName'];
    products.value = args['products'];
  }

  void setPrinterSize(String size) {
    printerSize.value = size;
  }

  void setDestination(String dest) {
    destination.value = dest;
  }

  void setPages(String page) {
    pages.value = page;
  }

  void setCopies(int copy) {
    copies.value = copy;
  }

  void setLayout(String lay) {
    layout.value = lay;
  }

  void setColor(String col) {
    color.value = col;
  }

  void printInvoice() {
    // TODO: Implement actual printing logic
    Get.snackbar(
      'Success',
      'Invoice printed successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
    Get.back();
  }
}
