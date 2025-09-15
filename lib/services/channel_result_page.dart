import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class ChannelResultPage extends StatelessWidget {
  final String channelName;
  final String whatsappNumber;
  final String channelLink;
  final DateTime banDate;

  const ChannelResultPage({
    super.key,
    required this.channelName,
    required this.whatsappNumber,
    required this.channelLink,
    required this.banDate,
  });

  @override
  Widget build(BuildContext context) {
    final reports = _generateReports();

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        title: Text(
          "Generated Reports",
          style: GoogleFonts.lato(
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        leading: const BackButton(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              itemCount: reports.length,
              itemBuilder: (context, index) {
                return _reportCard(
                  context,
                  "Report ${index + 1}",
                  reports[index],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 24.0),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
                  final allReports = reports.join("\n\n----------------\n\n");
                  Clipboard.setData(ClipboardData(text: allReports));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "All Reports Copied!",
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                      backgroundColor: const Color(0xFF2196F3),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.copy, color: Colors.white),
                label: Text(
                  "Copy All Reports",
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2196F3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _reportCard(BuildContext context, String title, String content) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF2E2E2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF424242), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.lato(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2196F3),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              content,
              style: GoogleFonts.lato(
                fontSize: 14,
                color: const Color(0xFFB0B0B0),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: content));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Copied to Clipboard!",
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                      backgroundColor: const Color(0xFF2196F3),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.copy, size: 18, color: Colors.white),
                label: Text(
                  "Copy",
                  style: GoogleFonts.lato(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF333333),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> _generateReports() {
    final formattedDate = "${banDate.day}-${banDate.month}-${banDate.year}";

    return [
      "Report 1:\n\nChannel Name: $channelName\nWhatsApp: $whatsappNumber\nChannel Link: $channelLink\nBanned On: $formattedDate\n\nHello WhatsApp Support, my channel '$channelName' is vital for my daily business operations. The block has disrupted client communications and project management. I kindly request a review and reinstatement at the earliest. All activities fully comply with your policies.",
      "Report 2:\n\nChannel Name: $channelName\nWhatsApp: $whatsappNumber\nChannel Link: $channelLink\nBanned On: $formattedDate\n\nHi Team, the suspension of '$channelName' is preventing me from accessing crucial client information and ongoing project details. Restoring access is urgent to prevent further disruption. I assure you of full compliance with WhatsApp guidelines.",
      "Report 3:\n\nChannel Name: $channelName\nWhatsApp: $whatsappNumber\nChannel Link: $channelLink\nBanned On: $formattedDate\n\nDear WhatsApp Support, blocking '$channelName' has halted essential communication with my business partners. The channel stores sensitive data and project updates. I request an urgent review and reinstatement to continue operations smoothly.",
      "Report 4:\n\nChannel Name: $channelName\nWhatsApp: $whatsappNumber\nChannel Link: $channelLink\nBanned On: $formattedDate\n\nHello, '$channelName' is key for coordinating my team and clients. Since its ban, workflows are severely impacted, and deadlines are at risk. Please consider restoring access promptly. I guarantee strict adherence to all WhatsApp policies.",
      "Report 5:\n\nChannel Name: $channelName\nWhatsApp: $whatsappNumber\nChannel Link: $channelLink\nBanned On: $formattedDate\n\nHi WhatsApp Team, I manage important transactions and client interactions through '$channelName'. The sudden block is causing operational setbacks. I humbly request reinstatement and confirm all activities are legitimate and compliant.",
      "Report 6:\n\nChannel Name: $channelName\nWhatsApp: $whatsappNumber\nChannel Link: $channelLink\nBanned On: $formattedDate\n\nDear Support, my channel '$channelName' holds critical business data including client contacts and project files. The ban is creating major disruptions. I request a thorough review and prompt unblocking. All usage follows your guidelines.",
      "Report 7:\n\nChannel Name: $channelName\nWhatsApp: $whatsappNumber\nChannel Link: $channelLink\nBanned On: $formattedDate\n\nHello WhatsApp Team, the blockage of '$channelName' is affecting client follow-ups and daily operations. The channel is used exclusively for professional purposes. Please review and restore access. I assure complete compliance with WhatsApp rules.",
      "Report 8:\n\nChannel Name: $channelName\nWhatsApp: $whatsappNumber\nChannel Link: $channelLink\nBanned On: $formattedDate\n\nHi Support, '$channelName' is essential for project coordination and document sharing. Its ban is impacting professional relationships and business continuity. I kindly request restoration and pledge to follow all WhatsApp policies.",
      "Report 9:\n\nChannel Name: $channelName\nWhatsApp: $whatsappNumber\nChannel Link: $channelLink\nBanned On: $formattedDate\n\nDear WhatsApp Team, the suspension of '$channelName' is causing difficulties in managing client communications and ongoing projects. Please review my account and restore access. I confirm that all channel activities are fully compliant.",
      "Report 10:\n\nChannel Name: $channelName\nWhatsApp: $whatsappNumber\nChannel Link: $channelLink\nBanned On: $formattedDate\n\nHello, my channel '$channelName' is blocked and contains sensitive business information required for daily operations. I request immediate review and reinstatement. All activities are legitimate and in full compliance with WhatsApp policies.",
    ];
  }
}
