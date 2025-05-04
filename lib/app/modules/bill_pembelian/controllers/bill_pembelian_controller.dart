import 'package:get/get.dart';

class BillModel {
  final String supplierName;
  final int amount;
  final bool isPaid;

  BillModel({
    required this.supplierName,
    required this.amount,
    this.isPaid = false,
  });
}

class BillPembelianController extends GetxController {
  var bills = <BillModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBills();
  }

  void fetchBills() {
    bills.value = [
      BillModel(supplierName: 'Suplier A', amount: 750000, isPaid: true),
      BillModel(supplierName: 'Suplier B', amount: 500000),
      BillModel(supplierName: 'Suplier C', amount: 820000),
      BillModel(supplierName: 'Suplier D', amount: 650000, isPaid: true),
      BillModel(supplierName: 'Suplier E', amount: 1000000),
      BillModel(supplierName: 'Suplier F', amount: 880000),
      BillModel(supplierName: 'Suplier G', amount: 750000),
      BillModel(supplierName: 'Suplier H', amount: 930000),
      BillModel(supplierName: 'Suplier I', amount: 510000),
      BillModel(supplierName: 'Suplier J', amount: 800000),
      BillModel(supplierName: 'Suplier K', amount: 710000),
      BillModel(supplierName: 'Suplier L', amount: 950000),
      BillModel(supplierName: 'Suplier M', amount: 725000),
      BillModel(supplierName: 'Suplier N', amount: 690000),
      BillModel(supplierName: 'Suplier O', amount: 860000),
    ];
  }

  void markAsPaid(BillModel bill) {
    final index = bills.indexOf(bill);
    if (index != -1) {
      bills[index] = BillModel(
        supplierName: bill.supplierName,
        amount: bill.amount,
        isPaid: true,
      );
    }
  }
}
