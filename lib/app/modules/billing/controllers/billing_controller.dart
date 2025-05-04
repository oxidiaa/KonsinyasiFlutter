import 'package:get/get.dart';
// import '../models/billing_model.dart';

class BillingModel {
  final String name;
  final int amount;
  final bool isPaid;

  BillingModel(
      {required this.name, required this.amount, required this.isPaid});
}

class BillingController extends GetxController {
  var billings = <BillingModel>[].obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadBillings();
  }

  void loadBillings() {
    billings.value = [
      BillingModel(name: 'A. Afina F', amount: 530000, isPaid: true),
      BillingModel(name: 'Outlet B', amount: 200000, isPaid: false),
      BillingModel(name: 'Outlet C', amount: 320000, isPaid: false),
      BillingModel(name: 'Outlet D', amount: 250000, isPaid: false),
      BillingModel(name: 'Outlet E', amount: 400000, isPaid: true),
      BillingModel(name: 'Outlet F', amount: 380000, isPaid: false),
      BillingModel(name: 'Outlet G', amount: 550000, isPaid: false),
      BillingModel(name: 'Outlet H', amount: 330000, isPaid: false),
      BillingModel(name: 'Outlet I', amount: 210000, isPaid: false),
      BillingModel(name: 'Outlet J', amount: 500000, isPaid: true),
      BillingModel(name: 'Outlet K', amount: 410000, isPaid: false),
      BillingModel(name: 'Outlet L', amount: 150000, isPaid: true),
      BillingModel(name: 'Outlet M', amount: 425000, isPaid: false),
      BillingModel(name: 'Outlet N', amount: 290000, isPaid: false),
      BillingModel(name: 'Outlet O', amount: 460000, isPaid: false),
    ];
  }

  List<BillingModel> get filteredBillings {
    if (searchQuery.value.isEmpty) return billings;
    return billings
        .where((b) =>
            b.name.toLowerCase().contains(searchQuery.value.toLowerCase()))
        .toList();
  }
}
