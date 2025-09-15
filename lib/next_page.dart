import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'services/unban_tool_page.dart';
import 'services/channel_unban_page.dart';
import 'services/group_unban_page.dart';
import 'services/help_page.dart';
import 'termux.dart';
import 'paid_work.dart'; // Corrected import path
import 'locfind_page.dart'; // Corrected import path
import 'services/about.dart';
import 'fakess.dart'; // ✅ Import your new page here

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  // Helper function to launch URLs
  void _launchURL(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not launch $url')));
    }
  }

  // Helper function to open WhatsApp chat
  void _launchWhatsAppChat(BuildContext context, String phone) async {
    final String url =
        'https://wa.me/$phone?text=${Uri.encodeComponent("Hello, I need help with Mazari Tool.")}';
    _launchURL(context, url);
  }

  @override
  Widget build(BuildContext context) {
    // Define the list of tools to display in the grid
    final List<Map<String, dynamic>> tools = [
      {
        'title': "Number Unban",
        'icon': Icons.security,
        'subtitle': "Fix your bans with ease",
        'page': const UnbanToolPage(),
      },
      {
        'title': "Channel Unban",
        'icon': Icons.voice_over_off,
        'subtitle': "Unban from channels",
        'page': const ChannelUnbanPage(),
      },
      {
        'title': "Group Unban",
        'icon': Icons.group_off,
        'subtitle': "Unban from groups",
        'page': const GroupUnbanPage(),
      },
      {
        'title': "Termux",
        'icon': Icons.terminal,
        'subtitle': "Access command-line",
        'page': const TermuxPage(),
      },
      {
        'title': "Location Finder",
        'icon': Icons.location_on,
        'subtitle': "Find any location",
        'page': const LocFindPage(),
      },
      {
        'title': "Paid Works",
        'icon': Icons.workspace_premium,
        'subtitle': "Explore premium services",
        'page': const PaidWorkPage(),
      },
      {
        'title': "Fake Payment Screenshot",
        'icon': Icons.receipt_long,
        'subtitle': "Generate fake receipts",
        // Corrected the page assignment to use your FakessPage (now renamed to FakePaymentGenerator)
        'page': const FakessPage(),
      },
      {
        'title': "Help",
        'icon': Icons.help_outline,
        'subtitle': "Get support",
        'page': const HelpPage(),
      },
      {
        'title': "About Us",
        'icon': Icons.info_outline,
        'subtitle': "Learn more about us",
        'page': const AboutPage(),
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF222831),
      appBar: AppBar(
        backgroundColor: const Color(0xFF222831),
        elevation: 0,
        leading: const BackButton(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 48.0, bottom: 24.0),
              child: Center(
                child: Text(
                  "Choose Your Tool",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: tools.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 1.2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (BuildContext context, int index) {
                final tool = tools[index];
                return _buildToolCard(
                  context,
                  tool['title'] as String,
                  tool['icon'] as IconData,
                  tool['subtitle'] as String,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => tool['page'] as Widget,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildToolCard(
    BuildContext context,
    String title,
    IconData icon,
    String subtitle,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Color(0xFF394867), Color(0xFF283244)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFF66FCF1), size: 36),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
