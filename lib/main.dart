import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pertemuan9_praktikum_kelompok5/providers/cart_provider.dart';
// Impor untuk semua halaman Anda
import 'package:pertemuan9_praktikum_kelompok5/sign_in.dart';
import 'package:pertemuan9_praktikum_kelompok5/home_page.dart';
import 'package:pertemuan9_praktikum_kelompok5/product_favorite.dart';
import 'package:pertemuan9_praktikum_kelompok5/cart_page.dart';
// JANGAN impor notification_provider.dart dulu

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Hanya CartProvider yang diperlukan untuk saat ini
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Aplikasi Saya',
        initialRoute: '/signin',
        routes: {
          '/signin': (context) => const SignInScreen(),
          '/home': (context) => const HomeScreen(),
          '/favorite': (context) => const FavoriteProductsScreen(),
          '/cart': (context) => const CartPage(),
          // Jangan sertakan rute untuk notifikasi
        },
      ),
    );
  }
}
