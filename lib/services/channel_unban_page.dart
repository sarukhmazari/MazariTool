import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'button_page.dart';

class ChannelUnbanPage extends StatefulWidget {
  const ChannelUnbanPage({super.key});

  @override
  State<ChannelUnbanPage> createState() => _ChannelUnbanPageState();
}

class _ChannelUnbanPageState extends State<ChannelUnbanPage> {
  final TextEditingController _channelController = TextEditingController();
  final TextEditingController _whatsappController = TextEditingController();
  final TextEditingController _channelLinkController = TextEditingController();

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _channelController.addListener(() => setState(() {}));
    _whatsappController.addListener(() => setState(() {}));
    _channelLinkController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _channelController.dispose();
    _whatsappController.dispose();
    _channelLinkController.dispose();
    super.dispose();
  }

  bool get isNextEnabled =>
      _channelController.text.isNotEmpty &&
      _whatsappController.text.isNotEmpty &&
      _channelLinkController.text.isNotEmpty &&
      _selectedDay != null;

  void _validateAndProceed() {
    if (isNextEnabled) {
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => ButtonPage(
            selectedDate: _selectedDay!,
            channelName: _channelController.text,
            whatsappNumber: _whatsappController.text,
          ),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields and select a date."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _focusedDay,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF66FCF1),
              onPrimary: Color(0xFF1E2A47),
              surface: Color(0xFF1A233A),
              onSurface: Colors.white,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Colors.white70),
            ),
          ),
          child: child!,
        );
      },
    );

    setState(() {
      _selectedDay = picked;
      _focusedDay = picked ?? _focusedDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E2A47),
      appBar: AppBar(
        title: Text(
          "Channel Unban",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1A233A),
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.5),
        leading: const BackButton(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Text(
              "Unban Your Channel",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            _buildTextField(
              controller: _channelController,
              labelText: "Channel Name",
              icon: Icons.chat,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _channelLinkController,
              labelText: "Channel Link",
              icon: Icons.link,
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _whatsappController,
              labelText: "Your WhatsApp Number",
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 24),
            _buildDateInput(),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: isNextEnabled ? _validateAndProceed : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.zero,
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: isNextEnabled
                        ? const LinearGradient(
                            colors: [Color(0xFF66FCF1), Color(0xFF45A29E)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : null,
                    color: !isNextEnabled ? Colors.white12 : null,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      "Next",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isNextEnabled ? Colors.white : Colors.white54,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextField(
      controller: controller,
      style: GoogleFonts.poppins(color: Colors.white),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: GoogleFonts.poppins(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white70),
        filled: true,
        fillColor: const Color(0xFF1A233A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF394867), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF66FCF1), width: 2),
        ),
      ),
    );
  }

  Widget _buildDateInput() {
    return GestureDetector(
      onTap: _pickDate,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A233A),
          border: Border.all(color: const Color(0xFF394867), width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, color: Colors.white70),
            const SizedBox(width: 12),
            Text(
              _selectedDay == null
                  ? "Select a date"
                  : "${_selectedDay!.day}-${_selectedDay!.month}-${_selectedDay!.year}",
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
