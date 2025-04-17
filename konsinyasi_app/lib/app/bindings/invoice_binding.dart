import 'package:get/get.dart';
import '../controllers/invoice_controller.dart';
import '../data/providers/api_provider.dart';

class InvoiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiProvider>(() => ApiProvider());
    Get.lazyPut<InvoiceController>(() => InvoiceController());
  }
}
