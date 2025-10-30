import 'package:flutter/material.dart';
import '../screens/dashboard.dart';

// ==================== THEME DATA CLASS ====================
class AppThemeData {
  final Color bgColor;
  final Color cardColor;
  final Color textColor;
  final Color subtextColor;
  final List<Color> gradientColors;

  AppThemeData({
    required this.bgColor,
    required this.cardColor,
    required this.textColor,
    required this.subtextColor,
    required this.gradientColors,
  });
}

// ==================== APP THEME CLASS ====================
class AppTheme {
  // --- WARNA BARU YANG DITAMBAHKAN ---

  // Light Mode Colors
  static const Color lightBlueSoft = Color(0xFF42A5F5); // Biru soft
  static const Color lightSkyBlue = Color(0xFF4FC3F7); // Sky blue
  static const Color lightCyanSoft = Color(0xFF80DEEA); // Cyan soft

  // Dark Mode Colors
  static const Color darkBlueMedium = Color(0xFF1E88E5); // Biru medium
  static const Color darkCyan = Color(0xFF26C6DA); // Cyan
  static const Color darkTurquoise = Color(0xFF4DD0E1); // Turquoise

  // Accent Colors
  static const Color accentIconCyan = Color(0xFF4FC3F7);
  static const Color accentIconSkyBlue = Color(0xFF26C6DA);
  static const Color accentIconBlue = Color(0xFF0288D1);
  static const Color accentSuccessGreen = Color(
    0xFF4CAF50,
  ); // Contoh T hijau (Hijau t)

  // ------------------------------------

  // Dark Mode Theme
  static final darkTheme = AppThemeData(
    bgColor: const Color(0xFF0A0E27),
    cardColor: const Color(0xFF1A1F3A),
    textColor: Colors.white,
    subtextColor: Colors.white70,
    // Diperbarui dengan Dark Mode Gradient: Biru medium → Cyan → Turquoise
    gradientColors: [darkBlueMedium, darkCyan, darkTurquoise],
  );

  // Light Mode Theme
  static final lightTheme = AppThemeData(
    bgColor: const Color(0xFFF8F9FE),
    cardColor: Colors.white,
    textColor: const Color(0xFF2D3142),
    subtextColor: const Color(0xFF6B7280),
    // Diperbarui dengan Light Mode Gradient: Biru soft → Sky blue → Cyan soft
    gradientColors: [lightBlueSoft, lightSkyBlue, lightCyanSoft],
  );

  static AppThemeData getTheme(bool isDarkMode) {
    return isDarkMode ? darkTheme : lightTheme;
  }

  // ==================== TEXT STYLES ====================
  static const headerTitleStyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    letterSpacing: 0.5,
  );

  static final headerSubtitleStyle = TextStyle(
    fontSize: 16,
    // Perbaikan: Ganti withValues(alpha: ...) dengan method copyWith(color: ...) atau langsung menggunakan Colors.white.withOpacity
    color: Colors.white.withValues(alpha: 0.9),
    fontWeight: FontWeight.w400,
  );

  static final headerDateStyle = TextStyle(
    fontSize: 14,
    // Perbaikan
    color: Colors.white.withValues(alpha: 0.9),
    fontWeight: FontWeight.w500,
  );

  static const timeStyle = TextStyle(
    fontSize: 52,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    letterSpacing: 3,
  );

  static final timeSubtitleStyle = TextStyle(
    fontSize: 13,
    // Perbaikan
    color: Colors.white.withValues(alpha: 0.8),
    fontWeight: FontWeight.w500,
  );

  // ==================== DECORATIONS ====================
  static BoxDecoration cardDecoration({
    required Color cardColor,
    required bool isDarkMode,
  }) {
    return BoxDecoration(
      color: cardColor,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: isDarkMode
            // Perbaikan: Ganti withValues(alpha: ...)
            ? Colors.white.withValues(alpha: 0.1)
            : Colors.grey.withValues(alpha: 0.1),
      ),
      boxShadow: [
        BoxShadow(
          color: isDarkMode
              // Perbaikan: Ganti withValues(alpha: ...)
              ? Colors.black.withValues(alpha: 0.3)
              : Colors.black.withValues(alpha: 0.05),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  static BoxDecoration gradientCardDecoration({
    required List<Color> colors,
    required bool isDarkMode,
  }) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: colors,
      ),
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          // Perbaikan: Ganti withValues(alpha: ...)
          color: colors.last.withValues(alpha: 0.3),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }

  static BoxDecoration iconContainerDecoration({required Color color}) {
    return BoxDecoration(
      // Perbaikan: Ganti withValues(alpha: ...)
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(14),
    );
  }

  static BoxDecoration gradientIconDecoration({required List<Color> colors}) {
    return BoxDecoration(
      gradient: LinearGradient(colors: colors),
      borderRadius: BorderRadius.circular(16),
    );
  }

  // ==================== SHADOWS ====================
  static List<BoxShadow> cardShadow(bool isDarkMode) {
    return [
      BoxShadow(
        color: isDarkMode
            // Perbaikan: Ganti withValues(alpha: ...)
            ? Colors.black.withValues(alpha: 0.3)
            : Colors.black.withValues(alpha: 0.05),
        blurRadius: 12,
        offset: const Offset(0, 3),
      ),
    ];
  }

  // ==================== ACCENT COLORS ====================
  // Warna Accent yang ada tetap dipertahankan
  static const accentOrange = Color(0xFFFF9800);
  static const accentPurple = Color(0xFF9C27B0);
  static const accentGreen = Color(0xFF4CAF50);
  static const accentAmber = Color(0xFFFF9800);

  // Tambahan Accent Colors baru
  static const accentIconColor = accentIconCyan;
  static const accentSuccessColor = accentSuccessGreen;

  // ==================== GRADIENTS ====================
  // Menggunakan gradient baru untuk Light dan Dark Mode
  static List<Color> timeCardGradient(bool isDarkMode) {
    return isDarkMode
        ? [
            darkBlueMedium,
            darkCyan,
          ] // Ambil 2 warna pertama dari gradient Dark Mode
        : [
            lightBlueSoft,
            lightSkyBlue,
          ]; // Ambil 2 warna pertama dari gradient Light Mode
  }

  static List<Color> scheduleCardGradient(bool isDarkMode) {
    return isDarkMode
        ? [
            darkCyan.withValues(
              alpha: 0.4,
            ), // Ambil warna ke-2 dari gradient Dark Mode dengan opacity
            darkTurquoise.withValues(
              alpha: 0.4,
            ), // Ambil warna ke-3 dari gradient Dark Mode dengan opacity
          ]
        : [
            lightSkyBlue.withValues(
              alpha: 0.3,
            ), // Ambil warna ke-2 dari gradient Light Mode dengan opacity
            lightCyanSoft.withValues(
              alpha: 0.3,
            ), // Ambil warna ke-3 dari gradient Light Mode dengan opacity
          ];
  }
}

// ==================== REUSABLE WIDGETS ====================

// Widget untuk membuat Animated Card (Digunakan untuk List Jadwal, Quote, Tip)
Widget buildAnimatedCard({required int delay, required Widget child}) {
  return TweenAnimationBuilder<double>(
    duration: Duration(milliseconds: 600 + delay),
    tween: Tween(begin: 0.0, end: 1.0),
    curve: Curves.easeOut,
    builder: (context, value, child) {
      return Transform.translate(
        offset: Offset(0, 20 * (1 - value)),
        child: Opacity(opacity: value, child: child),
      );
    },
    child: child,
  );
}

// Widget untuk membuat Info Card (Digunakan untuk Quote dan Tip)
Widget buildInfoCard({
  required IconData icon,
  required Color color,
  required String title,
  required String content,
}) {
  // Asumsi DashboardScreenState.getDarkMode tersedia
  final isDarkMode = DashboardScreenState.getDarkMode;
  final theme = AppTheme.getTheme(isDarkMode);

  return Container(
    height: 180,
    padding: const EdgeInsets.all(16),
    decoration: AppTheme.cardDecoration(
      cardColor: theme.cardColor,
      isDarkMode: isDarkMode,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            // Perbaikan: Ganti withValues(alpha: ...)
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: theme.subtextColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Text(
            content,
            style: TextStyle(
              fontSize: 13,
              color: theme.textColor,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}
