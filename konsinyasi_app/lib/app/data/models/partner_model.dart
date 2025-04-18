class PartnerModel {
  final String id;
  final String name;
  final String? address;
  final String? phone;
  final String? email;

  PartnerModel({
    required this.id,
    required this.name,
    this.address,
    this.phone,
    this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
    };
  }

  factory PartnerModel.fromJson(Map<String, dynamic> json) {
    return PartnerModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
    );
  }
}
