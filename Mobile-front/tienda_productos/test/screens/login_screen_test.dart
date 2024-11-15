import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tienda_productos/screens/login_screen.dart';
import 'package:tienda_productos/services/api_service.dart';
import 'package:http/http.dart' as http; // Asegúrate de importar http si usas `http.Response`

import 'login_screen_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
  });

  testWidgets('Shows error message on failed login', (WidgetTester tester) async {
    // Simula una respuesta fallida (statusCode 400)
    when(mockApiService.login(any, any)).thenAnswer((_) async => http.Response('{}', 400));

    await tester.pumpWidget(MaterialApp(
      home: LoginScreen(apiService: mockApiService),
    ));

    await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextField).at(1), 'password123');

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text("Login failed. Please try again."), findsOneWidget);
  });

  testWidgets('Navigates to ProductsListScreen on successful login', (WidgetTester tester) async {
    // Simula una respuesta exitosa (statusCode 200 y un token de ejemplo)
    when(mockApiService.login(any, any)).thenAnswer((_) async => http.Response('{"token": "dummy_token"}', 200));

    await tester.pumpWidget(MaterialApp(
      home: LoginScreen(apiService: mockApiService),
    ));

    await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextField).at(1), 'password123');

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.text('Productos'), findsOneWidget);
  });
}
