import 'package:flutter/material.dart';
import 'package:tienda_productos/screens/login_screen.dart';
import 'package:tienda_productos/services/api_service.dart';
import 'package:tienda_productos/services/database_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final databaseService = DatabaseService();
  final apiService = ApiService(databaseService: databaseService);

  runApp(MyApp(apiService: apiService, databaseService: databaseService));
}

class MyApp extends StatelessWidget {
  final ApiService apiService;
  final DatabaseService databaseService;

  const MyApp({super.key, required this.apiService, required this.databaseService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tienda de Productos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(apiService: apiService),
    );
  }
}
