import 'package:flutter/material.dart';
import 'unban_tool_page.dart';
import 'account_recovery_page.dart';
import 'more_tools_page.dart';
import 'help_page.dart' as help_page;
import 'qr.dart'; // ✅ Import your QR code generator page

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              Color(0xFF00F5FF), // Neon Cyan
              Color(0xFFB400FF), // Neon Purple
              Color(0xFFFF00E1), // Neon Pink
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: const Text(
            'MAZARI TOOL',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              color: Colors.white,
              shadows: [
                Shadow(blurRadius: 20, color: Color(0xFF00F5FF)),
                Shadow(blurRadius: 20, color: Color(0xFFB400FF)),
              ],
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Choose Your Tool",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 40),

            // 1. Unban Tool
            _buildGradientButton(
              context,
              "Unban Tool",
              Icons.shield,
              const UnbanToolPage(),
            ),
            const SizedBox(height: 20),

            // 2. QR Code Generator
            _buildGradientButton(
              context,
              "QR Code Generator",
              Icons.qr_code_2,
              const QrPage(), // Page from qr.dart
            ),
            const SizedBox(height: 20),

            // 3. Account Recovery
            _buildGradientButton(
              context,
              "Account Recovery",
              Icons.account_circle,
              const AccountRecoveryPage(),
            ),
            const SizedBox(height: 20),

            // 4. More Tools
            _buildGradientButton(
              context,
              "More Tools",
              Icons.build,
              const MoreToolsPage(),
            ),
            const SizedBox(height: 20),

            // 5. Help
            _buildGradientButton(
              context,
              "Help",
              Icons.help,
              const help_page.HelpPage(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientButton(
    BuildContext context,
    String text,
    IconData icon,
    Widget page,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 75,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF00F5FF), // Neon Cyan
              Color(0xFFB400FF), // Neon Purple
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 8,
              offset: Offset(2, 4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 28, color: Colors.white),
              const SizedBox(width: 12),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
