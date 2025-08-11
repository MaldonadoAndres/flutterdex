import 'package:flutter/material.dart';
import 'package:pokedex/app/di/injection.dart';
import 'package:pokedex/features/home/presentation/pages/home_page.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: HomePage(),
    );
  }
}
