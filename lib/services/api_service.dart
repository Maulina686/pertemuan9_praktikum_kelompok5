import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // ⚠️ GANTI URL INI DENGAN BASE URL DARI DOSEN (lihat di Hoppscotch)
  static const String baseUrl = "https://api.ppb.widiarrohman.my.id/api/2026/uts/A/kelompok5";

Future<Map<String, dynamic>> login(String username, String password) async {
  final url = Uri.parse("$baseUrl/login");
  print("📡 LOGIN URL: $url");
  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"username": username, "password": password}),
  );
  print("📡 STATUS: ${response.statusCode}");
  print("📡 RESPONSE BODY: ${response.body}");
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception("Login gagal: ${response.statusCode} - ${response.body}");
  }
}

Future<List<dynamic>> getProducts(String token) async {
  final url = Uri.parse("$baseUrl/products");
  final response = await http.get(
    url,
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    },
  );
  if (response.statusCode == 200) {
    final decoded = jsonDecode(response.body);
    if (decoded is List) {
      return decoded;
    } else if (decoded is Map<String, dynamic>) {
      // Coba ambil dari key yang umum
      return decoded['data'] ?? decoded['items'] ?? decoded['products'] ?? [];
    } else {
      throw Exception("Format respons tidak dikenal");
    }
  } else {
    throw Exception("Gagal ambil produk: ${response.statusCode} - ${response.body}");
  }
}
  Future<Map<String, dynamic>> getCart(String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/cart"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Gagal ambil cart: ${response.body}");
    }
  }
}