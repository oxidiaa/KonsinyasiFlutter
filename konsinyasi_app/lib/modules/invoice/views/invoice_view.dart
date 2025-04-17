import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../themes/app_theme.dart';
import '../../../app/controllers/invoice_controller.dart';

class InvoiceView extends GetView<InvoiceController> {
  const InvoiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Faktur',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => Text(
                          controller.partnerName.value,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Terbayar Penuh',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Konsinyasi: ${DateTime.now().day} Februari 2024',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
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
                    DataColumn(label: Text('Nama Product')),
                    DataColumn(label: Text('K.Awal')),
                    DataColumn(label: Text('K.Baru')),
                    DataColumn(label: Text('T.Stok')),
                  ],
                  rows: controller.products.map((product) {
                    return DataRow(
                      cells: [
                        DataCell(Text(product.id.toString())),
                        DataCell(Text(product.name)),
                        DataCell(Text(product.stock.toString())),
                        DataCell(
                          product.sold > 0
                              ? Text(product.sold.toString())
                              : const Text('-'),
                        ),
                        DataCell(Text(product.stock.toString())),
                      ],
                    );
                  }).toList(),
                ),
              );
            }),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: controller.navigateToPrintInvoice,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('Print Faktur'),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () => controller.selectMonth('JANUARI'),
                      child: Obx(() => Text(
                            'JANUARI',
                            style: TextStyle(
                              color: controller.selectedMonth.value == 'JANUARI'
                                  ? AppTheme.primaryColor
                                  : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ),
                    TextButton(
                      onPressed: () => controller.selectMonth('FEBRUARI'),
                      child: Obx(() => Text(
                            'FEBRUARI',
                            style: TextStyle(
                              color:
                                  controller.selectedMonth.value == 'FEBRUARI'
                                      ? AppTheme.primaryColor
                                      : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ),
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          '2',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
