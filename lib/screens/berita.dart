// lib/screens/berita.dart
import 'package:flutter/material.dart';
import '../data/data_berita.dart'; // Import data statis
import 'detail_berita_screen.dart'; // Import halaman detail

class BeritaScreen extends StatelessWidget {
  const BeritaScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Berita (Fragment)'),
        backgroundColor: Colors.purple, // Sesuaikan dengan tema Avera Anda
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: daftarBerita.length,
        itemBuilder: (context, index) {
          final berita = daftarBerita[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: InkWell(
              onTap: () {
                // Navigasi ke Halaman Detail Berita
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailBeritaScreen(berita: berita),
                  ),
                );
              },
              // Layout item yang berulang (mirip halaman kontak) [cite: 38]
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Gambar Berita
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      berita.imageUrl,
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 12),
                  // Teks Berita
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          berita.judul,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          berita.snippet,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${berita.sumber} | ${berita.tanggal}',
                          style: TextStyle(fontSize: 12.0, color: Colors.grey),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
