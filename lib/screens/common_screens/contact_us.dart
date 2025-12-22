import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class contact_us extends StatelessWidget {
  const contact_us({super.key});

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFE8EEF5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Contact Us',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF9BE7FF),
              Color(0xFFB3E5FC),
              Color(0xFFE1F5FE),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 110, 16, 20),
          children: [
            _contactCard(
              name: 'Abu Issa',
              phone: '0788720240',
              email: 'ammohammad2197@cit.just.edu.jo',
              facebookUrl: 'https://www.facebook.com/share/1BMQqFVXX1/?mibextid=wwXIfr',
            ),
            _contactCard(
              name: 'Osama',
              phone: '0785386494',
              email: 'osamaameerah2@gmail.com',
              facebookUrl: 'https://www.facebook.com/share/1DFxeoSRLs/?mibextid=wwXIfr',
            ),
            _contactCard(
              name: 'Qusai',
              phone: '0795351305',
              email: 'qaaltwbasy@cit.just.edu.jo',
              facebookUrl: 'https://www.facebook.com/share/1Hr59ottn5/?mibextid=wwXIfr',
            ),

            _contactCard(
              name: 'Waleed',
              phone: '0792915033',
              email: 'wtaldweik21@cit.just.edu.jo',
              facebookUrl: 'https://www.facebook.com/share/16ZVKfAVy8/?mibextid=wwXIfr',
            ),
          ],
        ),
      ),
    );
  }

  Widget _contactCard({
    required String name,
    required String phone,
    required String email,
    required String facebookUrl,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: Colors.white.withOpacity(0.95),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 14),

          _infoRow(Icons.phone, phone),
          const SizedBox(height: 8),
          _infoRow(Icons.email_outlined, email),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton.icon(
              onPressed: () => _openUrl(facebookUrl),
              icon: const Icon(Icons.facebook),
              label: const Text(
                'Facebook Profile',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1877F2),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFF4A90E2).withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xFF4A90E2), size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
