import 'package:exam/Entity/Product.dart';
import 'package:exam/Reposistory/ProductDAO.dart';

class Productservice {
  List<Product>? products;

  Productservice() {
    // FIX: ProductDAO() không nullable, bỏ dấu ! không cần thiết
    ProductDAO productDAO = ProductDAO();
    products = productDAO.getAllProduct();
  }

  List<Product> getAllProduct() {
    return products!;
  }
}
