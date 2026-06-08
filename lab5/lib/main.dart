import 'package:exam/ViewModel/ProductService.dart';
import 'package:exam/Views/Pages/AboutPage.dart';
import 'package:flutter/material.dart';
import 'package:exam/Views/Pages/HomePage.dart';
import 'package:exam/Entity/Product.dart';

void main() {
  // Lấy danh sách sản phẩm từ ViewModel layer trước khi chạy app
  final Productservice productService = Productservice();
  final List<Product> products = productService.getAllProduct();
  runApp(MyApp(products: products));
}

class MyApp extends StatelessWidget {
  // FIX: final để thoả mãn @immutable
  final List<Product> products;
  const MyApp({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product App',
      routes: {
        '/': (context) => Homepage(products: products),
        '/about': (context) => const AboutPage(),
      },
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
    );
  }
}
