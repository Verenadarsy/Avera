// lib/screens/dashboard.dart
import 'dart:async';
import 'package:avera/screens/detail_schedule_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'cuaca.dart';
import '../data/data_schedule.dart';
import 'schedule_screen.dart';
import '../styles/app_theme.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  static bool isDarkMode = false;
  late Timer _timer;
  String _currentTime = '';
  String _currentDate = '';

  // FIX: Mengubah 'late' menjadi 'nullable' (?) untuk menghindari LateInitializationError
  AnimationController? _fadeController;
  Animation<double>? _fadeAnimation;

  final List<String> quotes = [
    "Stay curious, keep learning!",
    "Progress, not perfection.",
    "Every day is a new opportunity 🌞",
    "Focus on what matters most.",
    "Believe in your own potential 💪",
  ];

  final List<String> tips = [
    "💧 Minum air putih minimal 8 gelas hari ini!",
    "🧘 Istirahat sebentar tiap 1 jam belajar.",
    "🍎 Jangan lupa makan buah!",
    "📚 Review materi Pemrograman Mobile.",
    "🌿 Hirup udara segar sejenak.",
  ];

  static bool get getDarkMode => isDarkMode;

  static void toggleDarkMode() {
    isDarkMode = !isDarkMode;
  }

  String _capitalize(String s) =>
      s.isNotEmpty ? s[0].toUpperCase() + s.substring(1) : s;

  @override
  void initState() {
    super.initState();

    // FIX: Inisialisasi Animation Controller tanpa 'late'
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController!, curve: Curves.easeIn));

    _fadeController!.forward();

    initializeDateFormatting('id_ID', null).then((_) {
      _updateTime();
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) => _updateTime(),
      );
    });
  }

  void _updateTime() {
    final now = DateTime.now();
    if (mounted) {
      setState(() {
        _currentTime = DateFormat('HH:mm:ss').format(now);
        _currentDate = DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(now);
      });
    }
  }

  void refreshDashboardSchedule(int index) {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _fadeController?.dispose(); // FIX: Safe dispose
    super.dispose();
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return "Selamat Pagi";
    if (hour < 15) return "Selamat Siang";
    if (hour < 18) return "Selamat Sore";
    return "Selamat Malam";
  }

  @override
  Widget build(BuildContext context) {
    // Pengambilan tema
    final isDarkMode = DashboardScreenState.getDarkMode;
    final contentColor = isDarkMode ? Colors.white : const Color(0xFF1C1C1E);
    final subtextColor = isDarkMode
        ? const Color(0xFF8E8E93)
        : const Color(0xFF6E6E73);

    // Pengambilan data cuaca (memanggil State class yang sudah dipublikan)
    final currentTemp = CuacaScreenState.getCurrentTemp();
    final currentCondition = CuacaScreenState.getCurrentCondition();

    final weatherSubtitle = currentTemp != null
        ? "$currentTemp°C ${_capitalize(currentCondition)}"
        : "Memuat...";

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDarkMode
                ? [
                    const Color(0xFF1a237e),
                    const Color(0xFF311b92),
                    const Color(0xFF4a148c),
                  ]
                : [
                    const Color(0xFF5E92F3),
                    const Color(0xFF4DD0E1),
                    const Color(0xFF81C784),
                  ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header Section
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Bar
                    FadeTransition(
                      // FIX: Menggunakan FadeTransition saja
                      opacity: _fadeAnimation!,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.person_outline_rounded,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 6),
                                    const Text(
                                      "Verenada",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.notifications_outlined,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 8),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    DashboardScreenState.toggleDarkMode();
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    isDarkMode
                                        ? Icons.light_mode_rounded
                                        : Icons.dark_mode_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Greeting
                    FadeTransition(
                      // FIX: Menggunakan FadeTransition
                      opacity: _fadeAnimation!,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${_getGreeting()},",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.9),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "this is your dashboard",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Content Section dengan Background Putih
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? const Color(0xFF0D0D0D)
                        : const Color(0xFFF8F9FE),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Time & Weather Card
                              buildAnimatedCard(
                                // Menggunakan helper dari file style
                                delay: 100,
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: isDarkMode
                                          ? [
                                              const Color(0xFF5E92F3),
                                              const Color(0xFF4DD0E1),
                                            ]
                                          : [
                                              const Color(0xFF5E92F3),
                                              const Color(0xFF4DD0E1),
                                            ],
                                    ),
                                    borderRadius: BorderRadius.circular(24),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(
                                          0xFF5E92F3,
                                        ).withOpacity(0.3),
                                        blurRadius: 20,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.access_time_rounded,
                                                    color: Colors.white,
                                                    size: 18,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    "Waktu",
                                                    style: TextStyle(
                                                      color: Colors.white
                                                          .withOpacity(0.9),
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                _currentTime,
                                                style: const TextStyle(
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  letterSpacing: 1,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                _currentDate,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white
                                                      .withOpacity(0.8),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(
                                                0.2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Column(
                                              children: [
                                                const Icon(
                                                  Icons.wb_sunny_rounded,
                                                  color: Colors.white,
                                                  size: 32,
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  weatherSubtitle,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Quote & Tip Cards
                              Row(
                                children: [
                                  Expanded(
                                    child: buildAnimatedCard(
                                      // Menggunakan helper dari file style
                                      delay: 200,
                                      child: buildInfoCard(
                                        // Menggunakan helper dari file style
                                        icon: Icons.format_quote_rounded,
                                        color: const Color(0xFFFF9500),
                                        title: "Quote",
                                        content:
                                            quotes[DateTime.now().day %
                                                quotes.length],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: buildAnimatedCard(
                                      // Menggunakan helper dari file style
                                      delay: 250,
                                      child: buildInfoCard(
                                        // Menggunakan helper dari file style
                                        icon: Icons.tips_and_updates_rounded,
                                        color: const Color(0xFF34C759),
                                        title: "Tips",
                                        content:
                                            tips[DateTime.now().weekday %
                                                tips.length],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 28),

                              // Schedule Header
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Jadwal Hari Ini",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: isDarkMode
                                          ? Colors.white
                                          : const Color(0xFF1C1C1E),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ScheduleScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Lihat Semua",
                                      style: TextStyle(
                                        color: const Color(0xFF5E92F3),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),

                              // Schedule List
                              ...List.generate(dailySchedule.length, (index) {
                                final item = dailySchedule[index];
                                return buildAnimatedCard(
                                  // Menggunakan helper dari file style
                                  delay: 300 + (index * 50),
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 12),
                                    decoration: BoxDecoration(
                                      color: isDarkMode
                                          ? const Color(0xFF1C1C1E)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(
                                            isDarkMode ? 0.3 : 0.05,
                                          ),
                                          blurRadius: 12,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(20),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailScheduleScreen(
                                                    scheduleItem: item,
                                                    index:
                                                        index, // Kirim index untuk fungsi Hapus di Detail
                                                    deleteCallback:
                                                        refreshDashboardSchedule,
                                                  ),
                                            ),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(
                                                  12,
                                                ),
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      const Color(
                                                        0xFF5E92F3,
                                                      ).withOpacity(0.2),
                                                      const Color(
                                                        0xFF4DD0E1,
                                                      ).withOpacity(0.2),
                                                    ],
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                ),
                                                child: Icon(
                                                  item["icon"],
                                                  color: const Color(
                                                    0xFF5E92F3,
                                                  ),
                                                  size: 22,
                                                ),
                                              ),
                                              const SizedBox(width: 14),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      item["activity"]!,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: isDarkMode
                                                            ? Colors.white
                                                            : const Color(
                                                                0xFF1C1C1E,
                                                              ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      item["time"]!,
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        color: isDarkMode
                                                            ? const Color(
                                                                0xFF8E8E93,
                                                              )
                                                            : const Color(
                                                                0xFF6E6E73,
                                                              ),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size: 16,
                                                color: isDarkMode
                                                    ? const Color(0xFF8E8E93)
                                                    : const Color(0xFF6E6E73),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),

                              const SizedBox(height: 20),

                              // Footer
                              Center(
                                child: Text(
                                  "© 2025 Avera by Verenada",
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? const Color(0xFF8E8E93)
                                        : const Color(0xFF6E6E73),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
