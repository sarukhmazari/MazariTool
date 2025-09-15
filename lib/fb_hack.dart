import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SocioPhishInfoPage extends StatelessWidget {
  const SocioPhishInfoPage({super.key});

  // Section builder with optional copy-to-clipboard button
  Widget _buildSection({
    required BuildContext context,
    required String title,
    required String content,
    bool isCommand = false,
  }) {
    return Card(
      color: Colors.black.withOpacity(0.6),
      elevation: 6,
      shadowColor: Colors.greenAccent.withOpacity(0.4),
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF00FFAA),
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SelectableText(
                    content,
                    style: TextStyle(
                      color: isCommand ? Colors.greenAccent : Colors.white,
                      fontSize: 14,
                      height: 1.4,
                      fontFamily: isCommand ? "monospace" : null,
                    ),
                  ),
                ),
                if (isCommand)
                  Tooltip(
                    message: "Copy",
                    child: IconButton(
                      icon: const Icon(Icons.copy, color: Colors.greenAccent),
                      iconSize: 20,
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: content));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("✅ Command copied"),
                            duration: Duration(seconds: 1),
                            backgroundColor: Colors.black87,
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            // Scrollable content
            ListView(
              padding: const EdgeInsets.only(top: 80, bottom: 20),
              children: [
                // Centered Title at top (scrolls away)
                Center(
                  child: Text(
                    "SOCIOPHISH (Educational)",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      color: Colors.greenAccent,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                _buildSection(
                  context: context,
                  title: "⚠️ Disclaimer",
                  content:
                      "This page is for EDUCATIONAL purposes only.\n"
                      "Do not use for illegal hacking.\n"
                      "Use it only to understand phishing awareness and security testing in a safe environment.",
                ),
                _buildSection(
                  context: context,
                  title: "📖 Description",
                  content:
                      "SocioPhish is a SocialMedia Phishing Tool designed for awareness training and "
                      "demonstrating how phishing attacks can look.\n\n"
                      "It is based on SocialFish with a better UI and updated templates.",
                ),
                _buildSection(
                  context: context,
                  title: "✨ Features",
                  content:
                      "• Educational phishing awareness demo\n"
                      "• Fake login pages for training (Facebook, Instagram, etc.)\n"
                      "• Copy-to-clipboard commands\n"
                      "• Easy to set up and run",
                ),
                _buildSection(
                  context: context,
                  title: "⚙️ Installation",
                  content:
                      "git clone https://github.com/alexbieber/SocioPhish.git",
                  isCommand: true,
                ),
                _buildSection(
                  context: context,
                  title: "📂 Navigate",
                  content: "cd SocioPhish",
                  isCommand: true,
                ),
                _buildSection(
                  context: context,
                  title: "▶️ Run Script",
                  content: "bash SocioPhish.sh",
                  isCommand: true,
                ),
                _buildSection(
                  context: context,
                  title: "📌 Note",
                  content:
                      "This app is only a security awareness simulation.\n"
                      "Never use these techniques for real-world hacking.\n"
                      "It’s intended for students, researchers, and IT professionals learning cyber security.",
                ),
              ],
            ),

            // Back button
            Positioned(
              top: 40,
              left: 12,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.greenAccent,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
