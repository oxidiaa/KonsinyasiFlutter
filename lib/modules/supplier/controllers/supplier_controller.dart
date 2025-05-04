import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/data/models/product_model.dart';

class SupplierController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<Map<String, dynamic>> suppliers = <Map<String, dynamic>>[].obs;
  final RxMap<String, List<ProductModel>> supplierProducts =
      <String, List<ProductModel>>{}.obs;
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadSuppliers();
    // Dummy produk untuk setiap supplier
    supplierProducts.clear();
    for (var s in _allSuppliers) {
      supplierProducts[s['id']] = [
        ProductModel(
          id: '1',
          name: 'Madu As Salamah 8 in 1',
          initialQuantity: 10,
          newQuantity: 5,
          totalStock: 15,
          price: 50000,
        ),
        ProductModel(
          id: '2',
          name: 'Madu Batuk Mumtaza',
          initialQuantity: 8,
          newQuantity: 2,
          totalStock: 10,
          price: 30000,
        ),
      ];
    }
    searchController.addListener(() {
      searchQuery.value = searchController.text;
      filterSuppliers();
    });
  }

  // List of all suppliers (unfiltered)
  final List<Map<String, dynamic>> _allSuppliers = [
    {'id': '1', 'name': 'Al-jazira', 'products': []},
    {'id': '2', 'name': 'Supliyer B', 'products': []},
    {'id': '3', 'name': 'Supliyer C', 'products': []},
    {'id': '4', 'name': 'Supliyer D', 'products': []},
    {'id': '5', 'name': 'Supliyer E', 'products': []},
    {'id': '6', 'name': 'Supliyer F', 'products': []},
    {'id': '7', 'name': 'Supliyer G', 'products': []},
    {'id': '8', 'name': 'Supliyer H', 'products': []},
    {'id': '9', 'name': 'Supliyer I', 'products': []},
    {'id': '10', 'name': 'Supliyer J', 'products': []},
    {'id': '11', 'name': 'Supliyer K', 'products': []},
    {'id': '12', 'name': 'Supliyer L', 'products': []},
    {'id': '13', 'name': 'Supliyer M', 'products': []},
    {'id': '14', 'name': 'Supliyer N', 'products': []},
    {'id': '15', 'name': 'Supliyer O', 'products': []},
  ];

  void loadSuppliers() {
    try {
      isLoading.value = true;
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

  void viewProducts(int supplierId) {
    final supplier = _allSuppliers.firstWhere(
      (s) => s['id'] == supplierId,
      orElse: () => {},
    );

    if (supplier.isEmpty) {
      Get.snackbar(
        'Error',
        'Supplier not found',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // TODO: Navigate to supplier products page
    Get.toNamed('/supplier-products', arguments: supplier);
  }

  void addSupplier() {
    Get.dialog(
      AlertDialog(
        title: const Text('Add New Supplier'),
        content: const Text('Add supplier feature coming soon'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void editSupplier(int supplierId) {
    Get.dialog(
      AlertDialog(
        title: const Text('Edit Supplier'),
        content: const Text('Edit supplier feature coming soon'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void deleteSupplier(int supplierId) {
    Get.dialog(
      AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this supplier?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Remove from both lists
              _allSuppliers.removeWhere((s) => s['id'] == supplierId);
              suppliers.removeWhere((s) => s['id'] == supplierId);
              Get.back();
              Get.snackbar(
                'Success',
                'Supplier deleted successfully',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void searchSuppliers(String query) {
    if (query.isEmpty) {
      loadSuppliers();
      return;
    }
    final filtered = suppliers
        .where((supplier) => supplier['name']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
    suppliers.value = filtered;
  }

  void showProductList(String supplierId, String supplierName) {
    Get.dialog(
      Dialog(
        child: Container(
          padding: const EdgeInsets.all(16),
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  ElevatedButton(
                    onPressed: () => addProduct(supplierId),
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
              if (supplierProducts[supplierId] != null)
                DataTable(
                  columns: const [
                    DataColumn(label: Text('No')),
                    DataColumn(label: Text('List Product')),
                    DataColumn(label: Text('Harga')),
                    DataColumn(label: Text('Action')),
                  ],
                  rows: supplierProducts[supplierId]!
                      .asMap()
                      .entries
                      .map((entry) {
                    final product = entry.value;
                    return DataRow(
                      cells: [
                        DataCell(
                          Text('${entry.key + 1}'),
                          onTap: () => showProductDetailDialog(product),
                        ),
                        DataCell(
                          Text(product.name),
                          onTap: () => showProductDetailDialog(product),
                        ),
                        DataCell(
                          Text('Rp${product.price.toStringAsFixed(0)}'),
                          onTap: () => showProductDetailDialog(product),
                        ),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon:
                                    const Icon(Icons.edit, color: Colors.green),
                                onPressed: () =>
                                    editProduct(supplierId, product.id),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete,
                                    color: Colors.green),
                                onPressed: () =>
                                    deleteProduct(supplierId, product.id),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
            ],
          ),
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

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
