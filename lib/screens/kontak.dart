import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class KontakScreen extends StatelessWidget {
  const KontakScreen({super.key});

  final List<Map<String, dynamic>> contacts = const [
    {
      "name": "Verenada Arsy Mardatillah",
      "phone": "+628123456789",
      "email": "verenada@example.com",
      "image": "assets/images/Profile.jpg",
    },
    {
      "name": "Alya Putri",
      "phone": "+6281355555555",
      "email": "alya.putri@gmail.com",
      "image": null,
    },
    {
      "name": "Rizky Pratama",
      "phone": "+6285222333444",
      "email": "rizky.pratama@gmail.com",
      "image": null,
    },
    {
      "name": "Dewi Kartika",
      "phone": "+628777889900",
      "email": "dewi.kartika@yahoo.com",
      "image": null,
    },
  ];

  Future<void> _launchPhone(String number) async {
    final Uri uri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _launchMessage(String number) async {
    final Uri uri = Uri(scheme: 'sms', path: number);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text("Daftar Kontak"),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              leading: contact["image"] != null
                  ? CircleAvatar(
                      radius: 28,
                      backgroundImage: AssetImage(contact["image"]),
                    )
                  : CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.blueAccent.shade100,
                      child: Text(
                        contact["name"][0],
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
              title: Text(
                contact["name"],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    contact["phone"],
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                  ),
                  if (contact["email"] != null)
                    Text(
                      contact["email"],
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                ],
              ),
              trailing: Wrap(
                spacing: 10,
                children: [
                  IconButton(
                    icon: const Icon(Icons.call, color: Colors.green),
                    onPressed: () => _launchPhone(contact["phone"]),
                  ),
                  IconButton(
                    icon: const Icon(Icons.message, color: Colors.blueAccent),
                    onPressed: () => _launchMessage(contact["phone"]),
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
