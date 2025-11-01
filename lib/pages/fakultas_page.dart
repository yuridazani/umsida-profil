// fakultas_page.dart
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class FakultasPage extends StatelessWidget {
  const FakultasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Fakultas'),
        backgroundColor: AppColors.primaryBlue,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 20),
          _buildFakultasCard(
            icon: Icons.engineering,
            title: 'Fakultas Teknik',
            description:
                'Jurusan: Informatika, Teknik Elektro, Teknik Industri, Teknik Mesin, Teknik Sipil, Agroteknologi, Teknologi Pangan.',
          ),
          const SizedBox(height: 15),
          _buildFakultasCard(
            icon: Icons.business_center,
            title: 'Fakultas Hukum, Ekonomi dan Bisnis',
            description:
                'Jurusan: Manajemen, Akuntansi, Ekonomi Pembangunan, Bisnis Digital, Hukum, Administrasi Publik, Ilmu Komunikasi.',
          ),
          const SizedBox(height: 15),
          _buildFakultasCard(
            icon: Icons.health_and_safety,
            title: 'Fakultas Kesehatan',
            description: 'Jurusan: Kedokteran, Kebidanan, Laboratorium Medik.',
          ),
          const SizedBox(height: 15),
          _buildFakultasCard(
            icon: Icons.mosque,
            title: 'Fakultas Agama Islam',
            description:
                'Jurusan: Pendidikan Agama Islam, Bahasa Arab, Perbankan Syariah.',
          ),
          const SizedBox(height: 15),
          _buildFakultasCard(
            icon: Icons.psychology,
            title: 'Fakultas Psikologi dan Ilmu Pendidikan',
            description:
                'Jurusan: Psikologi, Pendidikan Dasar, PGSD, PG-PAUD, Pendidikan IPA, Pendidikan Bahasa Inggris.',
          ),
        ],
      ),
    );
  }

  Widget _buildFakultasCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primaryBlue, size: 60),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
