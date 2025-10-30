// lib/screens/schedule_screen.dart

import 'package:flutter/material.dart';
import '../data/data_schedule.dart'; // Menggunakan dailySchedule (non-final)
import 'dashboard.dart';
import 'detail_schedule_screen.dart'; // Import DetailScheduleScreen

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  // Metode untuk menampilkan dialog TAMBAH jadwal
  void _addScheduleItem() {
    final timeController = TextEditingController();
    final activityController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Tambah Jadwal Baru"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: timeController,
                decoration: const InputDecoration(labelText: "Waktu (HH.MM)"),
                keyboardType: TextInputType.datetime,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: activityController,
                decoration: const InputDecoration(labelText: "Aktivitas"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                if (timeController.text.isNotEmpty &&
                    activityController.text.isNotEmpty) {
                  // Tambahkan data baru ke dailySchedule (di memori)
                  setState(() {
                    dailySchedule.add({
                      "time": timeController.text,
                      "activity": activityController.text,
                      "icon": Icons.event, // Default icon untuk item baru
                    });
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Jadwal baru ditambahkan!")),
                  );
                }
              },
              child: const Text("Tambah"),
            ),
          ],
        );
      },
    );
  }

  // Metode untuk menghapus jadwal (dipanggil dari panah)
  void _deleteScheduleItem(int index) {
    setState(() {
      dailySchedule.removeAt(index);
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Jadwal dihapus sementara.")));
  }

  @override
  Widget build(BuildContext context) {
    // Tema dinamis diambil dari DashboardState
    final isDarkMode = DashboardScreenState.getDarkMode;
    final bgColor = isDarkMode
        ? const Color(0xFF121212)
        : const Color(0xFFF5F5F5);
    final cardColor = isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final subtextColor = isDarkMode ? Colors.white70 : Colors.black54;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text("Semua Jadwal"),
        backgroundColor: cardColor,
        elevation: 1, // Beri sedikit elevasi agar terlihat jelas
        iconTheme: IconThemeData(color: textColor),
        titleTextStyle: TextStyle(
          color: textColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          // Tombol TAMBAH JADWAL BARU
          IconButton(
            icon: const Icon(Icons.add_circle_outline_rounded, size: 24),
            color: Colors.blue.shade400,
            onPressed: _addScheduleItem,
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: dailySchedule.length,
        itemBuilder: (context, index) {
          final item = dailySchedule[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                // Navigasi ke detail saat seluruh item di-tap
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScheduleScreen(
                        scheduleItem: item,
                        index:
                            index, // Kirim index untuk fungsi Hapus di Detail
                        deleteCallback:
                            _deleteScheduleItem, // Kirim callback hapus
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      // Icon dan Waktu (Kiri)
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          item["icon"],
                          color: Colors.blue.shade400,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Aktivitas (Tengah)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item["activity"]!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: textColor,
                              ),
                            ),
                            Text(
                              item["time"]!,
                              style: TextStyle(
                                fontSize: 13,
                                color: subtextColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Panah (Kanan)
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                        color: subtextColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
