import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  /// Send Email
  Future<void> _sendEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': 'Support Request',
        'body': 'Hello WhatsApp Support,',
      },
    );

    try {
      if (!await launchUrl(emailUri, mode: LaunchMode.externalApplication)) {
        throw Exception("Could not open email app.");
      }
    } catch (e) {
      // In a real app, you would show a user-friendly error message.
      debugPrint("Error launching email: $e");
    }
  }

  /// Open WhatsApp chat
  Future<void> _openWhatsApp(String phone, [String message = "Hello!"]) async {
    final Uri whatsappUri = Uri.parse(
      "https://wa.me/${phone.replaceAll('+', '')}?text=${Uri.encodeComponent(message)}",
    );
    try {
      if (!await launchUrl(whatsappUri, mode: LaunchMode.externalApplication)) {
        throw Exception("Could not open WhatsApp.");
      }
    } catch (e) {
      // In a real app, you would show a user-friendly error message.
      debugPrint("Error launching WhatsApp: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E2A47),
      appBar: AppBar(
        title: const Text(
          "Help & Support",
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
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Need help? Contact our support team.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              _buildSupportButton(
                context,
                icon: Icons.email,
                label: "Email Support",
                onPressed: () => _sendEmail("support@whatsapp.com"),
              ),
              const SizedBox(height: 20),
              _buildSupportButton(
                context,
                icon: FontAwesomeIcons.whatsapp,
                label: "Chat with ZOXER",
                onPressed: () => _openWhatsApp("+923292823218", "Hello ZOXER!"),
              ),
              const SizedBox(height: 20),
              _buildSupportButton(
                context,
                icon: FontAwesomeIcons.whatsapp,
                label: "Chat with MAZARI",
                onPressed: () =>
                    _openWhatsApp("+923043514180", "Hello MAZARI!"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSupportButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [Color(0xFF8E9EAB), Color(0xFFE8EBF2)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: const Color(0xFF1E2A47)),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E2A47),
            letterSpacing: 1.5,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
