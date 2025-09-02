import 'package:flutter/material.dart';
import 'services/unban_tool_page.dart';
import 'services/channel_unban_page.dart';
import 'services/group_unban_page.dart';
import 'services/help_page.dart';

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
            _buildGradientButton(context, "Unban Tool", Icons.build, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UnbanToolPage()),
              );
            }),
            const SizedBox(height: 20),

            // 2. Channel Unban
            _buildGradientButton(context, "Channel Unban", Icons.group, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChannelUnbanPage(),
                ),
              );
            }),
            const SizedBox(height: 20),

            // 3. Group Unban
            _buildGradientButton(context, "Group Unban", Icons.group_add, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GroupUnbanPage()),
              );
            }),
            const SizedBox(height: 20),

            // 4. Help Page
            _buildGradientButton(context, "Help", Icons.help, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HelpPage()),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientButton(
    BuildContext context,
    String text,
    IconData icon,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF00F5FF), Color(0xFFB400FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
