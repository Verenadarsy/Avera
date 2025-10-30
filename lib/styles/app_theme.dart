import 'package:flutter/material.dart';
import '../screens/dashboard.dart'; // Import DashboardScreenState untuk isDarkMode

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
  final isDarkMode = DashboardScreenState.getDarkMode;

  // Warna dinamis
  final contentColor = isDarkMode ? Colors.white : const Color(0xFF1C1C1E);
  final subtextColor = isDarkMode
      ? const Color(0xFF8E8E93)
      : const Color(0xFF6E6E73);

  return Container(
    height: 180,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: isDarkMode ? const Color(0xFF1C1C1E) : Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.05),
          blurRadius: 12,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: subtextColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Text(
            content,
            style: TextStyle(
              fontSize: 13,
              color: contentColor,
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
