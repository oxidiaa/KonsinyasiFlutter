import 'package:get/get.dart';
import '../data/models/product_model.dart';

class PrintInvoiceController extends GetxController {
  final RxString partnerName = ''.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;
  final RxString printerSize = 'EPSON TM-T82'.obs;
  final RxString destination = 'Current Page'.obs;
  final RxString pages = 'Current Page'.obs;
  final RxInt copies = 1.obs;
  final RxString layout = 'Portrait'.obs;
  final RxString color = 'Gray'.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>;
    partnerName.value = args['partnerName'];
    products.value = List<ProductModel>.from(args['products']);
  }

  void printInvoice() {
    // Implement print logic
    Get.snackbar(
      'Success',
      'Invoice printed successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void cancel() {
    Get.back();
  }
}
