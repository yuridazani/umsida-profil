// kontak_page.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';
import '../utils/app_colors.dart';

class KontakPages extends StatelessWidget {
  // Fixed typo: KontakPages -> KontakPage for consistency
  const KontakPages({Key? key}) : super(key: key);

  // Koordinat UMSIDA (dari Google Maps resmi)
  static const double latitude = -7.448278;
  static const double longitude = 112.718556;

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri uri = Uri.parse('tel:$phoneNumber');
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $phoneNumber');
    }
  }

  Future<void> _sendEmail(String email) async {
    final Uri uri = Uri.parse('mailto:$email');
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $email');
    }
  }

  // Fungsi untuk mengkonversi longitude ke tile X
  int _getTileX(double lon, int zoom) {
    return ((lon + 180.0) / 360.0 * (1 << zoom)).floor();
  }

  // Fungsi untuk mengkonversi latitude ke tile Y
  int _getTileY(double lat, int zoom) {
    return ((1.0 -
                log(tan(lat * pi / 180.0) + 1.0 / cos(lat * pi / 180.0)) / pi) /
            2.0 *
            (1 << zoom))
        .floor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Kontak & Lokasi',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Kotak Lokasi Kampus
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Lokasi Kampus',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Area peta dengan OpenStreetMap
                  GestureDetector(
                    onTap: () {
                      // Ketuk pada peta untuk membuka di Google Maps
                      _launchURL('https://maps.app.goo.gl/hnewpAaMeZUtgV1c6');
                    },
                    child: Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Stack(
                        children: [
                          // Embed OpenStreetMap
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Stack(
                              children: [
                                // Peta latar belakang menggunakan tile server
                                Image.network(
                                  'https://tile.openstreetmap.org/16/${_getTileX(longitude, 16)}/${_getTileY(latitude, 16)}.png',
                                  width: double.infinity,
                                  height: 180,
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value:
                                                loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.map,
                                            color: Colors.grey[400],
                                            size: 64,
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Peta tidak dapat dimuat',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                // Lapisan gelap untuk kontras
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.1),
                                  ),
                                ),
                                // Penanda merah di tengah
                                Center(
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                    size: 48,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.5),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Tombol Buka di Maps
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                _launchURL(
                                  'https://maps.app.goo.gl/hnewpAaMeZUtgV1c6',
                                );
                              },
                              icon: const Icon(Icons.directions, size: 18),
                              label: const Text('Buka di Maps'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryBlue,
                                foregroundColor: Colors.white,
                                elevation: 4,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 8,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Alamat
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.home_outlined,
                        color: AppColors.primaryBlue,
                        size: 24,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Alamat:',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Jl. Mojopahit No.666B, Sidowayah, Celep, Kec. Sidoarjo, Kabupaten Sidoarjo, Jawa Timur 61215',
                              style: TextStyle(
                                fontSize: 14,
                                height: 1.5,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Kotak Kontak Kampus
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Kontak Kampus',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildContactCard(
                    icon: Icons.phone,
                    title: 'Telepon',
                    content: '(031) 8945444',
                    onTap: () => _makePhoneCall('0318945444'),
                  ),
                  const SizedBox(height: 12),
                  _buildContactCard(
                    icon: Icons.email,
                    title: 'Email',
                    content: 'humas@umsida.ac.id',
                    onTap: () => _sendEmail('humas@umsida.ac.id'),
                  ),
                  const SizedBox(height: 12),
                  _buildContactCard(
                    icon: Icons.language,
                    title: 'Website',
                    content: 'umsida.ac.id',
                    onTap: () => _launchURL('https://www.umsida.ac.id'),
                  ),
                  const SizedBox(height: 12),
                  _buildContactCard(
                    icon: FontAwesomeIcons.whatsapp,
                    title: 'WhatsApp',
                    content: '+62 851-8379-3309',
                    onTap: () => _launchURL('https://wa.me/6285183793309'),
                  ),
                  const SizedBox(height: 12),
                  _buildContactCard(
                    icon: Icons.facebook,
                    title: 'Facebook',
                    content: 'Universitas Muhammadiyah Sidoarjo',
                    onTap: () =>
                        _launchURL('https://web.facebook.com/umsidaofficial'),
                  ),
                  const SizedBox(height: 12),
                  _buildContactCard(
                    icon: FontAwesomeIcons.instagram,
                    title: 'Instagram',
                    content: '@umsida1912',
                    onTap: () =>
                        _launchURL('https://www.instagram.com/umsida1912'),
                  ),
                  const SizedBox(height: 12),
                  _buildContactCard(
                    icon: FontAwesomeIcons.youtube,
                    title: 'Youtube',
                    content: '@UMSIDA1912',
                    onTap: () =>
                        _launchURL('https://www.youtube.com/@UMSIDA1912'),
                  ),
                  const SizedBox(height: 12),
                  _buildContactCard(
                    icon: FontAwesomeIcons.tiktok,
                    title: 'TikTok',
                    content: '@umsida1912',
                    onTap: () =>
                        _launchURL('https://www.tiktok.com/@umsida1912'),
                  ),
                  const SizedBox(height: 12),
                  _buildContactCard(
                    icon: FontAwesomeIcons.xTwitter,
                    title: 'Twitter X',
                    content: '@UMSIDA1912',
                    onTap: () => _launchURL('https://x.com/UMSIDA1912'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget kartu kontak
  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String content,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primaryBlue, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    content,
                    style: const TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}
