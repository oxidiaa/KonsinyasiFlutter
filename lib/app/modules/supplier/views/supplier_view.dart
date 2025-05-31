import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../controllers/supplier_controller.dart';

class SupplierView extends GetView<SupplierController> {
  const SupplierView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pembelian & Supliyer',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
            Get.toNamed('/home');
          },
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) => controller.searchQuery.value = value,
              decoration: InputDecoration(
                hintText: 'Cari',
                prefixIcon: const Icon(Icons.search, color: Colors.green),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.green[50],
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          // Supplier List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              // Tampilkan data supplier dalam bentuk Card
              return ListView.builder(
                itemCount: controller.suppliers.length,
                itemBuilder: (context, index) {
                  final supplier = controller.suppliers[index];
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Icon/avatar supplier
                          CircleAvatar(
                            backgroundColor: Colors.green[100],
                            child: Text(
                              (supplier['nama_spr'] ?? '').isNotEmpty
                                  ? supplier['nama_spr'][0].toUpperCase()
                                  : '?',
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Info utama supplier
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  supplier['nama_spr'] ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  supplier['alamat_spr'] ?? '',
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Jenis Produk: ${supplier['jenis_produk'] ?? ''}',
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Tombol aksi
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.info_outline,
                                    color: Colors.blue),
                                tooltip: 'Detail',
                                onPressed: () {
                                  // Tampilkan dialog list produk untuk supplier ini
                                  controller.showProductList(
                                    supplier['id'].toString(),
                                    supplier['nama_spr'] ?? '',
                                  );
                                },
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.edit, color: Colors.green),
                                tooltip: 'Edit',
                                onPressed: () => controller
                                    .editSupplier(supplier['id'].toString()),
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                tooltip: 'Hapus',
                                onPressed: () async {
                                  final confirm = await showDialog<bool>(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Konfirmasi'),
                                      content: const Text(
                                          'Yakin ingin menghapus supplier ini?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                          child: const Text('Batal'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(true),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red),
                                          child: const Text('Hapus'),
                                        ),
                                      ],
                                    ),
                                  );
                                  if (confirm == true) {
                                    await controller
                                        .deleteSupplier(supplier['id']);
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddSupplierDialog(context);
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddSupplierDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final addressController = TextEditingController();
    final phoneController = TextEditingController();
    final emailController = TextEditingController();
    final npwpController = TextEditingController();
    final jenisProdukController = TextEditingController();
    final statusController = TextEditingController();
    final tanggalBergabungController = TextEditingController();
    final bankController = TextEditingController();
    final noRekeningController = TextEditingController();
    final catatanController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return AlertDialog(
              title: const Text('Tambah Supplier Baru'),
              content: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.7,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: nameController,
                          decoration:
                              const InputDecoration(labelText: 'Nama Supplier'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nama supplier harus diisi';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: addressController,
                          decoration:
                              const InputDecoration(labelText: 'Alamat'),
                        ),
                        TextFormField(
                          controller: phoneController,
                          decoration:
                              const InputDecoration(labelText: 'Telepon'),
                          keyboardType: TextInputType.phone,
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        TextFormField(
                          controller: npwpController,
                          decoration: const InputDecoration(labelText: 'NPWP'),
                        ),
                        TextFormField(
                          controller: jenisProdukController,
                          decoration:
                              const InputDecoration(labelText: 'Jenis Produk'),
                        ),
                        TextFormField(
                          controller: statusController,
                          decoration:
                              const InputDecoration(labelText: 'Status'),
                        ),
                        TextFormField(
                          controller: tanggalBergabungController,
                          decoration: const InputDecoration(
                              labelText: 'Tanggal Bergabung'),
                        ),
                        TextFormField(
                          controller: bankController,
                          decoration: const InputDecoration(labelText: 'Bank'),
                        ),
                        TextFormField(
                          controller: noRekeningController,
                          decoration:
                              const InputDecoration(labelText: 'No Rekening'),
                          keyboardType: TextInputType.number,
                        ),
                        TextFormField(
                          controller: catatanController,
                          decoration:
                              const InputDecoration(labelText: 'Catatan'),
                          maxLines: 3,
                        ),
                      ],
                    ),
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
                      // Panggil method controller untuk menambah supplier ke database
                      await controller.addSupplierToDb(
                        nama: nameController.text,
                        alamat: addressController.text,
                        telepon: phoneController.text,
                        email: emailController.text,
                        npwp: npwpController.text,
                        jenisProduk: jenisProdukController.text,
                        status: statusController.text,
                        tanggalBergabung: tanggalBergabungController.text,
                        bank: bankController.text,
                        noRekening: noRekeningController.text,
                        catatan: catatanController.text,
                      );
                      Navigator.pop(context);
                    }
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text('Simpan'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
