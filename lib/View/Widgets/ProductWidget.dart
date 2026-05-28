import 'package:flutter/material.dart';
import '../../Entities/Product.dart';

class ProductWidget extends StatelessWidget {
  final Product product;

  const ProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            // Image
            Image.network(
              product.image,
              height: 120,
            ),

            SizedBox(height: 10),

            // Name
            Text(
              product.name,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            // Price
            Text(
              "\$${product.price}",
              style: TextStyle(
                fontSize: 18,
                color: Colors.red,
              ),
            ),

            SizedBox(height: 10),

            // Icon
            Icon(
              Icons.favorite,
              color: Colors.pink,
              size: 35,
            ),

            SizedBox(height: 10),

            // ListTile
            Card(
              child: ListTile(
                leading: Icon(Icons.shopping_cart),
                title: Text("Add to cart"),
                subtitle: Text("Flutter UI Lab"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
          ],
        ),
      ),
    );
  }
}