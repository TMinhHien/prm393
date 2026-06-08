import 'package:exam/Entity/Product.dart';
import 'package:exam/Views/Pages/ProductDetailPage.dart';
import 'package:flutter/material.dart';

// ─── StatefulWidget bọc ngoài ────────────────────────────────────────────
class ProductWidgetStateFull extends StatefulWidget {
  final Product product;
  const ProductWidgetStateFull({super.key, required this.product});

  @override
  State<ProductWidgetStateFull> createState() =>
      _ProductWidgetStateFullState();
}

class _ProductWidgetStateFullState extends State<ProductWidgetStateFull> {
  int _cout = 0;

  void _onPressLike() {
    setState(() {
      _cout++;
    });
  }

  void _goToDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailPage(product: widget.product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Bọc toàn bộ card bằng GestureDetector → tap bất kỳ đâu cũng vào detail
    return GestureDetector(
      onTap: () => _goToDetail(context),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth <= 450
                ? constraints.maxWidth
                : constraints.maxWidth / 2,
            height: 500,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  // ─── Wrap buttons (demo UI) ───────────────────────
                  Wrap(
                    alignment: WrapAlignment.start,
                    children: [
                      for (int i = 0; i < 5; i++)
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: ElevatedButton(
                            child: Text("Tag ${i + 1}"),
                            onPressed: () {},
                          ),
                        ),
                    ],
                  ),

                  // ─── Ảnh sản phẩm + nút Xem chi tiết ────────────
                  Expanded(
                    flex: 7,
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: ClipRRect(
                            child: Image.asset(
                              widget.product.image!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Nút FAB góc dưới phải
                        Positioned(
                          bottom: 12,
                          right: 12,
                          child: FloatingActionButton.extended(
                            heroTag: 'detail_${widget.product.id}',
                            onPressed: () => _goToDetail(context),
                            label: const Text(
                              "Xem chi tiết",
                              style: TextStyle(color: Colors.white),
                            ),
                            icon: const Icon(Icons.info_outline,
                                color: Colors.white),
                            backgroundColor: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ─── Tên, giá, like ──────────────────────────────
                  const SizedBox(height: 8),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.product.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "Giá: \$${widget.product.price.toStringAsFixed(0)}",
                                  style: const TextStyle(
                                      color: Colors.blue, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: _onPressLike,
                                  icon: const Icon(Icons.favorite,
                                      color: Colors.red),
                                ),
                                Text(_cout.toString()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ─── Stars ───────────────────────────────────────
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      Icon(Icons.star_half, color: Colors.amber, size: 18),
                    ],
                  ),

                  // ─── Mô tả ngắn ──────────────────────────────────
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.grey.shade50,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(6),
                          child: Text(
                            "Sản phẩm ${widget.product.name} chất lượng cao, "
                            "thiết kế hiện đại, phù hợp với mọi nhu cầu. "
                            "Bấm 'Xem chi tiết' để biết thêm thông tin.",
                            textAlign: TextAlign.justify,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
