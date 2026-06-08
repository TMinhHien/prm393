import 'package:exam/Entity/Product.dart';
import 'package:exam/Views/Pages/ProductDetailPage.dart';
import 'package:flutter/material.dart';

// ─── Widget tổng: load danh sách từ static data ───────────────────────────
class ProductListWidget extends StatelessWidget {
  ProductListWidget({super.key});
  final List<Product> products = Product.products;

  @override
  Widget build(BuildContext context) {
    return ReponsiveProduct(products: products);
  }
}

// ─── Responsive grid: 1 cột (mobile) hoặc 2 cột (tablet/desktop) ─────────
class ReponsiveProduct extends StatelessWidget {
  final List<Product> products;
  const ReponsiveProduct({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: MediaQuery.of(context).size.width < 450 ? 1 : 2,
      children: products
          .map((product) => ProductWidget(product: product))
          .toList(),
    );
  }
}

// ─── 1 cột ──────────────────────────────────────────────────────────────
class OneColumnProduct extends StatelessWidget {
  final List<Product> products;
  const OneColumnProduct({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: products
          .map((product) => ProductWidget(product: product))
          .toList(),
    );
  }
}

// ─── Item: StatefulWidget bao ngoài ─────────────────────────────────────
class ProductWidget extends StatefulWidget {
  final Product product;
  const ProductWidget({super.key, required this.product});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    // Toàn bộ card có thể bấm → sang ProductDetailPage
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProductDetailPage(product: widget.product),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ProductContainer(product: widget.product),
      ),
    );
  }
}

// ─── Container hiển thị chi tiết 1 sản phẩm ────────────────────────────
class ProductContainer extends StatefulWidget {
  final Product product;
  const ProductContainer({super.key, required this.product});

  @override
  State<ProductContainer> createState() => _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer> {
  int _selectSort = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        width: constraints.maxWidth <= 450
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width / 2,
        height: 500,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              // ─── Dropdown sort ───────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: DropdownButton<int>(
                  isExpanded: true,
                  value: _selectSort,
                  items: const [
                    DropdownMenuItem(child: Text("A-Z"), value: 0),
                    DropdownMenuItem(child: Text("Z-A"), value: 1),
                    DropdownMenuItem(child: Text("Low to High"), value: 2),
                    DropdownMenuItem(child: Text("High to Low"), value: 3),
                  ],
                  onChanged: (value) => setState(() {
                    _selectSort = value!;
                  }),
                ),
              ),

              // ─── Ảnh sản phẩm + nút View Detail ─────────────────
              Expanded(
                flex: 7,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(4)),
                        child: Image.asset(
                          widget.product.image!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Nút View Detail (góc dưới phải)
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: FloatingActionButton.extended(
                          heroTag: 'fab_${widget.product.id}',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailPage(
                                    product: widget.product),
                              ),
                            );
                          },
                          label: const Text("Xem chi tiết"),
                          icon: const Icon(Icons.info_outline),
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ─── Tên, giá, like ──────────────────────────────────
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              widget.product.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "Giá: \$${widget.product.price.toStringAsFixed(0)}",
                              style: const TextStyle(
                                  color: Colors.blue, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite_border,
                              color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ─── Stars ───────────────────────────────────────────
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    Icon(Icons.star_half, color: Colors.amber, size: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
