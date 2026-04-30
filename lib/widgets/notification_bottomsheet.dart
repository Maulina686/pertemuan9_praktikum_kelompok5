import 'package:flutter/material.dart';
import 'package:pertemuan9_praktikum_kelompok5/models/notification_model.dart' show AppNotification;
import 'package:provider/provider.dart';
import '../providers/notification_provider.dart';

void showNotificationSheet(BuildContext context) {
  final provider = Provider.of<NotificationProvider>(context, listen: false);
  // Tandai semua sebagai sudah dibaca saat membuka notifikasi
  provider.markAllAsRead();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const NotificationSheetContent(),
  );
}

class NotificationSheetContent extends StatelessWidget {
  const NotificationSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(
      builder: (context, provider, child) {
        final notifications = provider.notifications;
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          builder: (_, controller) => Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                // Handle bar
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 12),
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Notifikasi',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (notifications.isNotEmpty)
                        TextButton(
                          onPressed: () {
                            // Hapus semua notifikasi (opsional)
                            // provider.clearAll(); // tambahkan method jika perlu
                          },
                          child: const Text('Bersihkan'),
                        ),
                    ],
                  ),
                ),
                const Divider(),
                // Daftar notifikasi
                Expanded(
                  child: notifications.isEmpty
                      ? const Center(
                          child: Text('Tidak ada notifikasi'),
                        )
                      : ListView.builder(
                          controller: controller,
                          itemCount: notifications.length,
                          itemBuilder: (context, index) {
                            final notif = notifications[index];
                            return _NotificationItem(notif: notif);
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Item notifikasi – TIDAK BISA DI TEKAN (tidak ada GestureDetector/InkWell)
class _NotificationItem extends StatelessWidget {
  final AppNotification notif;
  const _NotificationItem({required this.notif});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: notif.isRead ? Colors.white : Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ikon kecil
          Container(
            margin: const EdgeInsets.only(right: 12, top: 2),
            child: Icon(
              notif.isRead ? Icons.notifications_none : Icons.notifications_active,
              size: 20,
              color: notif.isRead ? Colors.grey : Colors.blue,
            ),
          ),
          // Konten
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notif.title,
                  style: TextStyle(
                    fontWeight: notif.isRead ? FontWeight.normal : FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  notif.message,
                  style: TextStyle(
                    fontSize: 12,
                    color: notif.isRead ? Colors.grey[600] : Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatRelativeTime(notif.timestamp),
                  style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatRelativeTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);
    if (diff.inDays > 0) {
      return '${diff.inDays} hari lalu';
    } else if (diff.inHours > 0) {
      return '${diff.inHours} jam lalu';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes} menit lalu';
    } else {
      return 'baru saja';
    }
  }
}