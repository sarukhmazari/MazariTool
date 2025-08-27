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

    if (!await launchUrl(emailUri, mode: LaunchMode.externalApplication)) {
      throw Exception("Could not open email app.");
    }
  }

  /// Open WhatsApp chat
  Future<void> _openWhatsApp(String phone, [String message = "Hello!"]) async {
    final Uri whatsappUri = Uri.parse(
      "https://wa.me/${phone.replaceAll('+', '')}?text=${Uri.encodeComponent(message)}",
    );
    if (!await launchUrl(whatsappUri, mode: LaunchMode.externalApplication)) {
      throw Exception("Could not open WhatsApp.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        title: const Text("Help Page"),
        backgroundColor: Colors.green.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Email Support Button (New Color)
            ElevatedButton.icon(
              onPressed: () => _sendEmail("support@whatsapp.com"),
              icon: const Icon(Icons.email),
              label: const Text("Contact Support"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
                backgroundColor: Colors.orange.shade700, // ✅ Changed color
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ZOXER WhatsApp Button
            ElevatedButton.icon(
              onPressed: () => _openWhatsApp("+923292823218", "Hello ZOXER!"),
              icon: const FaIcon(FontAwesomeIcons.whatsapp),
              label: const Text("Chat with ZOXER"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
                backgroundColor: const Color(0xFF25D366),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // MAZARI WhatsApp Button
            ElevatedButton.icon(
              onPressed: () => _openWhatsApp("+923043514180", "Hello MAZARI!"),
              icon: const FaIcon(FontAwesomeIcons.whatsapp),
              label: const Text("Chat with MAZARI"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
                backgroundColor: const Color(0xFF25D366),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
