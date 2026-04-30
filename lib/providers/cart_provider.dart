// lib/providers/cart_provider.dart
import 'package:flutter/material.dart';
import 'package:pertemuan9_praktikum_kelompok5/models/product.dart';

// Kelas ini merepresentasikan satu item di dalam keranjang
class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });
}

// Kelas inilah yang akan menjadi 'otak' dari keranjang kita, mengelola semua data.
class CartProvider extends ChangeNotifier {
  // Tempat menyimpan daftar item di keranjang
  List<CartItem> _cartItems = [];

  // Getter untuk membaca daftar item. Dengan ini, widget bisa melihat isi keranjang.
  List<CartItem> get cartItems => _cartItems;

  // Fungsi untuk menambahkan produk ke keranjang
  void addToCart(Product product) {
    // Cek apakah produk ini sudah ada di keranjang
    final existingIndex = _cartItems.indexWhere((item) => item.product.id == product.id);

    if (existingIndex >= 0) {
      // Jika sudah ada, tambah jumlahnya (quantity)
      _cartItems[existingIndex].quantity++;
    } else {
      // Jika belum ada, masukkan sebagai item baru
      _cartItems.add(CartItem(product: product));
    }
    // Memberi tahu semua widget yang 'mendengarkan' bahwa data keranjang sudah berubah,
    // sehingga tampilan akan diperbarui secara otomatis.
    notifyListeners();
  }

  // Fungsi untuk menghapus satu item dari keranjang
  void removeFromCart(Product product) {
    _cartItems.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }

  // Fungsi untuk mengurangi jumlah (quantity) suatu item
  void decrementQuantity(Product product) {
    final existingIndex = _cartItems.indexWhere((item) => item.product.id == product.id);
    if (existingIndex >= 0) {
      if (_cartItems[existingIndex].quantity > 1) {
        _cartItems[existingIndex].quantity--;
      } else {
        // Jika jumlahnya tinggal 1 dan dikurangi lagi, hapus item dari keranjang
        _cartItems.removeAt(existingIndex);
      }
      notifyListeners();
    }
  }

  // Fungsi untuk menghitung total harga semua item di keranjang
  double get totalPrice {
    double total = 0.0;
    for (var item in _cartItems) {
      total += item.product.price * item.quantity;
    }
    return total;
  }

  // Fungsi untuk menghitung jumlah total item di keranjang (misal: 2 produk, masing-masing quantity 3 → total 6)
  int get totalItemsCount {
    int count = 0;
    for (var item in _cartItems) {
      count += item.quantity;
    }
    return count;
  }
}