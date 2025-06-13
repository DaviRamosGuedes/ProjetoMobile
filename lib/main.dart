import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ForcaVendasApp());
}

class ForcaVendasApp extends StatelessWidget {
  const ForcaVendasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Força de Vendas',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
