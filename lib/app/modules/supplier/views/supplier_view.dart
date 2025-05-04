import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: controller.searchSuppliers,
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
              return ListView.builder(
                itemCount: controller.suppliers.length,
                itemBuilder: (context, index) {
                  final supplier = controller.suppliers[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey[300]!),
                      ),
                    ),
                    child: ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      title: Row(
                        children: [
                          // No
                          SizedBox(
                            width: 50,
                            child: Text('${index + 1}.'),
                          ),
                          // Supplier Name
                          Expanded(
                            flex: 2,
                            child: Text(supplier['name']),
                          ),
                          // Product Button
                          Expanded(
                            child: IconButton(
                              icon: const Icon(Icons.description,
                                  color: Colors.green),
                              onPressed: () => controller.showProductList(
                                  supplier['id'], supplier['name']),
                            ),
                          ),
                          // Action Buttons
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.green),
                            onPressed: () =>
                                controller.editSupplier(supplier['id']),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.green),
                            onPressed: () =>
                                controller.deleteSupplier(supplier['id']),
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
        onPressed: controller.addSupplier,
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
