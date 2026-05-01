import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/product_provider.dart';
import 'providers/notification_provider.dart';
import 'sign_in.dart';
import 'home_page.dart';
import 'product_favorite.dart';
import 'cart_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authProvider = AuthProvider();
  await authProvider.loadToken();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authProvider),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()..loadDummyNotifications()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Saya',
      initialRoute: '/signin',
      routes: {
        '/signin': (context) => const SignInScreen(),
        '/home': (context) => const HomeScreen(),
        '/favorite': (context) => const FavoriteProductsScreen(),
        '/cart': (context) => const CartPage(),
      },
    );
  }
}