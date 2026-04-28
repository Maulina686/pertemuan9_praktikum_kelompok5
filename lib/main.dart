import 'package:flutter/material.dart';
import 'sign_in.dart';
import 'home_page.dart';
import 'product_favorite .dart';
import 'package:pertemuan9_praktikum_kelompok5/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sign In',
      theme: ThemeData(primarySwatch: Colors.blue),

      initialRoute: '/signin',
      routes: {
        '/signin': (context) => const SignInScreen(),
        '/home': (context) => const HomeScreen(),
        '/product': (context) => const FavoriteProductsScreen(),
      },
    );
  }
}
