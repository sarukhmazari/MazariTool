import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

class FakessPage extends StatefulWidget {
  const FakessPage({super.key});

  @override
  State<FakessPage> createState() => _FakessPageState();
}

class _FakessPageState extends State<FakessPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController tidController = TextEditingController();
  final TextEditingController dateTimeController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController feeController = TextEditingController(
    text: '0.00',
  );
  final TextEditingController toNameController = TextEditingController();
  final TextEditingController toNumberController = TextEditingController();
  final TextEditingController toNoteController = TextEditingController(
    text: 'Transfer to Family and Friends',
  );
  final TextEditingController fromNameController = TextEditingController();
  final TextEditingController fromNumberController = TextEditingController();

  DateTime? selectedDateTime;

  @override
  void initState() {
    super.initState();
    _generateAndSetTransactionId();
  }

  @override
  void dispose() {
    tidController.dispose();
    dateTimeController.dispose();
    amountController.dispose();
    feeController.dispose();
    toNameController.dispose();
    toNumberController.dispose();
    toNoteController.dispose();
    fromNameController.dispose();
    fromNumberController.dispose();
    super.dispose();
  }

  String _generateTransactionId() {
    final random = Random();
    return List.generate(12, (_) => random.nextInt(10).toString()).join();
  }

  void _generateAndSetTransactionId() {
    setState(() {
      tidController.text = _generateTransactionId();
    });
  }

  Future<void> _pickDateTime() async {
    DateTime now = DateTime.now();
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? now,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (date == null) return;

    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: selectedDateTime != null
          ? TimeOfDay.fromDateTime(selectedDateTime!)
          : TimeOfDay.fromDateTime(now),
    );
    if (time == null) return;

    final DateTime pickedDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    setState(() {
      selectedDateTime = pickedDateTime;
      dateTimeController.text =
          "On ${DateFormat('MMMM dd, yyyy').format(pickedDateTime)} at ${DateFormat('HH:mm').format(pickedDateTime)}";
    });
  }

  String _formatToName(String name) {
    if (name.isEmpty) return '';
    return name
        .trim()
        .split(RegExp(r"\s+"))
        .map(
          (word) => word.isNotEmpty
              ? "${word[0].toUpperCase()}${word.substring(1).toLowerCase()}"
              : "",
        )
        .join(" ");
  }

  String _formatFromName(String name) {
    return name.toUpperCase();
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a number";
    }
    if (value.length != 11) {
      return "Number must be exactly 11 digits";
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return "Please enter a valid number";
    }
    return null;
  }

  void _navigateToReceiptPage() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReceiptPage(
          tid: tidController.text.trim(),
          dateTime: dateTimeController.text.trim(),
          amount: amountController.text.trim(),
          fee: feeController.text.trim(),
          toName: _formatToName(toNameController.text),
          toNumber: toNumberController.text.trim(),
          toNote: toNoteController.text.trim(),
          fromName: _formatFromName(fromNameController.text),
          fromNumber: fromNumberController.text.trim(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const inputSpacing = SizedBox(height: 16);
    return Scaffold(
      appBar: AppBar(title: const Text("Fake Payment Generator")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Text(
                  'Enter receipt details',
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                inputSpacing,
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: tidController,
                        decoration: const InputDecoration(
                          labelText: "Transaction ID",
                        ),
                        readOnly: true,
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: _generateAndSetTransactionId,
                      tooltip: 'Refresh Transaction ID',
                    ),
                  ],
                ),
                inputSpacing,
                TextFormField(
                  controller: dateTimeController,
                  decoration: const InputDecoration(labelText: "Date & Time"),
                  readOnly: true,
                  onTap: _pickDateTime,
                ),
                inputSpacing,
                TextFormField(
                  controller: amountController,
                  decoration: const InputDecoration(labelText: "Amount"),
                  keyboardType: TextInputType.number,
                  validator: (value) => value == null || value.isEmpty
                      ? "Please enter amount"
                      : null,
                ),
                inputSpacing,
                TextFormField(
                  controller: feeController,
                  decoration: const InputDecoration(labelText: "Fee"),
                  keyboardType: TextInputType.number,
                ),
                inputSpacing,
                TextFormField(
                  controller: toNameController,
                  decoration: const InputDecoration(labelText: "To Name"),
                  validator: (value) => value == null || value.isEmpty
                      ? "Please enter recipient name"
                      : null,
                ),
                inputSpacing,
                TextFormField(
                  controller: toNumberController,
                  decoration: const InputDecoration(labelText: "To Number"),
                  keyboardType: TextInputType.phone,
                  maxLength: 11, // Limit to 11 digits
                  validator: _validatePhoneNumber,
                ),
                inputSpacing,
                TextFormField(
                  controller: toNoteController,
                  decoration: const InputDecoration(labelText: "Note"),
                ),
                inputSpacing,
                TextFormField(
                  controller: fromNameController,
                  decoration: const InputDecoration(labelText: "From Name"),
                  validator: (value) => value == null || value.isEmpty
                      ? "Please enter sender name"
                      : null,
                ),
                inputSpacing,
                TextFormField(
                  controller: fromNumberController,
                  decoration: const InputDecoration(labelText: "From Number"),
                  keyboardType: TextInputType.phone,
                  maxLength: 11, // Limit to 11 digits
                  validator: _validatePhoneNumber,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _navigateToReceiptPage,
                  child: const Text('Generate Receipt'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// -----------------------------
// Receipt Page
// -----------------------------
class ReceiptPage extends StatefulWidget {
  final String tid;
  final String dateTime;
  final String amount;
  final String fee;
  final String toName;
  final String toNumber;
  final String toNote;
  final String fromName;
  final String fromNumber;

  const ReceiptPage({
    super.key,
    required this.tid,
    required this.dateTime,
    required this.amount,
    required this.fee,
    required this.toName,
    required this.toNumber,
    required this.toNote,
    required this.fromName,
    required this.fromNumber,
  });

  @override
  State<ReceiptPage> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  final ScreenshotController screenshotController = ScreenshotController();

  String _maskPhoneNumber(String number) {
    if (number.length <= 4) return number;
    return '*' * (number.length - 4) + number.substring(number.length - 4);
  }

  // --- MODIFIED FUNCTION ---
  Future<void> _saveReceipt() async {
    // 1. Request the correct, modern permission for saving photos
    var status = await Permission.photos.request();
    if (!status.isGranted) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Permission denied. Cannot save receipt."),
          ),
        );
      }
      return;
    }

    // 2. Capture the screenshot
    final image = await screenshotController.capture();
    if (image == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to capture receipt image.")),
        );
      }
      return;
    }

    // 3. Find a reliable directory to save the file
    Directory? directory;
    try {
      if (Platform.isAndroid) {
        // Use the public downloads directory
        directory = Directory('/storage/emulated/0/Download');
        // Create it if it doesn't exist
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      } else {
        directory = await getApplicationDocumentsDirectory();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to find save directory.")),
        );
      }
      return;
    }

    if (directory == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could not resolve save directory.")),
        );
      }
      return;
    }

    // 4. Save the file
    final fileName =
        "receipt_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}.png";
    final filePath = "${directory.path}/$fileName";
    final file = File(filePath);
    await file.writeAsBytes(image);

    // 5. Notify the user of success
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Receipt saved in Downloads folder")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final darkBlackSilver = Colors.grey[850];

    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C),
      appBar: AppBar(
        title: const Text('Preview Receipt'),
        backgroundColor: const Color(0xFF222831),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                constraints: const BoxConstraints(maxWidth: 320),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromRGBO(11, 15, 24, 0.25),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Screenshot(
                  controller: screenshotController,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 16,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Transaction Successful",
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1F2937),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "TID: ${widget.tid}",
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              widget.dateTime,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: Colors.grey[700],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),

                            // Amount
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        "Rs. ${widget.amount.contains('.') ? widget.amount.split('.').first : widget.amount}",
                                    style: GoogleFonts.inter(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: widget.amount.contains('.')
                                        ? ".${widget.amount.split('.').last}"
                                        : ".00",
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Transferred via RAAST",
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[500],
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Divider(color: Color(0xFFE5E7EB)),

                            // Fee
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Fee",
                                  style: GoogleFonts.inter(fontSize: 12),
                                ),
                                Text(
                                  "Rs. ${widget.fee.isEmpty ? '0.00' : widget.fee}",
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(color: Color(0xFFE5E7EB)),

                            // To Section
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "To",
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: Colors.grey[500],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      widget.toName,
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: darkBlackSilver,
                                      ),
                                    ),
                                    Text(
                                      _maskPhoneNumber(widget.toNumber),
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: darkBlackSilver,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      widget.toNote,
                                      style: GoogleFonts.inter(
                                        fontSize: 10,
                                        color: darkBlackSilver,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Divider(color: Color(0xFFE5E7EB)),

                            // From Section
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "From",
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: Colors.grey[500],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      widget.fromName,
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: darkBlackSilver,
                                      ),
                                    ),
                                    Text(
                                      widget.fromNumber,
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: darkBlackSilver,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Footer
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Securely paid via",
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                color: Colors.grey[700],
                              ),
                            ),
                            const SizedBox(width: 6),
                            SizedBox(
                              height: 28,
                              child: Image.asset(
                                "assets/images/jazzcash.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Download button
              ElevatedButton.icon(
                onPressed: _saveReceipt,
                icon: const Icon(Icons.download),
                label: const Text("Download Receipt"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
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
