import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tienda_productos/models/product.dart';
import 'package:tienda_productos/services/database_service.dart';

class ApiService {
  final String _baseUrl = 'http://localhost:8080';
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final DatabaseService databaseService;

  ApiService({required this.databaseService});

  Future<void> setAuthToken(String token) async {
    await secureStorage.write(key: 'authToken', value: token);
  }

  Future<String?> getAuthToken() async {
    return await secureStorage.read(key: 'authToken');
  }

  Future<http.Response> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );
    if (response.statusCode == 200) {
      String token = json.decode(response.body)['token'];
      await setAuthToken(token);
    }
    return response;
  }

  Future<List<Product>> getProducts() async {
    List<Product> localProducts = await databaseService.getProducts();
    if (localProducts.isNotEmpty) {
      return localProducts;
    } else {
      String? token = await getAuthToken();
      final response = await http.get(
        Uri.parse('$_baseUrl/products'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final List<dynamic> productData = json.decode(response.body);
        List<Product> products = productData.map((json) => Product.fromJson(json)).toList();
        await databaseService.clearProducts();
        for (var product in products) {
          databaseService.insertProduct(product);
        }
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    }
  }
}
