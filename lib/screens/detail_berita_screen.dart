// lib/screens/detail_berita_screen.dart
import 'package:flutter/material.dart';
import '../models/berita.dart';

class DetailBeritaScreen extends StatelessWidget {
  final Berita berita;

  const DetailBeritaScreen({Key? key, required this.berita}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(berita.sumber),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Judul Berita
            Text(
              berita.judul,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            // Informasi Sumber/Tanggal
            Text(
              '${berita.sumber} - ${berita.tanggal}',
              style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
            ),
            Divider(height: 20),
            // Gambar Utama Berita
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                berita.imageUrl,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
              ),
            ),
            Divider(height: 20),
            // Konten Lengkap Berita
            Text(
              berita.kontenLengkap,
              style: TextStyle(fontSize: 16.0, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
