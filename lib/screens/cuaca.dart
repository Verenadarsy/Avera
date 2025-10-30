// lib/screens/cuaca.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class CuacaScreen extends StatefulWidget {
  const CuacaScreen({super.key});

  @override
  State<CuacaScreen> createState() => CuacaScreenState();
}

class CuacaScreenState extends State<CuacaScreen> {
  final String apiKey = "e5295007b898831a81e4428a5c77bd83";

  final String latitude = "-6.89664677209633";
  final String longitude = "107.63697236972254";
  final String locationName = "ITENAS/Lokasi Anda";

  static Map<String, dynamic>? weatherData;
  bool isLoading = true;

  static int? getCurrentTemp() {
    if (weatherData == null || weatherData!['main'] == null) {
      return null;
    }

    return (weatherData!['main']['temp'] as num).round();
  }

  static String getCurrentCondition() {
    if (weatherData == null ||
        weatherData!['weather'] == null ||
        weatherData!['weather'].isEmpty) {
      return "memuat...";
    }
    return (weatherData!['weather'][0]['description'] as String);
  }

  String _capitalize(String s) =>
      s.isNotEmpty ? s[0].toUpperCase() + s.substring(1) : s;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID', null).then((_) {
      _fetchWeather();
    });
  }

  Future<void> _fetchWeather() async {
    if (mounted) {
      setState(() => isLoading = true);
    }

    try {
      // PERUBAHAN UTAMA: Menggunakan Lat & Lon di URL
      final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&units=metric&lang=id&appid=$apiKey',
      );
      final res = await http.get(url);

      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        if (body != null && body is Map<String, dynamic>) {
          setState(() {
            weatherData = body; // Menyimpan ke variabel statis
            isLoading = false;
          });
        } else {
          throw Exception("Response tidak valid");
        }
      } else {
        throw Exception("Gagal mengambil data cuaca (code ${res.statusCode})");
      }
    } catch (e) {
      debugPrint("Error: $e");
      if (mounted) {
        setState(() {
          weatherData = null; // Set null jika error
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        title: Text("Cuaca di $locationName"),
        backgroundColor: Colors.blueGrey.shade800,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _fetchWeather),
        ],
      ),
      body: isLoading
          ? _buildLoading()
          : weatherData == null
          ? const Center(
              child: Text(
                "Gagal memuat data cuaca 😞",
                style: TextStyle(color: Colors.white70),
              ),
            )
          : _buildWeatherContent(),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Colors.lightBlueAccent),
          SizedBox(height: 20),
          Text(
            "Mengambil data cuaca...",
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherContent() {
    if (weatherData == null ||
        weatherData!['main'] == null ||
        weatherData!['weather'] == null ||
        weatherData!['wind'] == null) {
      return const Center(
        child: Text(
          "Data cuaca belum tersedia 😞",
          style: TextStyle(color: Colors.white70),
        ),
      );
    }

    final main = weatherData!['main'];
    final weather = weatherData!['weather'][0];
    final wind = weatherData!['wind'];

    // Menggunakan getter statis
    final temp = getCurrentTemp()!;
    final feelsLike = main['feels_like'].round();
    final condition = _capitalize(weather['description']);
    final humidity = main['humidity'];
    final windSpeed = wind['speed'];

    return RefreshIndicator(
      onRefresh: _fetchWeather,
      color: Colors.blueAccent,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  locationName,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  DateFormat(
                    'EEEE, d MMMM yyyy',
                    'id_ID',
                  ).format(DateTime.now()),
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 20),
                Icon(
                  _getWeatherIcon(weather['main']),
                  size: 100,
                  color: Colors.amberAccent,
                ),
                const SizedBox(height: 10),
                Text(
                  "$temp°C",
                  style: const TextStyle(
                    fontSize: 70,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  condition.toUpperCase(),
                  style: const TextStyle(fontSize: 18, color: Colors.white70),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade800,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildInfoRow("Terasa seperti", "$feelsLike°C"),
                      _buildInfoRow("Kelembapan", "$humidity%"),
                      _buildInfoRow("Kecepatan Angin", "$windSpeed m/s"),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  "Diperbarui: ${DateFormat('HH:mm:ss').format(DateTime.now())}",
                  style: const TextStyle(color: Colors.white54, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70)),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return Icons.wb_sunny;
      case 'clouds':
        return Icons.cloud;
      case 'rain':
        return Icons.grain;
      case 'thunderstorm':
        return Icons.flash_on;
      case 'snow':
        return Icons.ac_unit;
      default:
        return Icons.wb_cloudy;
    }
  }
}
