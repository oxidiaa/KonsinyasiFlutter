import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/billing_controller.dart';
import 'package:intl/intl.dart';

class BillingView extends GetView<BillingController> {
  final currencyFormatter =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Tagihan Penjualan'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) => controller.searchQuery.value = value,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Cari',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                fillColor: Colors.green[200],
                filled: true,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Table(
              columnWidths: {
                0: FixedColumnWidth(30),
                1: FlexColumnWidth(3),
                2: FlexColumnWidth(2),
                3: FlexColumnWidth(1),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  children: [
                    Text("No", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("List Mitra",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("Tagihan",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("Action",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ]
                      .map((e) => Padding(padding: EdgeInsets.all(8), child: e))
                      .toList(),
                )
              ],
            ),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: controller.filteredBillings.length,
                  itemBuilder: (context, index) {
                    final item = controller.filteredBillings[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 4),
                      child: Table(
                        columnWidths: {
                          0: FixedColumnWidth(30),
                          1: FlexColumnWidth(3),
                          2: FlexColumnWidth(2),
                          3: FlexColumnWidth(1),
                        },
                        children: [
                          TableRow(
                            children: [
                              Text('${index + 1}.'),
                              Text(item.name),
                              Text(currencyFormatter.format(item.amount)),
                              Container(
                                alignment: Alignment.center,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: item.isPaid
                                        ? Colors.green
                                        : Colors.grey,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: Text(
                                    item.isPaid ? 'Lunas' : 'Lunas',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ]
                                .map((e) => Padding(
                                    padding: EdgeInsets.all(4), child: e))
                                .toList(),
                          )
                        ],
                      ),
                    );
                  },
                )),
          )
        ],
      ),
    );
  }
}
