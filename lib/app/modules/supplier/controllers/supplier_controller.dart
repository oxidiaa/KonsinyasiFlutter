import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../data/providers/supabase_provider.dart';

class ProductModel {
  final String id;
  final String name;
  final int initialQuantity;
  final int newQuantity;
  final int totalStock;
  final double price;

  ProductModel({
    required this.id,
    required this.name,
    required this.initialQuantity,
    required this.newQuantity,
    required this.totalStock,
    required this.price,
  });
}

class SupplierController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<Map<String, dynamic>> suppliers = <Map<String, dynamic>>[].obs;
  final RxMap<String, List<ProductModel>> supplierProducts =
      <String, List<ProductModel>>{}.obs;
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  final List<Map<String, dynamic>> _allSuppliers = [];

  final SuplierProvider suplierProvider = SuplierProvider();

  @override
  void onInit() {
    super.onInit();
    fetchSuppliers();
    searchController.addListener(() {
      searchQuery.value = searchController.text;
      filterSuppliers();
    });
  }

  Future<void> fetchSuppliers() async {
    try {
      isLoading.value = true;
      final data = await suplierProvider.fetchSuplier();
      _allSuppliers.clear();
      _allSuppliers.addAll(data);
      suppliers.value = List.from(_allSuppliers);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load suppliers',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void filterSuppliers() {
    if (searchQuery.value.isEmpty) {
      suppliers.value = List.from(_allSuppliers);
      return;
    }
    final query = searchQuery.value.toLowerCase();
    suppliers.value = _allSuppliers.where((supplier) {
      final name = supplier['name'].toString().toLowerCase();
      return name.contains(query);
    }).toList();
  }

  void addSupplierDialog(BuildContext context) {
    // Implementasi dialog tambah supplier sudah ada di supplier_view.dart
    // Fungsi ini bisa dipanggil dari view jika ingin trigger dari controller
  }

  void editSupplier(dynamic supplierId) {
    final idx = suppliers
        .indexWhere((s) => s['id'].toString() == supplierId.toString());
    if (idx == -1) return;
    final supplier = suppliers[idx];
    // Samakan field dengan addSupplierToDb dan database
    final namaController =
        TextEditingController(text: supplier['nama_spr'] ?? '');
    final alamatController =
        TextEditingController(text: supplier['alamat_spr'] ?? '');
    final teleponController =
        TextEditingController(text: supplier['telepon_spr'] ?? '');
    final emailController =
        TextEditingController(text: supplier['email_spr'] ?? '');
    final npwpController = TextEditingController(text: supplier['npwp'] ?? '');
    final jenisProdukController =
        TextEditingController(text: supplier['jenis_produk'] ?? '');
    final statusController =
        TextEditingController(text: supplier['status'] ?? '');
    final tanggalBergabungController =
        TextEditingController(text: supplier['tanggal_bergabung'] ?? '');
    final bankController = TextEditingController(text: supplier['bank'] ?? '');
    final noRekeningController =
        TextEditingController(text: supplier['no_rekening'] ?? '');
    final catatanController =
        TextEditingController(text: supplier['catatan'] ?? '');

    void showDeleteConfirmation() {
      Get.dialog(
        AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Yakin Ingin Menghapusnya?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await deleteSupplier(supplierId);
                      Get.back(); // close confirm
                      Get.back(); // close edit
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Ya'),
                  ),
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text('Tidak'),
                  ),
                ],
              ),
            ],
          ),
        ),
        barrierDismissible: false,
      );
    }

    Get.dialog(StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Edit Data Suplier'),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Get.back(),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: namaController,
                decoration: const InputDecoration(labelText: 'Nama Supplier'),
              ),
              TextField(
                controller: alamatController,
                decoration: const InputDecoration(labelText: 'Alamat'),
              ),
              TextField(
                controller: teleponController,
                decoration: const InputDecoration(labelText: 'Telepon'),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: npwpController,
                decoration: const InputDecoration(labelText: 'NPWP'),
              ),
              TextField(
                controller: jenisProdukController,
                decoration: const InputDecoration(labelText: 'Jenis Produk'),
              ),
              TextField(
                controller: statusController,
                decoration: const InputDecoration(labelText: 'Status'),
              ),
              TextField(
                controller: tanggalBergabungController,
                decoration:
                    const InputDecoration(labelText: 'Tanggal Bergabung'),
              ),
              TextField(
                controller: bankController,
                decoration: const InputDecoration(labelText: 'Bank'),
              ),
              TextField(
                controller: noRekeningController,
                decoration: const InputDecoration(labelText: 'No Rekening'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: catatanController,
                decoration: const InputDecoration(labelText: 'Catatan'),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: showDeleteConfirmation,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Hapus'),
          ),
          TextButton(
            onPressed: () => Get.back(),
            style: TextButton.styleFrom(
              foregroundColor: Colors.yellow[800],
              backgroundColor: Colors.yellow[100],
            ),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              // Validasi
              if (namaController.text.isEmpty ||
                  alamatController.text.isEmpty ||
                  teleponController.text.isEmpty ||
                  emailController.text.isEmpty ||
                  jenisProdukController.text.isEmpty ||
                  statusController.text.isEmpty) {
                Get.snackbar(
                  'Peringatan',
                  'Field wajib tidak boleh kosong!',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
                return;
              }
              try {
                final supabase = Supabase.instance.client;
                final response = await supabase
                    .from('suplier')
                    .update({
                      'nama_spr': namaController.text,
                      'alamat_spr': alamatController.text,
                      'telepon_spr': teleponController.text,
                      'email_spr': emailController.text,
                      'npwp': npwpController.text,
                      'jenis_produk': jenisProdukController.text,
                      'status': statusController.text,
                      'tanggal_bergabung': tanggalBergabungController.text,
                      'bank': bankController.text,
                      'no_rekening': noRekeningController.text,
                      'catatan': catatanController.text,
                    })
                    .eq('id', supplierId)
                    .execute();
                if (response.error != null) {
                  Get.snackbar(
                    'Error',
                    response.error!.message,
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                } else {
                  Get.back();
                  Get.snackbar(
                    'Sukses',
                    'Suplier berhasil diupdate',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                  await fetchSuppliers();
                }
              } catch (e) {
                Get.snackbar(
                  'Error',
                  e.toString(),
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Simpan'),
          ),
        ],
      ),
    ));
  }

  Future<void> addSupplierToDb({
    required String nama,
    required String alamat,
    required String telepon,
    required String email,
    String? npwp,
    required String jenisProduk,
    String status = 'aktif',
    String? tanggalBergabung,
    String? bank,
    String? noRekening,
    String? catatan,
  }) async {
    try {
      await suplierProvider.insertSuplier(
        nama: nama,
        alamat: alamat,
        telepon: telepon,
        email: email,
        npwp: npwp,
        jenisProduk: jenisProduk,
        status: status,
        tanggalBergabung: tanggalBergabung,
        bank: bank,
        noRekening: noRekening,
        catatan: catatan,
      );
      await fetchSuppliers();
      Get.snackbar(
        'Sukses',
        'Suplier berhasil ditambahkan',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
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

  Future<void> updateSupplierInDb({
    required int id,
    required String nama,
    required String alamat,
    required String telepon,
    required String email,
    String? npwp,
    required String jenisProduk,
    String status = 'aktif',
    String? tanggalBergabung,
    String? bank,
    String? noRekening,
    String? catatan,
  }) async {
    try {
      await suplierProvider.updateSuplier(
        id: id,
        nama: nama,
        alamat: alamat,
        telepon: telepon,
        email: email,
        npwp: npwp,
        jenisProduk: jenisProduk,
        status: status,
        tanggalBergabung: tanggalBergabung,
        bank: bank,
        noRekening: noRekening,
        catatan: catatan,
      );
      await fetchSuppliers();
      Get.snackbar(
        'Sukses',
        'Suplier berhasil diupdate',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
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

  Future<void> deleteSupplier(dynamic supplierId) async {
    try {
      await suplierProvider.deleteSuplier(supplierId);
      await fetchSuppliers();
      Get.snackbar(
        'Success',
        'Supplier deleted successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
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

  void showProductList(String supplierId, String supplierName) {
    Get.dialog(
      Dialog(
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: ProdukAljaziraProvider().fetchAllProduk(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              );
            }
            final produkList = snapshot.data ?? [];
            return Container(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          supplierName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Get.back(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Product',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        ElevatedButton(
                          onPressed: () => addProductToDbDialog(supplierId),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                          ),
                          child: const Text('Tambah Barang'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      color: Colors.grey[200],
                      height: 2,
                    ),
                    const SizedBox(height: 8),
                    if (produkList.isEmpty)
                      const Text('Belum ada produk pada database.')
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: produkList.length,
                        itemBuilder: (context, index) {
                          final produk = produkList[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            elevation: 2,
                            child: ListTile(
                              leading: produk['gambar_produk'] != null &&
                                      produk['gambar_produk']
                                          .toString()
                                          .isNotEmpty
                                  ? Image.network(
                                      produk['gambar_produk'],
                                      width: 48,
                                      height: 48,
                                      fit: BoxFit.cover,
                                      errorBuilder: (c, e, s) =>
                                          const Icon(Icons.image_not_supported),
                                    )
                                  : const Icon(Icons.inventory_2,
                                      size: 40, color: Colors.green),
                              title: Text(produk['nama_produk'] ?? ''),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Kode: ${produk['kode_produk'] ?? ''}'),
                                  Text(
                                      'Harga Beli: Rp${produk['harga_beli'] ?? 0}'),
                                  Text(
                                      'Harga Jual: Rp${produk['harga_jual'] ?? 0}'),
                                  Text(
                                      'Stok: ${produk['stok'] ?? 0} ${produk['satuan'] ?? ''}'),
                                  if (produk['tanggal_kadaluarsa'] != null)
                                    Text(
                                        'Kadaluarsa: ${produk['tanggal_kadaluarsa']}'),
                                  Text('Status: ${produk['status'] ?? ''}'),
                                ],
                              ),
                              trailing: Icon(
                                produk['status'] == 'aktif'
                                    ? Icons.check_circle
                                    : Icons.cancel,
                                color: produk['status'] == 'aktif'
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void showProductDetailDialog(ProductModel product) {
    Get.dialog(
      AlertDialog(
        title: Text(product.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Harga: Rp${product.price.toStringAsFixed(0)}'),
            Text('Stok Awal: ${product.initialQuantity}'),
            Text('Stok Baru: ${product.newQuantity}'),
            Text('Total Stok: ${product.totalStock}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Tutup'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              editProduct(
                  'dummy', product.id); // Dummy, ganti supplierId jika perlu
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Edit'),
          ),
        ],
      ),
    );
  }

  void addProduct(String supplierId) {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final initialQtyController = TextEditingController();
    final newQtyController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text('Tambah Produk'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nama Produk'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Harga'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: initialQtyController,
                decoration: const InputDecoration(labelText: 'Stok Awal'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: newQtyController,
                decoration: const InputDecoration(labelText: 'Stok Baru'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              final name = nameController.text.trim();
              final price = double.tryParse(priceController.text) ?? 0;
              final initialQty = int.tryParse(initialQtyController.text) ?? 0;
              final newQty = int.tryParse(newQtyController.text) ?? 0;
              if (name.isEmpty || price == 0) return;
              final newProduct = ProductModel(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                name: name,
                price: price,
                initialQuantity: initialQty,
                newQuantity: newQty,
                totalStock: initialQty + newQty,
              );
              supplierProducts[supplierId] = [
                ...?supplierProducts[supplierId],
                newProduct,
              ];
              Get.back();
              // Refresh dialog
              showProductList(supplierId,
                  suppliers.firstWhere((s) => s['id'] == supplierId)['name']);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void editProduct(String supplierId, String productId) {
    final product =
        supplierProducts[supplierId]?.firstWhere((p) => p.id == productId);
    if (product == null) return;
    final nameController = TextEditingController(text: product.name);
    final priceController =
        TextEditingController(text: product.price.toStringAsFixed(0));
    final initialQtyController =
        TextEditingController(text: product.initialQuantity.toString());
    final newQtyController =
        TextEditingController(text: product.newQuantity.toString());

    Get.dialog(
      AlertDialog(
        title: const Text('Edit Produk'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nama Produk'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Harga'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: initialQtyController,
                decoration: const InputDecoration(labelText: 'Stok Awal'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: newQtyController,
                decoration: const InputDecoration(labelText: 'Stok Baru'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              final name = nameController.text.trim();
              final price = double.tryParse(priceController.text) ?? 0;
              final initialQty = int.tryParse(initialQtyController.text) ?? 0;
              final newQty = int.tryParse(newQtyController.text) ?? 0;
              if (name.isEmpty || price == 0) return;
              final idx = supplierProducts[supplierId]
                      ?.indexWhere((p) => p.id == productId) ??
                  -1;
              if (idx != -1) {
                supplierProducts[supplierId]![idx] = ProductModel(
                  id: productId,
                  name: name,
                  price: price,
                  initialQuantity: initialQty,
                  newQuantity: newQty,
                  totalStock: initialQty + newQty,
                );
              }
              Get.back();
              // Refresh dialog
              showProductList(supplierId,
                  suppliers.firstWhere((s) => s['id'] == supplierId)['name']);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void deleteProduct(String supplierId, String productId) {
    Get.dialog(
      AlertDialog(
        title: const Text('Hapus Produk'),
        content: const Text('Yakin ingin menghapus produk ini?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              supplierProducts[supplierId]
                  ?.removeWhere((p) => p.id == productId);
              Get.back();
              // Refresh dialog
              showProductList(supplierId,
                  suppliers.firstWhere((s) => s['id'] == supplierId)['name']);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  void addProductToDbDialog(String supplierId) {
    final formKey = GlobalKey<FormState>();
    final kodeProdukController = TextEditingController();
    final namaProdukController = TextEditingController();
    final deskripsiController = TextEditingController();
    final hargaBeliController = TextEditingController();
    final hargaJualController = TextEditingController();
    final stokController = TextEditingController();
    final satuanController = TextEditingController();
    final tanggalKadaluarsaController = TextEditingController();
    final gambarProdukController = TextEditingController();
    final statusController = TextEditingController(text: 'aktif');

    Get.dialog(
      AlertDialog(
        title: const Text('Tambah Produk Suplier'),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: kodeProdukController,
                  decoration: const InputDecoration(labelText: 'Kode Produk'),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Wajib diisi' : null,
                ),
                TextFormField(
                  controller: namaProdukController,
                  decoration: const InputDecoration(labelText: 'Nama Produk'),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Wajib diisi' : null,
                ),
                TextFormField(
                  controller: deskripsiController,
                  decoration: const InputDecoration(labelText: 'Deskripsi'),
                  maxLines: 2,
                ),
                TextFormField(
                  controller: hargaBeliController,
                  decoration: const InputDecoration(labelText: 'Harga Beli'),
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
                  controller: stokController,
                  decoration: const InputDecoration(labelText: 'Stok'),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: satuanController,
                  decoration: const InputDecoration(labelText: 'Satuan'),
                ),
                TextFormField(
                  controller: tanggalKadaluarsaController,
                  decoration: const InputDecoration(
                      labelText: 'Tanggal Kadaluarsa (YYYY-MM-DD)'),
                  keyboardType: TextInputType.datetime,
                ),
                TextFormField(
                  controller: gambarProdukController,
                  decoration:
                      const InputDecoration(labelText: 'URL Gambar Produk'),
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
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                try {
                  await ProdukAljaziraProvider().insertProdukAljazira(
                    kodeProduk: kodeProdukController.text,
                    namaProduk: namaProdukController.text,
                    idSpr: int.tryParse(supplierId),
                    deskripsi: deskripsiController.text,
                    hargaBeli: double.tryParse(hargaBeliController.text) ?? 0,
                    hargaJual: double.tryParse(hargaJualController.text) ?? 0,
                    stok: int.tryParse(stokController.text) ?? 0,
                    satuan: satuanController.text,
                    tanggalKadaluarsa: tanggalKadaluarsaController.text,
                    gambarProduk: gambarProdukController.text,
                    status: statusController.text,
                  );
                  Get.back();
                  Get.snackbar(
                    'Sukses',
                    'Produk berhasil ditambahkan',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
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

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
