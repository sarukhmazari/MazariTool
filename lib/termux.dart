import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'fb_hack.dart';

class TermuxPage extends StatefulWidget {
  const TermuxPage({super.key});

  @override
  State<TermuxPage> createState() => _TermuxPageState();
}

class _TermuxPageState extends State<TermuxPage> {
  bool _isDownloading = false;

  static const String termuxDownloadUrl =
      'https://github.com/termux/termux-app/releases/download/v0.118.0/termux-app_v0.118.0+github-debug_universal.apk';

  Future<void> _downloadTermux(BuildContext context) async {
    setState(() {
      _isDownloading = true;
    });

    try {
      final Uri url = Uri.parse(termuxDownloadUrl);
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Could not launch the download page. Please check your internet connection.',
            ),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Download started. Check your browser.'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isDownloading = false;
        });
      }
    }
  }

  void _navigateToFbHackPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SocioPhishInfoPage()),
    );
  }

  // Reusable code box widget
  Widget _buildCodeBox(BuildContext context, String code) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF66FCF1), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SelectableText(
              code,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: "monospace",
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.copy, color: Color(0xFF66FCF1)),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: code));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("✅ Commands copied"),
                  duration: Duration(seconds: 2),
                  backgroundColor: Colors.black87,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF222831),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Termux Tools',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: Color(0xFF66FCF1),
            shadows: [Shadow(blurRadius: 10, color: Color(0xFF66FCF1))],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Welcome to Termux Tools',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF66FCF1),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Column(
                  children: [
                    Text(
                      'Termux is a powerful terminal emulator for Android that allows you to run various Linux tools and commands.',
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Instructions:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF66FCF1),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '1. Download and install Termux\n2. Open Termux and wait for initial setup\n3. Use the tools available in the app',
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              /// Download Button
              ElevatedButton(
                onPressed: _isDownloading
                    ? null
                    : () => _downloadTermux(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF66FCF1),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                  disabledBackgroundColor: Colors.grey,
                ),
                child: _isDownloading
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.black54,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Downloading...',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      )
                    : const Text(
                        'Download Termux',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF222831),
                        ),
                      ),
              ),

              const SizedBox(height: 40),

              /// 📦 Section Title outside the code box
              const Text(
                "📦 Basic Setup (Recommended for new users):",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF66FCF1),
                ),
              ),
              const SizedBox(height: 10),

              /// Code box with only commands
              _buildCodeBox(context, """
pkg update && pkg upgrade -y
pkg install git -y
pkg install python -y
pkg install python2 -y
pkg install curl -y
pkg install wget -y
pkg install unzip -y
pkg install nano -y
pkg install vim -y
pkg install clang -y
pkg install nodejs -y
pkg install php -y
pkg install openssh -y
pkg install net-tools -y
"""),

              const SizedBox(height: 20),

              /// Navigation Button
              ElevatedButton(
                onPressed: () => _navigateToFbHackPage(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF66FCF1),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
                child: const Text(
                  'Fb Hack Tool',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF222831),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
