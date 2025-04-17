import 'package:get/get.dart';
import '../controllers/print_invoice_controller.dart';

class PrintInvoiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrintInvoiceController>(() => PrintInvoiceController());
  }
}
