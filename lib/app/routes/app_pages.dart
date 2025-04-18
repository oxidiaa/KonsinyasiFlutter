import 'package:get/get.dart';
import '../bindings/home_binding.dart';
import '../bindings/sales_partner_binding.dart';
import '../bindings/invoice_binding.dart';
import '../bindings/print_invoice_binding.dart';
import '../../modules/home/views/home_view.dart';
import '../../modules/sales_partner/views/sales_partner_view.dart';
import '../../modules/invoice/views/invoice_view.dart';
import '../../modules/print_invoice/views/print_invoice_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.SALES_PARTNER,
      page: () => const SalesPartnerView(),
      binding: SalesPartnerBinding(),
    ),
    GetPage(
      name: Routes.INVOICE,
      page: () => const InvoiceView(),
      binding: InvoiceBinding(),
    ),
    GetPage(
      name: Routes.PRINT_INVOICE,
      page: () => const PrintInvoiceView(),
      binding: PrintInvoiceBinding(),
    ),
  ];
}
