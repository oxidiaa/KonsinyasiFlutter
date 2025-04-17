import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import 'invoice_screen.dart';

class SalesPartnerScreen extends StatefulWidget {
  const SalesPartnerScreen({Key? key}) : super(key: key);

  @override
  State<SalesPartnerScreen> createState() => _SalesPartnerScreenState();
}

class _SalesPartnerScreenState extends State<SalesPartnerScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Dummy data untuk list mitra
  final List<Map<String, String>> partners = [
    {'name': 'A. Afina F', 'id': '1'},
    {'name': 'Outlet B', 'id': '2'},
    {'name': 'Outlet C', 'id': '3'},
    {'name': 'Outlet D', 'id': '4'},
    {'name': 'Outlet E', 'id': '5'},
    {'name': 'Outlet F', 'id': '6'},
    {'name': 'Outlet G', 'id': '7'},
    {'name': 'Outlet H', 'id': '8'},
    {'name': 'Outlet I', 'id': '9'},
    {'name': 'Outlet J', 'id': '10'},
    {'name': 'Outlet K', 'id': '11'},
    {'name': 'Outlet L', 'id': '12'},
    {'name': 'Outlet M', 'id': '13'},
    {'name': 'Outlet N', 'id': '14'},
    {'name': 'Outlet O', 'id': '15'},
  ];

  void _showInvoice(String partnerName) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: InvoiceScreen(partnerName: partnerName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Penjualan & Mitra'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
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
            child: ListView.builder(
              itemCount: partners.length,
              itemBuilder: (context, index) {
                final partner = partners[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppTheme.primaryColor,
                      child: Text(
                        partner['id']!,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(partner['name']!),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.receipt, color: Colors.grey),
                          onPressed: () => _showInvoice(partner['name']!),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            // Handle edit
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            // Handle delete
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle tambah mitra
        },
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
