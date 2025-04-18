import 'product_model.dart';

class InvoiceModel {
  final String id;
  final String partnerId;
  final DateTime date;
  final List<ProductModel> products;

  InvoiceModel({
    required this.id,
    required this.partnerId,
    required this.date,
    required this.products,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      id: json['id'],
      partnerId: json['partner_id'],
      date: DateTime.parse(json['date']),
      products: (json['products'] as List)
          .map((item) => ProductModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'partner_id': partnerId,
      'date': date.toIso8601String(),
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}
