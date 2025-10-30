// lib/models/berita.dart

class Berita {
  final String id;
  final String judul;
  final String snippet;
  final String kontenLengkap;
  final String sumber;
  final String tanggal;
  final String imageUrl;

  Berita({
    required this.id,
    required this.judul,
    required this.snippet,
    required this.kontenLengkap,
    required this.sumber,
    required this.tanggal,
    required this.imageUrl,
  });
}
