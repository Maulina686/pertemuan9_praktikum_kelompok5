import 'package:flutter/material.dart';
import 'package:pertemuan9_praktikum_kelompok5/models/product.dart';
import '../services/api_service.dart';

class CartItem {
  final Product product;
  int quantity;
  CartItem({required this.product, this.quantity = 1});
}

class CartProvider extends ChangeNotifier {
  List<CartItem> _cartItems = [];
  final ApiService _api = ApiService();

  List<CartItem> get cartItems => _cartItems;

  // === TAMBAHKAN METHOD INI ===
  Future<void> syncCartFromApi(String token) async {
    try {
      final response = await _api.getCart(token);
      // ⚠️ SESUAIKAN PARSING DENGAN RESPON API DOSEN
      final List<dynamic> itemsJson = response['items'] ?? response['data'] ?? [];
      List<CartItem> newCart = [];
      for (var item in itemsJson) {
        final productJson = item['product'];
        if (productJson == null) continue;
        Product product = Product.fromJson(productJson);
        int qty = item['quantity'] ?? 1;
        newCart.add(CartItem(product: product, quantity: qty));
      }
      _cartItems = newCart;
      notifyListeners();
    } catch (e) {
      print("Gagal sync cart: $e");
    }
  }



  // ========== METHOD ASLI (OFFLINE, TIDAK DIUBAH) ==========
  void addToCart(Product product) {
    final existingIndex = _cartItems.indexWhere((item) => item.product.id == product.id);
    if (existingIndex >= 0) {
      _cartItems[existingIndex].quantity++;
    } else {
      _cartItems.add(CartItem(product: product));
    }
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartItems.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }

  void decrementQuantity(Product product) {
    final existingIndex = _cartItems.indexWhere((item) => item.product.id == product.id);
    if (existingIndex >= 0) {
      if (_cartItems[existingIndex].quantity > 1) {
        _cartItems[existingIndex].quantity--;
      } else {
        _cartItems.removeAt(existingIndex);
      }
      notifyListeners();
    }
  }

  double get totalPrice {
    double total = 0.0;
    for (var item in _cartItems) {
      total += item.product.price * item.quantity;
    }
    return total;
  }

  int get totalItemsCount {
    int count = 0;
    for (var item in _cartItems) {
      count += item.quantity;
    }
    return count;
  }
}