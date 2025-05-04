import 'package:get/get.dart';
import '../controllers/bill_pembelian_controller.dart';

class BillPembelianBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BillPembelianController>(() => BillPembelianController());
  }
}
