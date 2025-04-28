import 'package:get/get.dart';
import '../controllers/sales_partner_controller.dart';

class SalesPartnerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalesPartnerController>(
      () => SalesPartnerController(),
    );
  }
}
