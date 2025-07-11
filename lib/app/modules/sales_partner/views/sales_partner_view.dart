import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../controllers/sales_partner_controller.dart';

class SalesPartnerView extends GetView<SalesPartnerController> {
  const SalesPartnerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Penjualan & Mitra'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Get.toNamed('/home'); // Navigate back to the home page
          },
          // Get.toNamed('/home'); // Navigate back to the home page
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: controller.searchPartners,
              decoration: InputDecoration(
                hintText: 'Cari',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: controller.partners.length,
                itemBuilder: (context, index) {
                  final partner = controller.partners[index];
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Text(
                          (index + 1).toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(
                        partner.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(partner.address ?? ''),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.receipt, color: Colors.grey),
                            onPressed: () => controller.navigateToInvoice(
                              partner.id,
                              partner.name,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _showEditDialog(context, partner),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () =>
                                _showDeleteConfirmation(context, partner),
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
        onPressed: () => _showAddDialog(context),
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showEditDialog(BuildContext context, PartnerModel partner) {
    final nameController = TextEditingController(text: partner.name);
    final addressController = TextEditingController(text: partner.address);
    final phoneController = TextEditingController(text: partner.phone);
    final emailController = TextEditingController(text: partner.email);

    Get.dialog(
      AlertDialog(
        title: const Text('Edit Mitra'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nama'),
              ),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(labelText: 'Alamat'),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Telepon'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
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
              final updatedPartner = PartnerModel(
                id: partner.id,
                name: nameController.text,
                address: addressController.text,
                phone: phoneController.text,
                email: emailController.text,
              );
              controller.updatePartner(updatedPartner);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, PartnerModel partner) {
    Get.dialog(
      AlertDialog(
        title: const Text('Hapus Mitra'),
        content: Text('Apakah Anda yakin ingin menghapus ${partner.name}?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              controller.deletePartner(partner.id);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final nameController = TextEditingController();
    final addressController = TextEditingController();
    final phoneController = TextEditingController();
    final emailController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text('Tambah Mitra'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nama'),
              ),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(labelText: 'Alamat'),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Telepon'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
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
            onPressed: () async {
              final supabase = Supabase.instance.client;
              final nama = nameController.text;
              final alamat = addressController.text;
              final telepon = phoneController.text;
              final email = emailController.text;

              if (nama.isEmpty ||
                  alamat.isEmpty ||
                  telepon.isEmpty ||
                  email.isEmpty) {
                Get.snackbar(
                  'Error',
                  'Semua field harus diisi',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
                return;
              }

              final response = await supabase.from('mitra').insert({
                'nama_mtr': nama,
                'alamat_mtr': alamat,
                'telepon_mtr': telepon,
                'email_mtr': email,
              }).execute();

              if (response.error != null) {
                // Cek error unique constraint
                if (response.error!.message.contains('duplicate key value') ||
                    response.error!.message.contains('unique constraint')) {
                  Get.snackbar(
                    'Gagal',
                    'Nama, email, atau telepon sudah terdaftar!',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                } else {
                  Get.snackbar(
                    'Gagal',
                    response.error!.message,
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              } else {
                Get.back(); // Tutup dialog
                Get.snackbar(
                  'Sukses',
                  'Mitra berhasil ditambahkan',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
                controller.fetchPartners();
              }
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }
}
