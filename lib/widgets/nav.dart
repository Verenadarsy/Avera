import 'package:flutter/material.dart';
import '../screens/dashboard.dart';
import '../screens/cuaca.dart';
import '../screens/kalkulator.dart';
import '../screens/berita.dart';
import '../screens/biodata.dart';
import '../screens/kontak.dart';

class Nav extends StatefulWidget {
  const Nav({super.key});

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;

  // daftar halaman
  final List<Widget> _screens = const [
    DashboardScreen(),
    CuacaScreen(),
    KalkulatorScreen(),
    BeritaScreen(),
    BiodataScreen(),
    KontakScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = DashboardScreenState.getDarkMode;

    return Scaffold(
      extendBody: true, // <— ini WAJIB kalau mau efek “melayang”
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white, // solid!
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 30,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavButton(Icons.home_outlined, Icons.home, 0, isDarkMode),
            _buildNavButton(Icons.cloud_outlined, Icons.cloud, 1, isDarkMode),
            _buildNavButton(
              Icons.calculate_outlined,
              Icons.calculate,
              2,
              isDarkMode,
            ),
            _buildNavButton(
              Icons.article_outlined,
              Icons.article,
              3,
              isDarkMode,
            ),
            _buildNavButton(Icons.person_outline, Icons.person, 4, isDarkMode),
            _buildNavButton(
              Icons.contacts_outlined,
              Icons.contacts,
              5,
              isDarkMode,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton(
    IconData inactiveIcon,
    IconData activeIcon,
    int index,
    bool isDarkMode,
  ) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          // efek bulat glow hanya untuk icon aktif
          gradient: isSelected
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDarkMode
                      ? [const Color(0xFF60D5FD), const Color(0xFF4A90E2)]
                      : [const Color(0xFF4A90E2), const Color(0xFF60D5FD)],
                )
              : null,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: isDarkMode
                        ? const Color(0xFF60D5FD).withValues(alpha: 0.4)
                        : const Color(0xFF4A90E2).withValues(alpha: 0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Icon(
          isSelected ? activeIcon : inactiveIcon,
          color: isSelected
              ? Colors.white
              : isDarkMode
              ? Colors.grey.shade500
              : Colors.grey.shade400,
          size: 26,
        ),
      ),
    );
  }
}
