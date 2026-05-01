import 'package:flutter/material.dart';

class Product {
  final String id;
  final String title;
  final double price;
  final List<String> images;
  final String description;
  final List<Color> colors;
  final double rating;
  bool isFavourite;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.images,
    required this.description,
    required this.colors,
    required this.rating,
    this.isFavourite = false,
  });

  /// Factory method untuk mengkonversi JSON dari API ke objek Product
  /// API mengirim: { "name", "price", "star", "image" }
  factory Product.fromJson(Map<String, dynamic> json) {
    // Ambil nilai dari API
    final String name = json['name'] ?? 'No Name';
    final double price = (json['price'] as num?)?.toDouble() ?? 0.0;
    final double star = (json['star'] as num?)?.toDouble() ?? 0.0;
    final String imageUrl = json['image'] ?? '';

    // Gunakan name sebagai id (sementara, asumsi nama unik)
    // Jika id diperlukan, bisa juga gunakan hash code atau biarkan sebagai string
    return Product(
      id: name, 
      title: name,
      price: price,
      images: imageUrl.isEmpty ? [] : [imageUrl], // API hanya satu gambar
      description: '', // API tidak mengirim deskripsi
      colors: [Colors.white, Colors.black], // default
      rating: star,
      isFavourite: json['isFavourite'] ?? false,
    );
  }
}