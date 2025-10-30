import 'package:flutter/material.dart';

class BiodataScreen extends StatelessWidget {
  const BiodataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    final bgColor = isDarkMode
        ? const Color(0xFF121212)
        : const Color(0xFFF5F5F5);
    final cardColor = isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final subTextColor = isDarkMode ? Colors.white70 : Colors.black54;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('Biodata'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Foto Profil
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withValues(alpha: 0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white,
                backgroundImage: const AssetImage('assets/images/Profile.jpg'),
              ),
            ),
            const SizedBox(height: 20),

            // Nama dan Deskripsi Singkat
            Text(
              'Verenada Arsy Mardatillah',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Mahasiswa Informatika - Institut Teknologi Nasional Bandung',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: subTextColor),
            ),
            const SizedBox(height: 20),

            // Informasi Utama
            _buildInfoCard(
              title: 'Informasi Pribadi',
              icon: Icons.person_outline,
              content: [
                _buildInfoRow('Nama Lengkap', 'Verenada Arsy Mardatillah'),
                _buildInfoRow('NIM', '152023058'),
                _buildInfoRow('Tempat, Tanggal Lahir', 'Bandung, 6 Juni 2005'),
                _buildInfoRow('Alamat', 'Jl. Cikutra No. 89, Bandung'),
              ],
              cardColor: cardColor,
              textColor: textColor,
              subTextColor: subTextColor,
            ),

            _buildInfoCard(
              title: 'Kontak & Sosial',
              icon: Icons.contact_page_outlined,
              content: [
                _buildInfoRow('Email', 'verenada@example.com'),
                _buildInfoRow('Nomor Telepon', '+62 812-3456-789'),
                _buildInfoRow('Instagram', '@verenada.arsy'),
                _buildInfoRow('GitHub', 'github.com/verenada'),
              ],
              cardColor: cardColor,
              textColor: textColor,
              subTextColor: subTextColor,
            ),

            _buildInfoCard(
              title: 'Pendidikan',
              icon: Icons.school_outlined,
              content: [
                _buildInfoRow(
                  'Universitas',
                  'Institut Teknologi Nasional Bandung',
                ),
                _buildInfoRow('Program Studi', 'Teknik Informatika'),
                _buildInfoRow('Semester', '4'),
              ],
              cardColor: cardColor,
              textColor: textColor,
              subTextColor: subTextColor,
            ),

            _buildInfoCard(
              title: 'Tentang Saya',
              icon: Icons.favorite_outline,
              content: [
                _buildText(
                  'Saya adalah mahasiswa Informatika yang suka menjelajahi hal baru di dunia teknologi. '
                  'Bersemangat dalam belajar pengembangan aplikasi dan desain antarmuka, '
                  'serta selalu mencoba hal-hal kreatif di setiap proyek yang saya kerjakan. ✨',
                  subTextColor,
                ),
              ],
              cardColor: cardColor,
              textColor: textColor,
              subTextColor: subTextColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required IconData icon,
    required List<Widget> content,
    required Color cardColor,
    required Color textColor,
    required Color subTextColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.blueAccent),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ],
          ),
          const Divider(height: 25, thickness: 1),
          ...content,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  Widget _buildText(String text, Color color) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: TextStyle(fontSize: 14, color: color, height: 1.5),
    );
  }
}
