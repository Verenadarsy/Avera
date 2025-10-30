// lib/data/data_berita.dart
import '../models/berita.dart';

final List<Berita> daftarBerita = [
  Berita(
    id: '1',
    judul: 'OpenAI mengumumkan platform untuk membuat ChatGPT kustom',
    snippet:
        'OpenAI telah mengumumkan platform baru untuk membuat AI kustom...',
    kontenLengkap:
        'Tuliskan teks konten lengkap (panjang) di sini. Ini harus bersifat statis (data tidak perlu disimpan ke database)[cite: 19]. Teks ini akan dilihat di halaman detail.',
    sumber: 'The Verge',
    tanggal: '2023/11/17',
    imageUrl: 'https://picsum.photos/id/237/200/200',
  ),
  Berita(
    id: '2',
    judul: 'Program panda Kebun Binatang Nasional berakhir',
    snippet:
        'Tiga pasang panda raksasa akan kembali ke China setelah program pinjaman berakhir...',
    kontenLengkap:
        'Tuliskan teks konten lengkap (panjang) di sini. Ini harus bersifat statis. Pastikan Anda memiliki pola tampilan yang berulang[cite: 38].',
    sumber: 'CNN',
    tanggal: '2023/11/17',
    imageUrl: 'https://picsum.photos/id/200/200/200',
  ),
  Berita(
    id: '3',
    judul: 'Tren Mobile Development 2025: Fokus pada Performansi dan UI/UX',
    snippet:
        'Perkembangan terbaru menunjukkan bahwa optimasi performa dan desain yang cantik menjadi kunci utama...',
    kontenLengkap:
        'Ini adalah isi lengkap berita ketiga. Terus kembangkan aplikasi berbasis mobile Anda[cite: 13]!',
    sumber: 'ITENAS Journal',
    tanggal: '2025/10/29',
    imageUrl: 'https://picsum.photos/id/10/200/200',
  ),
  // Tambahkan berita statis lainnya di sini...
];
