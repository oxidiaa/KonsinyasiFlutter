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
    final response = await get('/products');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return (response.body as List)
          .map((item) => ProductModel.fromJson(item))
          .toList();
    }
  }

  Future<List<PartnerModel>> getPartners() async {
    final response = await get('/partners');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return (response.body as List)
          .map((item) => PartnerModel.fromJson(item))
          .toList();
    }
  }

  Future<List<InvoiceModel>> getInvoices() async {
    final response = await get('/invoices');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return (response.body as List)
          .map((item) => InvoiceModel.fromJson(item))
          .toList();
    }
  }

  Future<InvoiceModel> getInvoiceById(String id) async {
    final response = await get('/invoices/$id');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return InvoiceModel.fromJson(response.body);
    }
  }
}
