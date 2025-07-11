import 'package:get/get.dart';

import '../../splash_screen.dart';
import '../modules/bill_pembelian/bindings/bill_pembelian_binding.dart';
import '../modules/bill_pembelian/views/bill_pembelian_view.dart';
import '../modules/billing/bindings/billing_binding.dart';
import '../modules/billing/views/billing_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/invoice/bindings/invoice_binding.dart';
import '../modules/invoice/views/invoice_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/notification_reminder/bindings/notification_reminder_binding.dart';
import '../modules/notification_reminder/bindings/notification_reminder_binding.dart';
import '../modules/notification_reminder/views/notification_reminder_view.dart';
import '../modules/notification_reminder/views/notification_reminder_view.dart';
import '../modules/print_invoice/bindings/print_invoice_binding.dart';
import '../modules/print_invoice/views/print_invoice_view.dart';
import '../modules/produk/bindings/produk_binding.dart';
import '../modules/produk/views/produk_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/account_privacy_view.dart';
import '../modules/profile/views/notifications_view.dart';
import '../modules/profile/views/personal_details_view.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/sales_partner/bindings/sales_partner_binding.dart';
import '../modules/sales_partner/views/sales_partner_view.dart';
import '../modules/supplier/bindings/supplier_binding.dart';
import '../modules/supplier/views/supplier_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashScreen(),
    ),
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
    GetPage(
      name: Routes.NOTIFICATION_REMINDER,
      page: () => const NotificationReminderView(),
      binding: NotificationReminderBinding(),
    ),
    GetPage(
      name: Routes.BILLING,
      page: () => BillingView(),
      binding: BillingBinding(),
    ),
    GetPage(
      name: Routes.BILL_PEMBELIAN,
      page: () => BillPembelianView(),
      binding: BillPembelianBinding(),
    ),
    // Uncomment or add additional routes as needed
    // GetPage(
    //   name: '/personal-details',
    //   page: () => const PersonalDetailsView(),
    // ),
    // GetPage(
    //   name: '/account-privacy',
    //   page: () => const AccountPrivacyView(),
    // ),
    // GetPage(
    //   name: '/notifications',
    //   page: () => const NotificationsView(),
    // ),
    GetPage(
      name: Routes.PRODUK,
      page: () => const ProdukView(),
      binding: ProdukBinding(),
    ),
  ];
}
