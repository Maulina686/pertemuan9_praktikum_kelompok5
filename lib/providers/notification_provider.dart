import 'package:flutter/material.dart';
import '../models/notification_model.dart';

class NotificationProvider extends ChangeNotifier {
  List<AppNotification> _notifications = [];

  List<AppNotification> get notifications => _notifications;

  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  // Tambah notifikasi baru
  void addNotification(String title, String message) {
    final newNotif = AppNotification(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      message: message,
      timestamp: DateTime.now(),
    );
    _notifications.insert(0, newNotif);
    notifyListeners();
  }

  // Tandai semua notifikasi sebagai sudah dibaca
  void markAllAsRead() {
    for (var notif in _notifications) {
      notif.isRead = true;
    }
    notifyListeners();
  }

  // Hapus semua notifikasi
  void clearAll() {
    _notifications.clear();
    notifyListeners();
  }

  // Data dummy untuk demo
  void loadDummyNotifications() {
    _notifications = [
      AppNotification(
        id: '1',
        title: 'Selamat Datang!',
        message: 'Terima kasih telah menggunakan aplikasi kami.',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        isRead: false,
      ),
      AppNotification(
        id: '2',
        title: 'Promo Spesial',
        message: 'Dapatkan diskon 20% untuk semua produk hingga akhir bulan!',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        isRead: false,
      ),
      AppNotification(
        id: '3',
        title: 'Info Aplikasi',
        message: 'Nikmati fitur terbaru kami.',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        isRead: true,
      ),
    ];
    notifyListeners();
  }
}