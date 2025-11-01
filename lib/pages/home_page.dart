// lib/pages/home_page.dart

import 'package:flutter/material.dart';
import 'package:umsida_profil/pages/fakultas_page.dart';
import 'package:umsida_profil/pages/kontak_page.dart';
import 'package:umsida_profil/pages/visi_misi_page.dart';
import 'package:umsida_profil/utils/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar sesuai mockup
      appBar: AppBar(
        title: const Text('Profil Universitas Muhammadiyah Sidoarjo'),
        backgroundColor: AppColors.primaryBlue,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 19,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Kotak besar untuk gambar
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    // Menggunakan gambar gedung UMSIDA
                    image: AssetImage('assets/images/umsida-gedung.jpg'),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      // DIPERBAIKI: Menggunakan withAlpha untuk performa
                      color: Colors.black.withAlpha(51), // 0.2 opacity
                      blurRadius: 6,
                      // DIPERBAIKI: Menambahkan const
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
              ),

              // DIPERBAIKI: Menambahkan const
              const SizedBox(height: 24),

              // Teks "Selamat datang"
              const Text(
                "Selamat datang di",
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.primaryBlue,
                ),
              ),
              const Text(
                "Universitas Muhammadiyah Sidoarjo",
                textAlign: TextAlign.center,
                // DIPERBAIKI: Menambahkan const
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue,
                ),
              ),

              // DIPERBAIKI: Menambahkan const
              const SizedBox(height: 32),

              // Tombol 1: Visi & Misi (Warna Emas)
              _buildNavButton(
                context: context,
                text: 'Visi & Misi',
                backgroundColor: AppColors.primaryGold,
                foregroundColor: AppColors.primaryBlue,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VisiMisiPage(),
                    ),
                  );
                },
              ),

              // DIPERBAIKI: Menambahkan const
              const SizedBox(height: 16),

              // Tombol 2: Daftar Fakultas
              _buildNavButton(
                context: context,
                text: 'Daftar Fakultas',
                // Sesuai mockup (tombol outline)
                backgroundColor: AppColors.primaryGold,
                foregroundColor: AppColors.primaryBlue,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FakultasPage(),
                    ),
                  );
                },
              ),

              // DIPERBAIKI: Menambahkan const
              const SizedBox(height: 16),

              // Tombol 3: Kontak & Lokasi
              _buildNavButton(
                context: context,
                text: 'Kontak & Lokasi',
                // Sesuai mockup (tombol outline)
                backgroundColor: AppColors.primaryGold,
                foregroundColor: AppColors.primaryBlue,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const KontakPages(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Helper widget untuk membangun tombol navigasi yang konsisten
  Widget _buildNavButton({
    required BuildContext context,
    required String text,
    required Color backgroundColor,
    required Color foregroundColor,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          // DIPERBAIKI: Menambahkan const
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
