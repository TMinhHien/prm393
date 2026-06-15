import 'package:exam/Entity/Product.dart';
import 'package:exam/Reposistory/ProductDAO.dart';

class ProductService {
  final ProductDAO _productDAO = ProductDAO();

  List<Product> getAllProduct() {
    return _productDAO.getAllProduct();
  }
}

class Productservice extends ProductService {
  Productservice();
}
