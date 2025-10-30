// lib/screens/schedule_screen.dart

import 'package:flutter/material.dart';
import '../data/data_schedule.dart';
import '../styles/app_theme.dart';
import 'dashboard.dart';
import 'detail_schedule_screen.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _addScheduleItem() {
    final timeController = TextEditingController();
    final activityController = TextEditingController();
    final isDarkMode = DashboardScreenState.getDarkMode;
    final theme = AppTheme.getTheme(isDarkMode);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: theme.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.darkBlueMedium.withValues(alpha: 0.3),
                      AppTheme.darkCyan.withValues(alpha: 0.3),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.add_circle_outline_rounded,
                  color: AppTheme.darkCyan,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "Tambah Jadwal Baru",
                  style: TextStyle(
                    color: theme.textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: timeController,
                style: TextStyle(color: theme.textColor),
                decoration: InputDecoration(
                  labelText: "Waktu (HH.MM)",
                  labelStyle: TextStyle(color: theme.subtextColor),
                  prefixIcon: Icon(
                    Icons.access_time_rounded,
                    color: AppTheme.darkBlueMedium,
                  ),
                  filled: true,
                  fillColor: isDarkMode
                      ? const Color(0xFF0A0E27)
                      : const Color(0xFFF8F9FE),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: AppTheme.darkBlueMedium,
                      width: 2,
                    ),
                  ),
                ),
                keyboardType: TextInputType.datetime,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: activityController,
                style: TextStyle(color: theme.textColor),
                decoration: InputDecoration(
                  labelText: "Aktivitas",
                  labelStyle: TextStyle(color: theme.subtextColor),
                  prefixIcon: Icon(
                    Icons.event_note_rounded,
                    color: AppTheme.darkCyan,
                  ),
                  filled: true,
                  fillColor: isDarkMode
                      ? const Color(0xFF0A0E27)
                      : const Color(0xFFF8F9FE),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppTheme.darkCyan, width: 2),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                foregroundColor: theme.subtextColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
              child: const Text(
                "Batal",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.darkBlueMedium, AppTheme.darkCyan],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ElevatedButton(
                onPressed: () {
                  if (timeController.text.isNotEmpty &&
                      activityController.text.isNotEmpty) {
                    setState(() {
                      dailySchedule.add({
                        "time": timeController.text,
                        "activity": activityController.text,
                        "icon": Icons.event,
                      });
                    });
                    Navigator.pop(context);
                    _showCustomSnackBar("Jadwal baru ditambahkan! ✨");
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Tambah",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _deleteScheduleItem(int index) {
    setState(() {
      dailySchedule.removeAt(index);
    });
    _showCustomSnackBar("Jadwal dihapus");
  }

  void _showCustomSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.check_circle_rounded,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              message,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ],
        ),
        backgroundColor: AppTheme.accentGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = DashboardScreenState.getDarkMode;
    final theme = AppTheme.getTheme(isDarkMode);

    return Scaffold(
      backgroundColor: theme.bgColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // App Bar dengan gradient
          SliverAppBar(
            expandedHeight: 160,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.add_circle_outline_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                    onPressed: _addScheduleItem,
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: theme.gradientColors,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(
                                Icons.calendar_today_rounded,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Semua Jadwal",
                                    style: AppTheme.headerTitleStyle,
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
              ),
            ),
          ),

          // Content
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: dailySchedule.isEmpty
                ? SliverFillRemaining(child: _buildEmptyState(theme))
                : SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return buildAnimatedCard(
                        delay: index * 50,
                        child: _buildScheduleItem(
                          dailySchedule[index],
                          index,
                          theme,
                        ),
                      );
                    }, childCount: dailySchedule.length),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(AppThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.darkBlueMedium.withValues(alpha: 0.2),
                  AppTheme.darkCyan.withValues(alpha: 0.2),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.event_busy_rounded,
              size: 80,
              color: AppTheme.darkCyan,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            "Belum Ada Jadwal",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: theme.textColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Tap tombol + di atas untuk menambah jadwal",
            style: TextStyle(fontSize: 14, color: theme.subtextColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleItem(
    Map<String, dynamic> item,
    int index,
    AppThemeData theme,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: AppTheme.cardDecoration(
        cardColor: theme.cardColor,
        isDarkMode: theme.bgColor == const Color(0xFF0A0E27),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScheduleScreen(
                  scheduleItem: item,
                  index: index,
                  deleteCallback: _deleteScheduleItem,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: AppTheme.scheduleCardGradient(
                        theme.bgColor == const Color(0xFF0A0E27),
                      ),
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(item["icon"], color: AppTheme.darkCyan, size: 26),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item["activity"]!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: theme.textColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 14,
                            color: theme.subtextColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            item["time"]!,
                            style: TextStyle(
                              fontSize: 13,
                              color: theme.subtextColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.bgColor == const Color(0xFF0A0E27)
                        ? Colors.white.withValues(alpha: 0.05)
                        : Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: theme.subtextColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
