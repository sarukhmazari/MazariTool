import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class GroupResultPage extends StatelessWidget {
  final String groupType;
  final String groupName;
  final String whatsappNumber;
  final DateTime selectedDate;

  const GroupResultPage({
    super.key,
    required this.groupType,
    required this.groupName,
    required this.whatsappNumber,
    required this.selectedDate,
  });

  String get formattedDate =>
      DateFormat('EEEE, dd MMMM yyyy').format(selectedDate);

  void copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Copied to clipboard!",
          style: GoogleFonts.lato(color: Colors.white),
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: const Color(0xFF2196F3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget reportCard(BuildContext context, String title, String content) {
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
                onPressed: () => copyToClipboard(context, "$title\n\n$content"),
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

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // Report 1
            reportCard(context, "Report 1", """
Subject: Request for Restoration of WhatsApp Group "$groupName"

Dear WhatsApp Support Team,

I am writing to request a review of the ban imposed on our group "$groupName" on $formattedDate. This group is dedicated to $groupType discussions and has always followed WhatsApp’s guidelines. We believe the ban may have been applied in error.

Details for your reference:
- Group Name: $groupName
- Group Type: $groupType
- WhatsApp Number: $whatsappNumber
- Date of Ban: $formattedDate

We respectfully request that you review this matter and reinstate our group.

Sincerely,
$whatsappNumber
"""),

            // Report 2
            reportCard(context, "Report 2", """
Subject: Appeal Against Group Ban – "$groupName"

Dear WhatsApp Support,

Our group "$groupName", focused on $groupType activities, was banned on $formattedDate. We are confident that the group has not violated any community standards. The ban has impacted our members who depend on this group for daily communication.

Details for reference:
- Group Name: $groupName
- Group Type: $groupType
- WhatsApp Number: $whatsappNumber
- Ban Date: $formattedDate

We kindly request a reconsideration and restoration of the group.

Best regards,
$whatsappNumber
"""),

            // Report 3
            reportCard(context, "Report 3", """
Subject: Request to Reinstate Group "$groupName"

Dear WhatsApp Team,

Please reconsider the ban placed on "$groupName" on $formattedDate. This group is vital for $groupType discussions and has always maintained respectful and compliant behavior. The suspension has disrupted our community.

Group details:
- Group Name: $groupName
- Group Type: $groupType
- WhatsApp Number: $whatsappNumber
- Ban Date: $formattedDate

We request that you restore the group at the earliest.

Thank you,
$whatsappNumber
"""),

            // Report 4
            reportCard(context, "Report 4", """
Subject: Formal Appeal – Ban of "$groupName"

Dear WhatsApp Review Team,

We are appealing the suspension of our group "$groupName", which was banned on $formattedDate. The group serves a legitimate purpose of $groupType and has consistently complied with WhatsApp’s policies.

Reference details:
- Group Name: $groupName
- Group Type: $groupType
- WhatsApp Number: $whatsappNumber
- Date of Ban: $formattedDate

We sincerely request your assistance in restoring the group.

Respectfully,
$whatsappNumber
"""),

            // Report 5
            reportCard(context, "Report 5", """
Subject: Group Ban Review Request – "$groupName"

Dear WhatsApp Support,

Our group "$groupName" was unexpectedly banned on $formattedDate. This group is exclusively for $groupType and follows all guidelines. The suspension appears to be an error, and we kindly ask for a review.

Details:
- Group Name: $groupName
- Group Type: $groupType
- WhatsApp Number: $whatsappNumber
- Ban Date: $formattedDate

Please restore the group at your earliest convenience.

Sincerely,
$whatsappNumber
"""),

            // Report 6
            reportCard(context, "Report 6", """
Subject: Urgent Request to Unban Group "$groupName"

Dear WhatsApp Team,

We request your urgent attention to the ban of our group "$groupName" on $formattedDate. The group exists for $groupType and provides meaningful interaction to members. We assure full compliance moving forward.

Case details:
- Group Name: $groupName
- Group Type: $groupType
- WhatsApp Number: $whatsappNumber
- Ban Date: $formattedDate

We kindly ask for the group’s reinstatement.

Best regards,
$whatsappNumber
"""),

            // Report 7
            reportCard(context, "Report 7", """
Subject: Group Suspension Review – "$groupName"

Respected WhatsApp Moderation Team,

Our group "$groupName" was banned on $formattedDate. This group has always been a safe space for $groupType discussions. We believe the ban is an oversight, and we are requesting a thorough review.

Details of the group:
- Group Name: $groupName
- Group Type: $groupType
- WhatsApp Number: $whatsappNumber
- Date of Ban: $formattedDate

We hope for your support in reinstating the group.

Warm regards,
$whatsappNumber
"""),

            // Report 8
            reportCard(context, "Report 8", """
Subject: Request for Group Restoration – "$groupName"

Dear WhatsApp Helpdesk,

We are writing to appeal the ban on our group "$groupName", which was removed on $formattedDate. The group is important for $groupType activities and adheres to WhatsApp’s policies. We request a reevaluation.

Reference:
- Group Name: $groupName
- Group Type: $groupType
- WhatsApp Number: $whatsappNumber
- Ban Date: $formattedDate

Please restore our group at the earliest.

Kind regards,
$whatsappNumber
"""),

            // Report 9
            reportCard(context, "Report 9", """
Subject: Appeal for Reinstatement of "$groupName"

Dear WhatsApp Moderation Team,

This is a formal request to reinstate our group "$groupName", which was banned on $formattedDate. The group has been a hub for $groupType discussions and has not engaged in policy violations. The ban has disrupted our members significantly.

Details:
- Group Name: $groupName
- Group Type: $groupType
- WhatsApp Number: $whatsappNumber
- Ban Date: $formattedDate

We kindly request your review and restoration of the group.

Thank you,
$whatsappNumber
"""),

            // Report 10
            reportCard(context, "Report 10", """
Subject: Urgent Appeal to Unban Group "$groupName"

To WhatsApp Appeals Department,

I am requesting the unbanning of our group "$groupName", suspended on $formattedDate. The group is centered on $groupType discussions and contributes positively to its members. The suspension seems accidental.

Group information:
- Group Name: $groupName
- Group Type: $groupType
- WhatsApp Number: $whatsappNumber
- Date of Ban: $formattedDate

We humbly request that you restore the group.

Faithfully,
$whatsappNumber
"""),
          ],
        ),
      ),
    );
  }
}
