class Product {
  final int id;
  final String createdAt;
  final String updatedAt;
  final String name;
  final String description;
  final double price;

  Product({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.description,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      name: json['name'],
      description: json['description'],
      price: double.parse(json['price'].toString()),
    );
  }
}
