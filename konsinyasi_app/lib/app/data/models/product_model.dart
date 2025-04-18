class ProductModel {
  final String id;
  final String name;
  final int initialQuantity;
  final int newQuantity;

  ProductModel({
    required this.id,
    required this.name,
    required this.initialQuantity,
    required this.newQuantity,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      initialQuantity: json['initial_quantity'],
      newQuantity: json['new_quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'initial_quantity': initialQuantity,
      'new_quantity': newQuantity,
    };
  }
}
