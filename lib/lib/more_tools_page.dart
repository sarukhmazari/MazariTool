import 'package:flutter/material.dart';

class MoreToolsPage extends StatefulWidget {
  const MoreToolsPage({super.key});

  @override
  State<MoreToolsPage> createState() => _MoreToolsPageState();
}

class _MoreToolsPageState extends State<MoreToolsPage> {
  String? selectedType;
  final TextEditingController linkController = TextEditingController();
  String? generatedLink;

  final List<String> types = ["YouTube Video", "MP3", "Playlist"];

  void generateDownloadLink() {
    if (selectedType != null && linkController.text.isNotEmpty) {
      setState(() {
        // Simulated Mediafire link (replace with your backend/API later)
        generatedLink =
            "https://www.mediafire.com/download/${linkController.text.hashCode}";
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select type and enter a link.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        title: const Text("Downloader"),
        backgroundColor: Colors.green.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.download, size: 80, color: Colors.greenAccent),
            const SizedBox(height: 20),
            const Text(
              "YouTube Downloader",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent,
              ),
            ),
            const SizedBox(height: 20),

            // Dropdown for type
            DropdownButtonFormField<String>(
              dropdownColor: Colors.black87,
              value: selectedType,
              items: types
                  .map(
                    (type) => DropdownMenuItem(
                      value: type,
                      child: Text(
                        type,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() => selectedType = value);
              },
              decoration: InputDecoration(
                labelText: "Select Type",
                labelStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.black45,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Link input box
            TextField(
              controller: linkController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Enter YouTube Link",
                labelStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.black45,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Generate button
            ElevatedButton.icon(
              onPressed: generateDownloadLink,
              icon: const Icon(Icons.link),
              label: const Text("Generate Mediafire Link"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Show generated link
            if (generatedLink != null)
              SelectableText(
                "Download Link:\n$generatedLink",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
