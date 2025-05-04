import 'package:get/get.dart';
import '../bindings/home_binding.dart';
import '../bindings/sales_partner_binding.dart';
import '../bindings/invoice_binding.dart';
import '../bindings/print_invoice_binding.dart';
import '../bindings/login_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/sales_partner/views/sales_partner_view.dart';
import '../modules/invoice/views/invoice_view.dart';
import '../modules/print_invoice/views/print_invoice_view.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/supplier/views/supplier_view.dart';
import '../modules/supplier/bindings/supplier_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
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
    GetPage(
      name: Routes.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.SUPPLIER,
      page: () => const SupplierView(),
      binding: SupplierBinding(),
    ),
  ];
}
