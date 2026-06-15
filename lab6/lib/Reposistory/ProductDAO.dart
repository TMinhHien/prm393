import 'package:exam/Entity/Product.dart';

class ProductDAO {
  final List<Product> _products = List<Product>.from(Product.products);

  List<Product> getAllProduct() {
    return _products;
  }

  void addProduct(Product product) {
    var index = _products.indexWhere((element) => element.id == product.id);
    if (index < 0) {
      _products.add(product);
    }
  }

  void deleteProduct(String id) {
    _products.removeWhere((element) => element.id == id);
  }

  void updateProduct(Product productNew) {
    var index = _products.indexWhere((element) => element.id == productNew.id);
    if (index >= 0) {
      _products[index] = productNew;
    }
  }
}
