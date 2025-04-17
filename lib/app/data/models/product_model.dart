class ProductModel {
  final int id;
  final String name;
  final int stock;
  final int sold;

  ProductModel({
    required this.id,
    required this.name,
    required this.stock,
    required this.sold,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      stock: json['stock'],
      sold: json['sold'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'stock': stock,
      'sold': sold,
    };
  }
}
