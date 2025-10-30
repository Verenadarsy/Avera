// lib/data/data_schedule.dart

import 'package:flutter/material.dart';

// Hapus 'final' agar data bisa dimodifikasi di memori (RAM)
List<Map<String, dynamic>> dailySchedule = [
  {
    "time": "09.00",
    "activity": "Sarapan dan siapin hari",
    "icon": Icons.breakfast_dining,
  },
  {
    "time": "11.00",
    "activity": "Kuliah Pemrograman Mobile (UTS 13 Nov 2025)",
    "icon": Icons.school,
  },
  {
    "time": "14.00",
    "activity": "Kerjakan proyek Avera ✨ (Biodata & Kontak)",
    "icon": Icons.laptop,
  },
  // ... data lain
];
