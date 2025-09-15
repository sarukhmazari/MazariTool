import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  /// Helper function to launch URLs
  Future<void> _launchURL(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error launching URL: $e')));
    }
  }

  /// Helper function to open WhatsApp chat
  void _openWhatsAppChat(BuildContext context, String phone) {
    final String url =
        'https://wa.me/${phone.replaceAll(' ', '')}?text=${Uri.encodeComponent("Hello, I'm contacting you through the Mazari Tool app.")}';
    _launchURL(context, url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E2A47),
      appBar: AppBar(
        title: const Text(
          "About Us",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1A233A),
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.5),
        leading: const BackButton(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(
                child: Text(
                  "Our Team & Mission",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Mazari Tool is a versatile application developed and managed by Zoxer & Mazari. We are dedicated to providing powerful digital solutions for our users.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),
              _buildSectionCard(
                context,
                title: "Technical Overview",
                content:
                    "This application provides a comprehensive suite of services, including unbanning for channels, groups, and phone numbers. It also features tools for Termux, hacking, and other advanced utilities.",
              ),
              const SizedBox(height: 20),
              _buildSectionCard(
                context,
                title: "Contact & Community",
                content:
                    "Connect with us and stay updated on our latest releases.",
                children: [
                  _buildContactListTile(
                    context,
                    icon: FontAwesomeIcons.whatsapp,
                    title: "WhatsApp Channel 1",
                    subtitle: "Join our official community channel",
                    onTap: () => _launchURL(
                      context,
                      "https://whatsapp.com/channel/0029VbBRITODzgTGQhZSFT3P",
                    ),
                  ),
                  _buildContactListTile(
                    context,
                    icon: FontAwesomeIcons.whatsapp,
                    title: "WhatsApp Channel 2",
                    subtitle: "Stay updated on new features",
                    onTap: () => _launchURL(
                      context,
                      "https://www.whatsapp.com/channel/0029Vb6GUj8BPzjOWNfnhm1B",
                    ),
                  ),
                  const Divider(color: Colors.white24),
                  _buildContactListTile(
                    context,
                    icon: Icons.phone,
                    title: "Zoxer",
                    subtitle: "+92 323 2391033",
                    onTap: () => _openWhatsAppChat(context, "+923232391033"),
                  ),
                  _buildContactListTile(
                    context,
                    icon: Icons.phone,
                    title: "Mazari",
                    subtitle: "+92 325 2025304",
                    onTap: () => _openWhatsAppChat(context, "+923252025304"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required String content,
    List<Widget> children = const [],
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A233A),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
              height: 1.4,
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildContactListTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: const Color(0xFF66FCF1)),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70)),
    );
  }
}
