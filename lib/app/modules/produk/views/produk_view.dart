import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/produk_controller.dart';

class ProdukView extends GetView<ProdukController> {
  const ProdukView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Produk'),
        centerTitle: true,
      ),
      body: Obx(() {
        final produkBySupplier = controller.produkBySupplier;
        return ListView(
          padding: const EdgeInsets.all(16),
          children: produkBySupplier.entries.map((entry) {
            final suplierName = entry.key;
            final produkList = entry.value;
            return Card(
              margin: const EdgeInsets.only(bottom: 20),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            suplierName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.add, size: 18),
                          label: const Text('Tambah Produk'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            textStyle: const TextStyle(fontSize: 13),
                          ),
                          onPressed: () {
                            controller.showAddProdukDialog(
                              context,
                              suplierName,
                              onSuccess: () {
                                controller.fetchProdukFromDb();
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    const Divider(),
                    ...produkList.map((produk) => Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                produk['nama_prdk'] ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Harga Modal: Rp${produk['harga_modal'].toStringAsFixed(2)}',
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Harga Jual: Rp${produk['harga_jual'].toStringAsFixed(2)}',
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Stok: ${produk['jumlah_stok']}',
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Barang Masuk: ${produk['jumlah_barangmasuk']}',
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Status: ${produk['status']}',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: produk['status'] == 'aktif'
                                      ? Colors.green
                                      : Colors.red,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if ((produk['deskripsi'] ?? '')
                                  .toString()
                                  .isNotEmpty)
                                Text(
                                  'Deskripsi: ${produk['deskripsi']}',
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.black54),
                                ),
                              const SizedBox(height: 2),
                              Text(
                                'Created: ${produk['created_at']}',
                                style: const TextStyle(
                                    fontSize: 11, color: Colors.grey),
                              ),
                              Text(
                                'Updated: ${produk['updated_at']}',
                                style: const TextStyle(
                                    fontSize: 11, color: Colors.grey),
                              ),
                              const Divider(),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      }),
    );
  }
}
