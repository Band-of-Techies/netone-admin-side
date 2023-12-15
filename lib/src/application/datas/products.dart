class ProductList {
  final int id;
  final String createdAt;
  final String updatedAt;
  final String name;
  final String description;
  final double price;

  ProductList({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.description,
    required this.price,
  });

  factory ProductList.fromJson(Map<String, dynamic> json) {
    return ProductList(
      id: json['id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      name: json['name'],
      description: json['description'],
      price: double.parse(json['price'].toString()),
    );
  }
}
