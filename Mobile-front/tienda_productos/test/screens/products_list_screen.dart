import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tienda_productos/models/product.dart';
import 'package:tienda_productos/screens/products_list_screen.dart';
import 'package:tienda_productos/services/api_service.dart';

import 'products_list_screen.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  late MockApiService mockApiService;
  late List<Product> mockProducts;

  setUp(() {
    mockApiService = MockApiService();
    mockProducts = [
      Product(id: 1, name: "Producto 1", description: "Desc 1", brand: "Marca 1", category: "Categoria 1", rating: 4.5, price: 10.0),
      Product(id: 2, name: "Producto 2", description: "Desc 2", brand: "Marca 2", category: "Categoria 2", rating: 4.0, price: 15.0),
    ];
  });

  testWidgets('Shows CircularProgressIndicator while loading', (WidgetTester tester) async {
    when(mockApiService.getProducts()).thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 1));
      return mockProducts;
    });

    await tester.pumpWidget(MaterialApp(
      home: ProductsListScreen(apiService: mockApiService),
    ));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Displays list of products after loading', (WidgetTester tester) async {
    when(mockApiService.getProducts()).thenAnswer((_) async => mockProducts);

    await tester.pumpWidget(MaterialApp(
      home: ProductsListScreen(apiService: mockApiService),
    ));
    await tester.pumpAndSettle();

    expect(find.text("Producto 1"), findsOneWidget);
    expect(find.text("Producto 2"), findsOneWidget);
  });

  testWidgets('Filters products based on search input', (WidgetTester tester) async {
    when(mockApiService.getProducts()).thenAnswer((_) async => mockProducts);

    await tester.pumpWidget(MaterialApp(
      home: ProductsListScreen(apiService: mockApiService),
    ));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), "Producto 1");
    await tester.pump();

    expect(find.text("Producto 1"), findsOneWidget);
    expect(find.text("Producto 2"), findsNothing);
  });
}
