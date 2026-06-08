import 'package:exam/Entity/Product.dart';
import 'package:exam/Views/Widgets/ProductWidget.dart';
import 'package:flutter/material.dart';

// ─── Dùng ProductListReponsive với ProductWidgetStateFull ─────────────────
class ProductList extends StatelessWidget {
  final List<Product> products;
  const ProductList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,   // FIX: không hardcode = 5
      itemBuilder: (context, index) =>
          ProductWidgetStateFull(product: products[index]),
    );
  }
}

// ─── Responsive: 1 cột hoặc 2 cột ────────────────────────────────────────
class ProductListReponsive extends StatelessWidget {
  final List<Product> products;
  const ProductListReponsive({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => GridView.count(
        crossAxisCount: constraints.maxWidth <= 450 ? 1 : 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: products
            .map((p) => ProductWidgetStateFull(product: p))
            .toList(),
      ),
    );
  }
}
