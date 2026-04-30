import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'sign_in.dart';
import 'home_page.dart';
import 'product_favorite.dart';
import 'cart_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sign In',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/signin',
        routes: {
          '/signin': (context) => const SignInScreen(),
          '/home': (context) => const HomeScreen(),
          '/favorite': (context) => const FavoriteProductsScreen(),
          '/cart': (context) => const CartPage(),
        },
      ),
    );
  }
}