import 'package:exam/Entity/Product.dart';
import 'package:exam/Views/Pages/ProductDetailPage.dart';
import 'package:flutter/material.dart';

class ProductWidgetStateFull extends StatefulWidget {
  final Product product;

  const ProductWidgetStateFull({super.key, required this.product});

  @override
  State<ProductWidgetStateFull> createState() => _ProductWidgetStateFullState();
}

class _ProductWidgetStateFullState extends State<ProductWidgetStateFull> {
  int _count = 0;

  void openDetail() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailPage(product: widget.product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        height: 500,
        child: InkWell(
          onTap: openDetail,
          borderRadius: BorderRadius.circular(8),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                Expanded(
                  flex: 7,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          widget.product.image ?? 'assets/images/dog.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: FloatingActionButton.extended(
                            heroTag: 'detail-${widget.product.id}',
                            onPressed: openDetail,
                            label: const Text('Detail'),
                            icon: const Icon(Icons.details),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Product Name: ${widget.product.name}'),
                              Text('Price: ${widget.product.price}\$'),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _count++;
                            });
                          },
                          icon: const Icon(Icons.star, color: Colors.yellow),
                        ),
                        Text(_count.toString()),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.star, color: Colors.yellow),
                    Icon(Icons.star, color: Colors.yellow),
                    Icon(Icons.star, color: Colors.yellow),
                    Icon(Icons.star, color: Colors.yellow),
                    Icon(Icons.star, color: Colors.yellow),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SingleChildScrollView(
                      child: Text(
                        widget.product.description,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Productwidget extends StatelessWidget {
  const Productwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ProductWidgetStateFull(product: Product.products.first);
  }
}
