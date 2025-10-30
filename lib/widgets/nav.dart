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
    // Mengambil status dark mode dari DashboardScreen
    final isDarkMode = DashboardScreenState.getDarkMode;

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          selectedItemColor: isDarkMode
              ? Colors.blue.shade300
              : Colors.blue.shade700,
          unselectedItemColor: isDarkMode
              ? Colors.grey.shade600
              : Colors.grey.shade400,
          showUnselectedLabels: true,
          elevation: 0,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cloud_outlined),
              activeIcon: Icon(Icons.cloud),
              label: 'Cuaca',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calculate_outlined),
              activeIcon: Icon(Icons.calculate),
              label: 'Kalkulator',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.article_outlined),
              activeIcon: Icon(Icons.article),
              label: 'Berita',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Biodata',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contacts_outlined),
              activeIcon: Icon(Icons.contacts),
              label: 'Kontak',
            ),
          ],
        ),
      ),
    );
  }
}
