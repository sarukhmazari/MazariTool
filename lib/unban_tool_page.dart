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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D), // Black background
      appBar: AppBar(
        title: const Text(
          "Unban Tool",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [Shadow(color: Colors.cyanAccent, blurRadius: 12)],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 10,
        shadowColor: Colors.purpleAccent,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Language Text
              const Text(
                "Select your language:",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.pinkAccent, blurRadius: 15)],
                ),
              ),
              const SizedBox(height: 16),

              // Language Dropdown
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.cyan, Colors.purple, Colors.pink],
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purpleAccent.withOpacity(0.6),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _selectedLanguage,
                  dropdownColor: Colors.black87,
                  hint: const Text(
                    "Choose language",
                    style: TextStyle(color: Colors.white70),
                  ),
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  underline: const SizedBox(),
                  items: _languages.map((lang) {
                    return DropdownMenuItem(value: lang, child: Text(lang));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedLanguage = value;
                    });
                  },
                ),
              ),

              const SizedBox(height: 35),

              // Phone Text
              const Text(
                "Enter your phone number:",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.cyanAccent, blurRadius: 15)],
                ),
              ),
              const SizedBox(height: 16),

              // Phone Input
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                    colors: [Colors.cyan, Colors.purple, Colors.pink],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.cyanAccent.withOpacity(0.6),
                      blurRadius: 15,
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\+?\d{0,15}')),
                  ],
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 16,
                    ),
                    border: InputBorder.none,
                    hintText: "+123456789012345",
                    hintStyle: const TextStyle(color: Colors.white70),
                  ),
                ),
              ),

              const SizedBox(height: 45),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 70,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.cyan, Colors.purple, Colors.pink],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pinkAccent.withOpacity(0.6),
                        blurRadius: 20,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_selectedLanguage == null ||
                          _phoneController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Please select language and enter phone number",
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
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
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5,
                        shadows: [
                          Shadow(color: Colors.cyanAccent, blurRadius: 15),
                        ],
                      ),
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
