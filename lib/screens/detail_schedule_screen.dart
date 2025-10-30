// lib/screens/detail_schedule_screen.dart

import 'package:flutter/material.dart';
import 'dashboard.dart';
import '../data/data_schedule.dart';

class DetailScheduleScreen extends StatefulWidget {
  final Map<String, dynamic> scheduleItem;
  final int index;
  final Function(int) deleteCallback;

  const DetailScheduleScreen({
    super.key,
    required this.scheduleItem,
    required this.index,
    required this.deleteCallback,
  });

  @override
  State<DetailScheduleScreen> createState() => _DetailScheduleScreenState();
}

class _DetailScheduleScreenState extends State<DetailScheduleScreen>
    with SingleTickerProviderStateMixin {
  late Map<String, dynamic> _currentItem;
  late AnimationController _animationController;
  IconData _selectedIcon = Icons.event;

  @override
  void initState() {
    super.initState();
    _currentItem = Map.from(widget.scheduleItem);
    _selectedIcon = _currentItem['icon'] ?? Icons.event;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startEdit() {
    final timeController = TextEditingController(text: _currentItem['time']);
    final activityController = TextEditingController(
      text: _currentItem['activity'],
    );
    final descriptionController = TextEditingController(
      text: _currentItem['description'] ?? '',
    );

    final isDarkMode = DashboardScreenState.getDarkMode;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xFF1C1C1E) : Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle bar
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? Colors.white.withValues(alpha: 0.3)
                          : Colors.black.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Title
                Text(
                  "Edit Jadwal",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : const Color(0xFF1C1C1E),
                  ),
                ),
                const SizedBox(height: 24),

                // Icon Picker
                Text(
                  "Pilih Icon",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode
                        ? const Color(0xFF8E8E93)
                        : const Color(0xFF6E6E73),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 70,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildIconOption(
                        Icons.school_rounded,
                        setModalState,
                        isDarkMode,
                      ),
                      _buildIconOption(
                        Icons.work_rounded,
                        setModalState,
                        isDarkMode,
                      ),
                      _buildIconOption(
                        Icons.sports_esports_rounded,
                        setModalState,
                        isDarkMode,
                      ),
                      _buildIconOption(
                        Icons.restaurant_rounded,
                        setModalState,
                        isDarkMode,
                      ),
                      _buildIconOption(
                        Icons.fitness_center_rounded,
                        setModalState,
                        isDarkMode,
                      ),
                      _buildIconOption(
                        Icons.music_note_rounded,
                        setModalState,
                        isDarkMode,
                      ),
                      _buildIconOption(
                        Icons.book_rounded,
                        setModalState,
                        isDarkMode,
                      ),
                      _buildIconOption(Icons.event, setModalState, isDarkMode),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Time Input
                TextField(
                  controller: timeController,
                  decoration: InputDecoration(
                    labelText: "Waktu",
                    hintText: "Contoh: 08.00",
                    prefixIcon: const Icon(
                      Icons.access_time_rounded,
                      color: Color(0xFF4DD0E1),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: isDarkMode
                            ? Colors.white.withValues(alpha: 0.2)
                            : Colors.black.withValues(alpha: 0.1),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: isDarkMode
                            ? Colors.white.withValues(alpha: 0.2)
                            : Colors.black.withValues(alpha: 0.1),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color(0xFF4DD0E1),
                        width: 2,
                      ),
                    ),
                    filled: true,
                    fillColor: isDarkMode
                        ? Colors.white.withValues(alpha: 0.05)
                        : Colors.black.withValues(alpha: 0.02),
                  ),
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : const Color(0xFF1C1C1E),
                  ),
                  keyboardType: TextInputType.datetime,
                ),
                const SizedBox(height: 16),

                // Activity Input
                TextField(
                  controller: activityController,
                  decoration: InputDecoration(
                    labelText: "Aktivitas",
                    hintText: "Masukkan aktivitas",
                    prefixIcon: const Icon(
                      Icons.edit_rounded,
                      color: Color(0xFF4DD0E1),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: isDarkMode
                            ? Colors.white.withValues(alpha: 0.2)
                            : Colors.black.withValues(alpha: 0.1),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: isDarkMode
                            ? Colors.white.withValues(alpha: 0.2)
                            : Colors.black.withValues(alpha: 0.1),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color(0xFF4DD0E1),
                        width: 2,
                      ),
                    ),
                    filled: true,
                    fillColor: isDarkMode
                        ? Colors.white.withValues(alpha: 0.05)
                        : Colors.black.withValues(alpha: 0.02),
                  ),
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : const Color(0xFF1C1C1E),
                  ),
                ),
                const SizedBox(height: 16),

                // Description Input
                TextField(
                  controller: descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: "Deskripsi (Opsional)",
                    hintText: "Tambahkan catatan atau detail...",
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(bottom: 50),
                      child: Icon(
                        Icons.description_rounded,
                        color: Color(0xFF4DD0E1),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: isDarkMode
                            ? Colors.white.withValues(alpha: 0.2)
                            : Colors.black.withValues(alpha: 0.1),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: isDarkMode
                            ? Colors.white.withValues(alpha: 0.2)
                            : Colors.black.withValues(alpha: 0.1),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color(0xFF4DD0E1),
                        width: 2,
                      ),
                    ),
                    filled: true,
                    fillColor: isDarkMode
                        ? Colors.white.withValues(alpha: 0.05)
                        : Colors.black.withValues(alpha: 0.02),
                  ),
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : const Color(0xFF1C1C1E),
                  ),
                ),
                const SizedBox(height: 24),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          side: BorderSide(
                            color: isDarkMode
                                ? Colors.white.withValues(alpha: 0.2)
                                : Colors.black.withValues(alpha: 0.1),
                          ),
                        ),
                        child: Text(
                          "Batal",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isDarkMode
                                ? Colors.white
                                : const Color(0xFF1C1C1E),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () {
                          if (timeController.text.isNotEmpty &&
                              activityController.text.isNotEmpty) {
                            setState(() {
                              dailySchedule[widget.index]['time'] =
                                  timeController.text;
                              dailySchedule[widget.index]['activity'] =
                                  activityController.text;
                              dailySchedule[widget.index]['description'] =
                                  descriptionController.text;
                              dailySchedule[widget.index]['icon'] =
                                  _selectedIcon;
                              _currentItem = dailySchedule[widget.index];
                            });
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                  "Jadwal berhasil diperbarui!",
                                ),
                                backgroundColor: const Color(0xFF34C759),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4DD0E1),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Simpan",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconOption(
    IconData icon,
    StateSetter setModalState,
    bool isDarkMode,
  ) {
    final isSelected = _selectedIcon == icon;
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: () {
          setModalState(() {
            _selectedIcon = icon;
          });
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            gradient: isSelected
                ? const LinearGradient(
                    colors: [Color(0xFF42A5F5), Color(0xFF4DD0E1)],
                  )
                : null,
            color: isSelected
                ? null
                : isDarkMode
                ? Colors.white.withValues(alpha: 0.1)
                : Colors.black.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16),
            border: isSelected
                ? null
                : Border.all(
                    color: isDarkMode
                        ? Colors.white.withValues(alpha: 0.2)
                        : Colors.black.withValues(alpha: 0.1),
                  ),
          ),
          child: Icon(
            icon,
            color: isSelected
                ? Colors.white
                : isDarkMode
                ? Colors.white
                : const Color(0xFF1C1C1E),
            size: 28,
          ),
        ),
      ),
    );
  }

  void _confirmDelete() {
    final isDarkMode = DashboardScreenState.getDarkMode;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1C1C1E) : Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? Colors.white.withValues(alpha: 0.3)
                      : Colors.black.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),

              // Icon
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF3B30).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.delete_forever_rounded,
                  color: Color(0xFFFF3B30),
                  size: 48,
                ),
              ),
              const SizedBox(height: 20),

              // Title
              Text(
                "Hapus Jadwal?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : const Color(0xFF1C1C1E),
                ),
              ),
              const SizedBox(height: 8),

              // Message
              Text(
                "Jadwal yang dihapus tidak dapat dikembalikan",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: isDarkMode
                      ? const Color(0xFF8E8E93)
                      : const Color(0xFF6E6E73),
                ),
              ),
              const SizedBox(height: 24),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        side: BorderSide(
                          color: isDarkMode
                              ? Colors.white.withValues(alpha: 0.2)
                              : Colors.black.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Text(
                        "Batal",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode
                              ? Colors.white
                              : const Color(0xFF1C1C1E),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.deleteCallback(widget.index);
                        Navigator.pop(context); // Close modal
                        Navigator.pop(context); // Back to schedule screen
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF3B30),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Hapus",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = DashboardScreenState.getDarkMode;

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
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.edit_rounded,
                              color: Colors.white,
                            ),
                            onPressed: _startEdit,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFFFF3B30,
                            ).withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.delete_forever_rounded,
                              color: Colors.white,
                            ),
                            onPressed: _confirmDelete,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Title
                    const Text(
                      "Detail Jadwal",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              // Content Section
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
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    physics: const BouncingScrollPhysics(),
                    child: FadeTransition(
                      opacity: _animationController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Icon Card
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(32),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF42A5F5), Color(0xFF4DD0E1)],
                              ),
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF4DD0E1,
                                  ).withValues(alpha: 0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    _currentItem["icon"],
                                    color: Colors.white,
                                    size: 64,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  _currentItem["activity"]!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Time Card
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? const Color(0xFF1C1C1E)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(
                                    alpha: isDarkMode ? 0.3 : 0.05,
                                  ),
                                  blurRadius: 12,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF42A5F5),
                                        Color(0xFF4DD0E1),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: const Icon(
                                    Icons.access_time_rounded,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Waktu",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: isDarkMode
                                              ? const Color(0xFF8E8E93)
                                              : const Color(0xFF6E6E73),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        _currentItem["time"]!,
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: isDarkMode
                                              ? Colors.white
                                              : const Color(0xFF1C1C1E),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Description Card (if exists)
                          if (_currentItem["description"] != null &&
                              _currentItem["description"]!.isNotEmpty)
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: isDarkMode
                                    ? const Color(0xFF1C1C1E)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(
                                      alpha: isDarkMode ? 0.3 : 0.05,
                                    ),
                                    blurRadius: 12,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: const Color(
                                            0xFF4DD0E1,
                                          ).withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.description_rounded,
                                          color: Color(0xFF4DD0E1),
                                          size: 24,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        "Deskripsi",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: isDarkMode
                                              ? Colors.white
                                              : const Color(0xFF1C1C1E),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    _currentItem["description"]!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: isDarkMode
                                          ? const Color(0xFF8E8E93)
                                          : const Color(0xFF6E6E73),
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(height: 16),

                          // Info Card
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? const Color(0xFF1C1C1E)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(
                                    alpha: isDarkMode ? 0.3 : 0.05,
                                  ),
                                  blurRadius: 12,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: const Color(
                                          0xFF4DD0E1,
                                        ).withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Icon(
                                        Icons.info_outline_rounded,
                                        color: Color(0xFF4DD0E1),
                                        size: 24,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      "Informasi",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: isDarkMode
                                            ? Colors.white
                                            : const Color(0xFF1C1C1E),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  "Tap tombol edit untuk mengubah jadwal ini atau tombol hapus untuk menghapusnya.",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: isDarkMode
                                        ? const Color(0xFF8E8E93)
                                        : const Color(0xFF6E6E73),
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
