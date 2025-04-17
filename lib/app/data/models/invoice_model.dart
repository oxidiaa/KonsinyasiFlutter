import 'product_model.dart';

class InvoiceModel {
  final String id;
  final String partnerId;
  final String partnerName;
  final DateTime date;
  final List<ProductModel> products;
  final String status;
  final double totalAmount;

  InvoiceModel({
    required this.id,
    required this.partnerId,
    required this.partnerName,
    required this.date,
    required this.products,
    required this.status,
    required this.totalAmount,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      id: json['id'],
      partnerId: json['partner_id'],
      partnerName: json['partner_name'],
      date: DateTime.parse(json['date']),
      products: (json['products'] as List)
          .map((product) => ProductModel.fromJson(product))
          .toList(),
      status: json['status'],
      totalAmount: json['total_amount'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'partner_id': partnerId,
      'partner_name': partnerName,
      'date': date.toIso8601String(),
      'products': products.map((product) => product.toJson()).toList(),
      'status': status,
      'total_amount': totalAmount,
    };
  }
}
