import 'package:flutter/material.dart';
import 'package:tienda_productos/models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.description, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text("Marca: ${product.brand}"),
            Text("Categoría: ${product.category}"),
            Text("Rating: ${product.rating}"),
            Text("Precio: \$${product.price}"),
          ],
        ),
      ),
    );
  }
}
