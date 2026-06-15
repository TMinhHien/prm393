import 'package:exam/Entity/Product.dart';
import 'package:exam/Views/Widgets/ButtonBar.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Product Detail'),
      ),
      bottomNavigationBar: const Buttonbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                product.image ?? 'assets/images/dog.jpg',
                width: double.infinity,
                height: 260,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              product.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text('Product ID: ${product.id}'),
            const SizedBox(height: 8),
            Text(
              'Price: ${product.price}\$',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Text(
              product.description,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
