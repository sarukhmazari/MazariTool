import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'unban_result_page.dart';

class UnbanToolPage extends StatefulWidget {
  const UnbanToolPage({super.key});

  @override
  State<UnbanToolPage> createState() => _UnbanToolPageState();
}

class _UnbanToolPageState extends State<UnbanToolPage> {
  String? _selectedLanguage;
  final TextEditingController _phoneController = TextEditingController();
  final List<String> _languages = ['English', 'Portuguese'];
  bool _isLoading = false; // State to manage the loading indicator

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  // Function to handle the submit action with a loading state
  Future<void> _handleSubmit() async {
    if (_selectedLanguage == null || _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a language and enter a phone number"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate a network request with a delay
      await Future.delayed(const Duration(seconds: 2));

      // Navigate to the next page after the "request" is complete
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UnbanResultPage(
              language: _selectedLanguage!,
              phone: _phoneController.text,
            ),
          ),
        );
      }
    } finally {
      // Ensure the loading state is turned off
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E2A47),
      appBar: AppBar(
        title: const Text(
          "Unban Tool",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1A233A),
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.5),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Select your language:",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF283A59),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedLanguage,
                    dropdownColor: const Color(0xFF1E2A47),
                    hint: const Text(
                      "Choose language",
                      style: TextStyle(color: Colors.white70),
                    ),
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                    items: _languages.map((lang) {
                      return DropdownMenuItem(
                        value: lang,
                        child: Text(
                          lang,
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedLanguage = value;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Enter your phone number:",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF283A59),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\+?\d*')),
                  ],
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 20,
                    ),
                    border: InputBorder.none,
                    hintText: "+123456789012345",
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Container(
                width: double.infinity,
                height: 65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8E9EAB), Color(0xFFE8EBF2)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                        0.2,
                      ), // Tweak shadow for a subtle effect
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : _handleSubmit, // Disable button when loading
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Color(0xFF1E2A47),
                            strokeWidth: 3,
                          ),
                        )
                      : const Text(
                          "Submit",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E2A47),
                            letterSpacing: 2.0,
                          ),
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
