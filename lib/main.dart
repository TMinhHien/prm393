import 'models/product.dart';

void main() {
  // In danh sách ban đầu
  print('=== Danh sách sản phẩm ===');
  Product.products.forEach(print);

  // Search by name
  print('\n--- Search "samsung" ---');
  Product.searchByName('samsung').forEach(print);

  // Find by ID
  print('\n--- Find id = 2 ---');
  print(Product.findById(2));

  // Search by price range
  print('\n--- Giá \$500 - \$1000 ---');
  Product.searchByPriceRange(500, 1000).forEach(print);

  // Add
  Product.add(Product(id: 5, name: 'Vivo V29', image: 'vivo.png', price: 400));
  print('\n--- Sau khi add ---');
  Product.products.forEach(print);

  // Edit
  Product.edit(
    Product(
      id: 1,
      name: 'Samsung S24 Ultra (Mới)',
      image: 's24.png',
      price: 1100,
    ),
  );
  print('\n--- Sau khi edit id=1 ---');
  Product.products.forEach(print);

  // Increase price 10%
  Product.increasePrice();
  print('\n--- Sau khi tăng giá 10% ---');
  Product.products.forEach(print);
}
