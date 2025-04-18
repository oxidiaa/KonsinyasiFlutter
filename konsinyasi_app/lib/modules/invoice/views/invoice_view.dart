import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/controllers/invoice_controller.dart';
import 'package:intl/intl.dart';

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
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Status Pembayaran:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'Lunas',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                // Dropdown untuk filter bulan
                DropdownButton<String>(
                  value: controller.selectedMonth.value.isEmpty
                      ? null
                      : controller.selectedMonth.value,
                  hint: const Text('Pilih Bulan'),
                  items: [
                    'Januari',
                    'Februari',
                    'Maret',
                    'April',
                    'Mei',
                    'Juni',
                    'Juli',
                    'Agustus',
                    'September',
                    'Oktober',
                    'November',
                    'Desember'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      controller.filterByMonth(newValue);
                    }
                  },
                ),
              ],
            ),
          ),

          // Tanggal Konsinyasi
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Text(
                  'Tanggal Konsinyasi:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                Obx(() {
                  if (controller.invoices.isEmpty) return const Text('-');
                  return Text(
                    DateFormat('dd MMMM yyyy')
                        .format(controller.invoices.first.date),
                  );
                }),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Tabel Produk
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.invoices.isEmpty) {
                return const Center(child: Text('Tidak ada data'));
              }

              final products = controller.invoices.first.products;

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('No')),
                      DataColumn(label: Text('Nama Produk')),
                      DataColumn(label: Text('Jumlah Awal')),
                      DataColumn(label: Text('Jumlah Baru')),
                      DataColumn(label: Text('Total Stok')),
                    ],
                    rows: List<DataRow>.generate(
                      products.length,
                      (index) => DataRow(
                        cells: [
                          DataCell(Text('${index + 1}')),
                          DataCell(Text(products[index].name)),
                          DataCell(
                              Text(products[index].initialQuantity.toString())),
                          DataCell(
                              Text(products[index].newQuantity.toString())),
                          DataCell(Text(products[index].totalStock.toString())),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: controller.navigateToPrintInvoice,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text(
            'Cetak Invoice',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
