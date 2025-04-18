import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/controllers/invoice_controller.dart';

class InvoiceView extends GetView<InvoiceController> {
  const InvoiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.partnerName.value)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Consignment Date:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  DateTime.now().toString().split(' ')[0],
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('No')),
                    DataColumn(label: Text('Product Name')),
                    DataColumn(label: Text('Initial Quantity')),
                    DataColumn(label: Text('New Quantity')),
                    DataColumn(label: Text('Total Stock')),
                  ],
                  rows: controller.products.asMap().entries.map((entry) {
                    final index = entry.key;
                    final product = entry.value;
                    return DataRow(
                      cells: [
                        DataCell(Text('${index + 1}')),
                        DataCell(Text(product.name)),
                        DataCell(Text(product.initialQuantity.toString())),
                        DataCell(Text(product.newQuantity.toString())),
                        DataCell(Text(
                            (product.initialQuantity + product.newQuantity)
                                .toString())),
                      ],
                    );
                  }).toList(),
                ),
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: controller.selectedMonth.value.isEmpty
                      ? null
                      : controller.selectedMonth.value,
                  hint: const Text('Select Month'),
                  items: const [
                    DropdownMenuItem(
                      value: 'January',
                      child: Text('January'),
                    ),
                    DropdownMenuItem(
                      value: 'February',
                      child: Text('February'),
                    ),
                    DropdownMenuItem(
                      value: 'March',
                      child: Text('March'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      controller.selectMonth(value);
                    }
                  },
                ),
                ElevatedButton(
                  onPressed: controller.navigateToPrintInvoice,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('Print Invoice'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
