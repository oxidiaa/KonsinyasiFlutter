import 'package:get/get.dart';
import '../controllers/sales_partner_controller.dart';
import '../data/providers/api_provider.dart';

class SalesPartnerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiProvider>(() => ApiProvider());
    Get.lazyPut<SalesPartnerController>(() => SalesPartnerController());
  }
}
