import 'package:get/get.dart';
import '../models/product_model.dart';
import '../models/partner_model.dart';
import '../models/invoice_model.dart';

class ApiProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR_API_BASE_URL';
    super.onInit();
  }

  Future<List<ProductModel>> getProducts() async {
    // Mock data for products
    return [
      ProductModel(
        id: '1',
        name: 'Product 1',
        initialQuantity: 10,
        newQuantity: 5,
      ),
      ProductModel(
        id: '2',
        name: 'Product 2',
        initialQuantity: 15,
        newQuantity: 8,
      ),
    ];
  }

  Future<List<PartnerModel>> getPartners() async {
    // Mock data for partners
    return [
      PartnerModel(
        id: '1',
        name: 'A. Afina F',
        address: 'Jl. Example No. 1',
        phone: '08123456789',
        email: 'afina@example.com',
      ),
      PartnerModel(
        id: '2',
        name: 'Outlet B',
        address: 'Jl. Example No. 2',
        phone: '08234567890',
        email: 'outletb@example.com',
      ),
      PartnerModel(
        id: '3',
        name: 'Outlet C',
        address: 'Jl. Example No. 3',
        phone: '08345678901',
        email: 'outletc@example.com',
      ),
    ];
  }

  Future<List<InvoiceModel>> getInvoices() async {
    // Mock data for invoices
    return [
      InvoiceModel(
        id: '1',
        partnerId: '1',
        date: DateTime.now(),
        products: [
          ProductModel(
            id: '1',
            name: 'Product 1',
            initialQuantity: 10,
            newQuantity: 5,
          ),
        ],
      ),
    ];
  }

  Future<InvoiceModel> getInvoiceById(String id) async {
    // Mock data for single invoice
    return InvoiceModel(
      id: id,
      partnerId: '1',
      date: DateTime.now(),
      products: [
        ProductModel(
          id: '1',
          name: 'Product 1',
          initialQuantity: 10,
          newQuantity: 5,
        ),
      ],
    );
  }
}
