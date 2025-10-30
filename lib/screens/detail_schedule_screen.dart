// lib/screens/detail_schedule_screen.dart

import 'package:flutter/material.dart';
import 'dashboard.dart';
import '../data/data_schedule.dart'; // Akses data

class DetailScheduleScreen extends StatefulWidget {
  final Map<String, dynamic> scheduleItem;
  final int index;
  final Function(int)
  deleteCallback; // Callback untuk menghapus dari ScheduleScreen

  const DetailScheduleScreen({
    super.key,
    required this.scheduleItem,
    required this.index,
    required this.deleteCallback,
  });

  @override
  State<DetailScheduleScreen> createState() => _DetailScheduleScreenState();
}

class _DetailScheduleScreenState extends State<DetailScheduleScreen> {
  late Map<String, dynamic> _currentItem;

  @override
  void initState() {
    super.initState();
    _currentItem = Map.from(widget.scheduleItem); // Salin data awal
  }

  void _startEdit() {
    final timeController = TextEditingController(text: _currentItem['time']);
    final activityController = TextEditingController(
      text: _currentItem['activity'],
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Aktivitas"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: timeController,
                decoration: const InputDecoration(labelText: "Waktu (HH.MM)"),
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
                // Update data di dailySchedule (global) dan state lokal
                setState(() {
                  dailySchedule[widget.index]['time'] = timeController.text;
                  dailySchedule[widget.index]['activity'] =
                      activityController.text;
                  _currentItem = dailySchedule[widget.index];
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Jadwal berhasil diperbarui sementara."),
                  ),
                );
              },
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Konfirmasi Hapus"),
        content: const Text("Anda yakin ingin menghapus jadwal ini?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () {
              widget.deleteCallback(
                widget.index,
              ); // Panggil fungsi hapus dari ScheduleScreen
              Navigator.pop(context); // Tutup dialog
              Navigator.pop(context); // Kembali ke ScheduleScreen
            },
            child: const Text("Hapus", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = DashboardScreenState.getDarkMode;
    final bgColor = isDarkMode
        ? const Color(0xFF0D0D0D)
        : const Color(0xFFF8F9FE);
    final cardColor = isDarkMode ? const Color(0xFF1C1C1E) : Colors.white;
    final textColor = isDarkMode ? Colors.white : const Color(0xFF1C1C1E);
    final subtextColor = isDarkMode
        ? const Color(0xFF8E8E93)
        : const Color(0xFF6E6E73);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text("Detail Aktivitas"),
        backgroundColor: cardColor,
        elevation: 1,
        iconTheme: IconThemeData(color: textColor),
        titleTextStyle: TextStyle(
          color: textColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          // Tombol Edit
          IconButton(
            icon: const Icon(Icons.edit_rounded, size: 24),
            color: Colors.blue.shade400,
            onPressed: _startEdit,
          ),
          // Tombol Hapus
          IconButton(
            icon: const Icon(Icons.delete_forever_rounded, size: 24),
            color: Colors.red.shade400,
            onPressed: _confirmDelete,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon Aktivitas
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF5E92F3).withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                _currentItem["icon"],
                color: const Color(0xFF5E92F3),
                size: 60,
              ),
            ),
            const SizedBox(height: 24),

            // Waktu
            Text(
              "Waktu:",
              style: TextStyle(
                fontSize: 14,
                color: subtextColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _currentItem["time"]!,
              style: TextStyle(
                fontSize: 28,
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Divider(height: 40),

            // Deskripsi/Aktivitas
            Text(
              "Aktivitas:",
              style: TextStyle(
                fontSize: 14,
                color: subtextColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _currentItem["activity"]!,
              style: TextStyle(fontSize: 18, color: textColor, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
