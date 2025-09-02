import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ButtonPage extends StatelessWidget {
  final DateTime selectedDate;
  final String channelName;
  final String whatsappNumber;

  const ButtonPage({
    super.key,
    required this.selectedDate,
    required this.channelName,
    required this.whatsappNumber,
  });

  // Generate random unban reports
  List<String> generateReports() {
    String formattedDate =
        "${selectedDate.day.toString().padLeft(2, '0')}/"
        "${selectedDate.month.toString().padLeft(2, '0')}/"
        "${selectedDate.year}";

    List<String> reasonPool = [
      "The channel was mistakenly flagged for spam.",
      "Automated checks wrongly detected a violation.",
      "The account activity was misunderstood by the system.",
      "Channel content fully complies with WhatsApp rules.",
      "A previous review request was overlooked.",
      "Some shared links were safe but flagged as harmful.",
      "This channel is educational and policy-friendly.",
      "Suspicious activity was incorrectly reported.",
      "All members are genuine and verified.",
      "The ban interrupts important communication.",
      "Recent posts are strictly guideline-compliant.",
      "Content was reviewed internally and found safe.",
      "System errors may have triggered the restriction.",
      "The channel promotes safe discussion only.",
      "Automated tools caused a misinterpretation.",
      "We have resolved any past misunderstandings.",
      "The issue seems to be from false reports.",
      "Shared files and media are verified as safe.",
      "Manual review will confirm no violations.",
      "Community engagement follows the rules strictly.",
    ];

    Random random = Random();
    reasonPool.shuffle(random);

    List<String> reports = [];
    for (int i = 0; i < 10; i++) {
      reports.add(
        "Hello WhatsApp Support Team,\n\n"
        "Channel Name: $channelName\n"
        "WhatsApp Number: $whatsappNumber\n"
        "Banned on: $formattedDate\n\n"
        "${reasonPool[i]}\n\n"
        "We kindly request a thorough review and immediate reinstatement of the channel. "
        "All content complies with WhatsApp guidelines, and we are committed "
        "to maintaining a safe and policy-compliant environment for all members.\n\n"
        "Thank you for your time and support.",
      );
    }
    return reports;
  }

  @override
  Widget build(BuildContext context) {
    final reports = generateReports();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Unban Reports"),
        centerTitle: true,
        backgroundColor: Colors.blue.shade700,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                "Generated Unban Reports",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 20),

              // Scrollable list of reports
              Expanded(
                child: ListView.builder(
                  itemCount: reports.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Report ${index + 1}",
                                  style: const TextStyle(
                                    color: Colors.lightBlueAccent,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.35),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: SelectableText(
                                    reports[index],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blueAccent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    icon: const Icon(Icons.copy, size: 18),
                                    label: const Text("Copy"),
                                    onPressed: () {
                                      Clipboard.setData(
                                        ClipboardData(text: reports[index]),
                                      );
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text("Copied to clipboard"),
                                          behavior: SnackBarBehavior.floating,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
