class Product {
  final int id;
  final String name;
  final String description;
  final String brand;
  final String category;
  final double rating;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.brand,
    required this.category,
    required this.rating,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      brand: json['brand']['name'],
      category: json['category']['name'],
      rating: json['rating'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'brand': brand,
      'category': category,
      'rating': rating,
      'price': price,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      brand: map['brand'],
      category: map['category'],
      rating: map['rating'],
      price: map['price'],
    );
  }
}
