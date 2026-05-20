class Product {
  final int id;
  final String name;
  final String image;
  double price;

  // Phương thức khởi tạo
  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  // Factory map từ JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      price: (json['price'] as num).toDouble(),
    );
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, image: $image, price: \$${price.toStringAsFixed(0)})';
  }

  // Danh sách tĩnh mặc định
  static List<Product> products = [
    Product(
      id: 1,
      name: 'Samsung S24 Ultra',
      image: 's24_ultra.png',
      price: 1300,
    ),
    Product(id: 2, name: 'iPhone 15 Pro', image: 'iphone15.png', price: 1200),
    Product(id: 3, name: 'Xiaomi 14', image: 'xiaomi14.png', price: 700),
    Product(id: 4, name: 'OPPO Reno 11', image: 'reno11.png', price: 500),
  ];

  // Add
  static void add(Product product) {
    products.add(product);
  }

  // Edit
  static void edit(Product updated) {
    final index = products.indexWhere((p) => p.id == updated.id);
    if (index != -1) {
      products[index] = updated;
    }
  }

  // Find by ID
  static Product? findById(int id) {
    return products.firstWhere(
      (p) => p.id == id,
      orElse: () => throw Exception('Not found'),
    );
  }

  // Search by name
  static List<Product> searchByName(String keyword) {
    return products
        .where((p) => p.name.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
  }

  // Search by price range
  static List<Product> searchByPriceRange(double min, double max) {
    return products.where((p) => p.price >= min && p.price <= max).toList();
  }

  // increasePrice dùng declarative map (tăng 10%)
  static void increasePrice() {
    products = products
        .map(
          (p) => Product(
            id: p.id,
            name: p.name,
            image: p.image,
            price: p.price * 1.1,
          ),
        )
        .toList();
  }
}
