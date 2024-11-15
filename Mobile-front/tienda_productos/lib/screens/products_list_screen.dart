import 'package:flutter/material.dart';
import 'package:tienda_productos/models/product.dart';
import 'package:tienda_productos/services/api_service.dart';
import 'package:tienda_productos/widgets/product_card.dart';

class ProductsListScreen extends StatefulWidget {
  final ApiService apiService;

  const ProductsListScreen({Key? key, required this.apiService}) : super(key: key);

  @override
  ProductsListScreenState createState() => ProductsListScreenState();
}

class ProductsListScreenState extends State<ProductsListScreen> {
  List<Product> products = [];
  bool isLoading = true;
  String filterText = "";

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() async {
    setState(() => isLoading = true);
    final loadedProducts = await widget.apiService.getProducts();
    setState(() {
      products = loadedProducts;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Productos')),
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Buscar producto'),
            onChanged: (value) {
              setState(() => filterText = value);
            },
          ),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      if (filterText.isEmpty || product.name.toLowerCase().contains(filterText.toLowerCase())) {
                        return ProductCard(product: product);
                      }
                      return Container();
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
