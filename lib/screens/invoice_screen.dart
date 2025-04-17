import 'package:flutter/material.dart';
import '../themes/app_theme.dart';

class InvoiceScreen extends StatefulWidget {
  final String partnerName;

  const InvoiceScreen({
    Key? key,
    required this.partnerName,
  }) : super(key: key);

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  final List<Map<String, dynamic>> products = [
    {'id': 1, 'name': 'Fito oil gold', 'stock': 220, 'sold': 220},
    {'id': 2, 'name': 'Jahe Merah Koromah', 'stock': 250, 'sold': 250},
    {'id': 3, 'name': 'Jahe Merah Barokah', 'stock': 0, 'sold': 0},
    {'id': 4, 'name': 'Jahe Merah Amanah', 'stock': 0, 'sold': 0},
    {'id': 5, 'name': 'Madu Batuk Murataza', 'stock': 8, 'sold': 8},
    {'id': 6, 'name': 'Madu Gemuk Badan Murataza', 'stock': 2, 'sold': 2},
    {'id': 7, 'name': 'Madu Propolis Balita', 'stock': 0, 'sold': 0},
  ];

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
          onPressed: () => Navigator.pop(context),
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
                    Text(
                      widget.partnerName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('No')),
                  DataColumn(label: Text('Nama Product')),
                  DataColumn(label: Text('K.Awal')),
                  DataColumn(label: Text('K.Baru')),
                  DataColumn(label: Text('T.Stok')),
                ],
                rows: products.map((product) {
                  return DataRow(
                    cells: [
                      DataCell(Text(product['id'].toString())),
                      DataCell(Text(product['name'])),
                      DataCell(Text(product['stock'].toString())),
                      DataCell(
                        product['sold'] > 0
                            ? Text(product['sold'].toString())
                            : const Text('-'),
                      ),
                      DataCell(Text(product['stock'].toString())),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle print faktur
                  },
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
                      onPressed: () {
                        // Handle januari
                      },
                      child: const Text(
                        'JANUARI',
                        style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Handle februari
                      },
                      child: const Text(
                        'FEBRUARI',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
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
