// import 'package:drink_it/core/app_module.dart';
import 'package:drink_it/core/container.dart';
import 'package:drink_it/pages/home/home_page.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_modular/flutter_modular.dart';

void main() {
  setupContainer();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drink.it',
      theme:
          ThemeData(primarySwatch: Colors.blue, primaryColor: Colors.red[400]),
      home: const HomePage(),
    );
  }
}
