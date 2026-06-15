class Product {
  final String id;
  final String name;
  final String? image;
  final double price;
  final String description;

  Product({
    required this.id,
    required this.name,
    this.image,
    required this.price,
    this.description =
        'Fresh product with clear origin, good quality, and suitable for daily use.',
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: (json['price'] as num).toDouble(),
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'description': description,
    };
  }

  Product copyWith({
    String? id,
    String? name,
    String? image,
    double? price,
    String? description,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      description: description ?? this.description,
    );
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, image: $image, price: $price, description: $description}';
  }

  static List<Product> products = [
    Product(
      id: 'P01',
      name: 'Iphone 14',
      price: 20000,
      image: 'assets/images/dog.jpg',
      description: 'Iphone 14, product code P01, price 20000.',
    ),
    Product(
      id: 'P02',
      name: 'Iphone 15',
      price: 30000,
      image: 'assets/images/dog.jpg',
      description: 'Iphone 15, product code P02, price 30000.',
    ),
    Product(
      id: 'P03',
      name: 'Iphone 16',
      price: 40000,
      image: 'assets/images/dog.jpg',
      description: 'Iphone 16, product code P03, price 40000.',
    ),
    Product(
      id: 'P04',
      name: 'Iphone 17',
      price: 50000,
      image: 'assets/images/dog.jpg',
      description: 'Iphone 17, product code P04, price 50000.',
    ),
    Product(
      id: 'P05',
      name: 'Iphone 18',
      price: 60000,
      image: 'assets/images/dog.jpg',
      description: 'Iphone 18, product code P05, price 60000.',
    ),
    Product(
      id: 'P06',
      name: 'Iphone 19',
      price: 70000,
      image: 'assets/images/dog.jpg',
      description: 'Iphone 19, product code P06, price 70000.',
    ),
  ];
}
