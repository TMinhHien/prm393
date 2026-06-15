import 'package:exam/Entity/Product.dart';
import 'package:exam/Views/Widgets/ProductWidget.dart';
import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  final List<Product> products;

  const ProductList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: products.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) =>
          ProductWidgetStateFull(product: products[index]),
    );
  }
}

class ProductListReponsive extends StatelessWidget {
  final List<Product> products;

  const ProductListReponsive({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => GridView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: constraints.maxWidth <= 450 ? 1 : 2,
          childAspectRatio: constraints.maxWidth <= 450 ? 0.82 : 0.78,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) =>
            ProductWidgetStateFull(product: products[index]),
      ),
    );
  }
}
