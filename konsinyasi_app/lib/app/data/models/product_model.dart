class ProductModel {
  final String id;
  final String name;
  final int initialQuantity;
  final int newQuantity;
  final int totalStock;
  final double price;

  ProductModel({
    required this.id,
    required this.name,
    required this.initialQuantity,
    required this.newQuantity,
    required this.totalStock,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'initialQuantity': initialQuantity,
      'newQuantity': newQuantity,
      'totalStock': totalStock,
      'price': price,
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      initialQuantity: json['initialQuantity'],
      newQuantity: json['newQuantity'],
      totalStock: json['totalStock'],
      price: json['price'].toDouble(),
    );
  }
}
