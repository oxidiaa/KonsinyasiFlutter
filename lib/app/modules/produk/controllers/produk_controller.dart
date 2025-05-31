import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../data/providers/supabase_provider.dart';

class ProdukController extends GetxController {
  final produkProvider = ProdukProvider();

  // Dummy data, ganti dengan fetch dari database jika sudah ada
  final RxList<Map<String, dynamic>> produkList = <Map<String, dynamic>>[
    {
      'id_prdk': 1,
      'nama_prdk': 'Produk A',
      'harga_modal': 10000.00,
      'harga_jual': 15000.00,
      'jumlah_stok': 20,
      'jumlah_barangmasuk': 5.0,
      'status': 'aktif',
      'deskripsi': 'Deskripsi produk A',
      'created_at': DateTime.now(),
      'updated_at': DateTime.now(),
      'suplier': 'Suplier A',
    },
    {
      'id_prdk': 2,
      'nama_prdk': 'Produk B',
      'harga_modal': 20000.00,
      'harga_jual': 25000.00,
      'jumlah_stok': 10,
      'jumlah_barangmasuk': 2.0,
      'status': 'non-aktif',
      'deskripsi': 'Deskripsi produk B',
      'created_at': DateTime.now(),
      'updated_at': DateTime.now(),
      'suplier': 'Suplier B',
    },
  ].obs;

  Map<String, List<Map<String, dynamic>>> get produkBySupplier {
    final Map<String, List<Map<String, dynamic>>> grouped = {};
    for (var produk in produkList) {
      final suplier = produk['suplier'] ?? 'Tanpa Suplier';
      grouped.putIfAbsent(suplier, () => []).add(produk);
    }
    return grouped;
  }

  void showAddProdukDialog(BuildContext context, String suplierName,
      {VoidCallback? onSuccess}) {
    final formKey = GlobalKey<FormState>();
    final namaController = TextEditingController();
    final hargaModalController = TextEditingController();
    final hargaJualController = TextEditingController();
    final jumlahStokController = TextEditingController();
    final jumlahBarangMasukController = TextEditingController();
    final statusController = TextEditingController(text: 'aktif');
    final deskripsiController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Produk'),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: namaController,
                  decoration: const InputDecoration(labelText: 'Nama Produk'),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Wajib diisi' : null,
                ),
                TextFormField(
                  controller: hargaModalController,
                  decoration: const InputDecoration(labelText: 'Harga Modal'),
                  keyboardType: TextInputType.number,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Wajib diisi' : null,
                ),
                TextFormField(
                  controller: hargaJualController,
                  decoration: const InputDecoration(labelText: 'Harga Jual'),
                  keyboardType: TextInputType.number,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Wajib diisi' : null,
                ),
                TextFormField(
                  controller: jumlahStokController,
                  decoration: const InputDecoration(labelText: 'Jumlah Stok'),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: jumlahBarangMasukController,
                  decoration:
                      const InputDecoration(labelText: 'Jumlah Barang Masuk'),
                  keyboardType: TextInputType.number,
                ),
                DropdownButtonFormField<String>(
                  value: statusController.text,
                  decoration: const InputDecoration(labelText: 'Status'),
                  items: const [
                    DropdownMenuItem(value: 'aktif', child: Text('Aktif')),
                    DropdownMenuItem(
                        value: 'non-aktif', child: Text('Non-Aktif')),
                  ],
                  onChanged: (val) {
                    statusController.text = val ?? 'aktif';
                  },
                ),
                TextFormField(
                  controller: deskripsiController,
                  decoration: const InputDecoration(labelText: 'Deskripsi'),
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                try {
                  await produkProvider.insertProduk(
                    nama: namaController.text,
                    hargaModal: double.tryParse(hargaModalController.text) ?? 0,
                    hargaJual: double.tryParse(hargaJualController.text) ?? 0,
                    jumlahStok: int.tryParse(jumlahStokController.text) ?? 0,
                    jumlahBarangMasuk:
                        double.tryParse(jumlahBarangMasukController.text),
                    status: statusController.text,
                    deskripsi: deskripsiController.text,
                  );
                  Navigator.pop(context);
                  Get.snackbar(
                    'Sukses',
                    'Produk berhasil ditambahkan',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                  await fetchProdukFromDb();
                  if (onSuccess != null) onSuccess();
                } catch (e) {
                  Get.snackbar(
                    'Error',
                    e.toString(),
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  Future<void> fetchProdukFromDb() async {
    final data = await produkProvider.fetchProduk();
    produkList.assignAll(data);
  }
}
