class ProductList {
  final int id;
  final String createdAt;
  final String updatedAt;
  final String name;
  final String description;
  final double price;
  final Category category;

  ProductList({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
  });

  factory ProductList.fromJson(Map<String, dynamic> json) {
    return ProductList(
      id: json['id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      name: json['name'],
      description: json['description'],
      price: double.parse(json['price'].toString()),
      category: Category.fromJson(json['category']),
    );
  }
}

class Category {
  final int? id;
  final String? name;

  Category({this.id, this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Categories {
  final int id;
  final String createdAt;
  final String updatedAt;
  final String name;
  final String description;

  Categories({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.description,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      id: json['id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      name: json['name'],
      description: json['description'],
    );
  }
}
