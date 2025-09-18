import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'group_result_page.dart';

class GroupUnbanPage extends StatefulWidget {
  const GroupUnbanPage({super.key});

  @override
  State<GroupUnbanPage> createState() => _GroupUnbanPageState();
}

class _GroupUnbanPageState extends State<GroupUnbanPage> {
  final _formKey = GlobalKey<FormState>();
  String? _groupType;
  final TextEditingController _groupNameController = TextEditingController();
  final TextEditingController _whatsappNumberController =
      TextEditingController();
  DateTime? _selectedDate;

  final List<String> _groupCategories = [
    "Study",
    "Business",
    "Friends",
    "Family",
    "Sports",
    "Travel",
    "Technology",
    "Gaming",
    "Health & Fitness",
    "Music",
    "Movies & Entertainment",
    "Education",
    "News & Media",
    "Shopping & Deals",
    "Food & Recipes",
    "Religion & Spiritual",
    "Community Support",
    "Jobs & Careers",
    "Events & Meetups",
    "Hobbies",
    "Other",
  ];

  void _pickDate() async {
    DateTime now = DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2020),
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: const Color(0xFF2196F3), // Accent blue
              onPrimary: Colors.white,
              surface: const Color(0xFF2E2E2E), // Card background color
              onSurface: Colors.white,
            ),
            dialogTheme: DialogThemeData(
              backgroundColor: const Color(
                0xFF1E1E1E,
              ), // Overall background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    setState(() {
      _selectedDate = picked;
    });
    }

  void _validateAndProceed() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GroupResultPage(
            groupType: _groupType!,
            groupName: _groupNameController.text,
            whatsappNumber: _whatsappNumberController.text,
            selectedDate: _selectedDate!,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF2196F3);
    final Color accentColor = const Color(0xFF42A5F5);
    final Color inputFillColor = const Color(0xFF2E2E2E);
    final Color inputBorderColor = const Color(0xFF424242);
    final Color inputTextColor = Colors.white;

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        title: Text(
          "Group Unban Form",
          style: GoogleFonts.lato(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
        ),
        backgroundColor: const Color(0xFF1E1E1E),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel("Group Category", Colors.white),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _groupType,
                  dropdownColor: inputFillColor,
                  style: TextStyle(color: inputTextColor),
                  decoration: _inputDecoration(
                    "Select Group Category",
                    Icons.category_outlined,
                    primaryColor,
                    inputFillColor,
                    inputBorderColor,
                  ),
                  items: _groupCategories
                      .map(
                        (type) => DropdownMenuItem(
                          value: type,
                          child: Text(
                            type,
                            style: GoogleFonts.lato(color: inputTextColor),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _groupType = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? "Please select a group category" : null,
                ),
                const SizedBox(height: 25),
                _buildLabel("Group Name", Colors.white),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _groupNameController,
                  style: GoogleFonts.lato(color: inputTextColor),
                  decoration: _inputDecoration(
                    "Enter Group Name",
                    Icons.group_outlined,
                    primaryColor,
                    inputFillColor,
                    inputBorderColor,
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Please enter group name" : null,
                ),
                const SizedBox(height: 25),
                _buildLabel("Your WhatsApp Number", Colors.white),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _whatsappNumberController,
                  keyboardType: TextInputType.phone,
                  style: GoogleFonts.lato(color: inputTextColor),
                  decoration: _inputDecoration(
                    "Enter Your WhatsApp Number",
                    Icons.phone_android_outlined,
                    primaryColor,
                    inputFillColor,
                    inputBorderColor,
                  ),
                  validator: (value) => value!.isEmpty
                      ? "Please enter your WhatsApp number"
                      : null,
                ),
                const SizedBox(height: 25),
                _buildLabel("Ban Date", Colors.white),
                const SizedBox(height: 10),
                InkWell(
                  onTap: _pickDate,
                  child: InputDecorator(
                    decoration: _inputDecoration(
                      "Select Date",
                      Icons.calendar_today_outlined,
                      primaryColor,
                      inputFillColor,
                      inputBorderColor,
                    ),
                    child: Text(
                      _selectedDate == null
                          ? "Select Date"
                          : DateFormat("dd-MM-yyyy").format(_selectedDate!),
                      style: GoogleFonts.lato(
                        color: _selectedDate == null
                            ? Colors.grey
                            : inputTextColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    gradient: LinearGradient(
                      colors: [primaryColor, accentColor],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: _validateAndProceed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      "Next",
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text, Color color) {
    return Text(
      text,
      style: GoogleFonts.lato(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    );
  }

  InputDecoration _inputDecoration(
    String hintText,
    IconData icon,
    Color primaryColor,
    Color fillColor,
    Color borderColor,
  ) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: GoogleFonts.lato(color: Colors.grey.shade600),
      prefixIcon: Icon(icon, color: Colors.grey.shade500),
      filled: true,
      fillColor: fillColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderColor, width: 1),
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
    );
  }
}
