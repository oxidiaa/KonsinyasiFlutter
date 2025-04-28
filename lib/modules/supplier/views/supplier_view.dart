import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/supplier_controller.dart';

class SupplierView extends GetView<SupplierController> {
  const SupplierView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembelian & Supliyer'),
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
              controller: controller.searchController,
              decoration: InputDecoration(
                hintText: 'Cari',
                prefixIcon: const Icon(Icons.search, color: Colors.green),
                filled: true,
                fillColor: Colors.green.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),

          // Table Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const SizedBox(width: 50, child: Text('No')),
                const Expanded(
                  flex: 2,
                  child: Text('List Supliyer',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const Expanded(
                  child: Text('Product',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text('Action',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Table Content
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
                              onPressed: () =>
                                  controller.viewProducts(supplier['id']),
                            ),
                          ),
                          // Action Buttons
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue),
                                  onPressed: () =>
                                      controller.editSupplier(supplier['id']),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () =>
                                      controller.deleteSupplier(supplier['id']),
                                ),
                              ],
                            ),
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
