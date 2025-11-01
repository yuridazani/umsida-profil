// visi_misi_page.dart
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class VisiMisiPage extends StatelessWidget {
  const VisiMisiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Visi & Misi"),
        backgroundColor: AppColors.primaryBlue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // VISI
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Visi",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Menjadi organisasi terdepan dalam inovasi digital "
                      "untuk memberikan dampak positif bagi masyarakat.",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // MISI
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Misi",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors
                            .primaryBlue, // Fixed typo: primaryBlu -> primaryBlue
                      ),
                    ),
                    const SizedBox(height: 10),
                    _missionItem("Mengembangkan solusi teknologi inovatif."),
                    _missionItem("Meningkatkan kualitas sumber daya manusia."),
                    _missionItem(
                        "Menciptakan ekosistem yang mendukung transformasi digital."),
                    _missionItem(
                        "Memberikan layanan berkualitas dan berorientasi pengguna."),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _missionItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check, size: 20, color: AppColors.primaryBlue),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
