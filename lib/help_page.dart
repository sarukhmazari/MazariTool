import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

    if (!await launchUrl(
      emailUri,
      mode: LaunchMode.externalApplication, // ✅ Works with ^6.3.2
    )) {
      throw Exception("Could not open email app.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Help Page")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _sendEmail("support@whatsapp.com"),
          child: const Text("Contact Support"),
        ),
      ),
    );
  }
}
