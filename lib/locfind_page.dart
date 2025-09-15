import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class LocFindPage extends StatefulWidget {
  const LocFindPage({super.key});

  @override
  _LocFindPageState createState() => _LocFindPageState();
}

class _LocFindPageState extends State<LocFindPage> {
  final TextEditingController _ipController = TextEditingController();
  Map<String, dynamic>? _locationData;
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _getLocation() async {
    String ip = _ipController.text.trim();

    // If no IP entered, fetch user's public IP
    if (ip.isEmpty) {
      try {
        final ipResponse = await http.get(
          Uri.parse("https://api.ipify.org?format=json"),
        );
        if (ipResponse.statusCode == 200) {
          final ipData = jsonDecode(ipResponse.body);
          ip = ipData["ip"];
        } else {
          setState(() {
            _errorMessage = "Could not fetch your public IP.";
          });
          return;
        }
      } catch (e) {
        setState(() {
          _errorMessage = "Error fetching your public IP: $e";
        });
        return;
      }
    }

    // Validate IP format (IPv4 only here)
    final ipRegex = RegExp(r'^(\d{1,3}\.){3}\d{1,3}$');
    if (!ipRegex.hasMatch(ip)) {
      setState(() {
        _errorMessage = "Please enter a valid IP address (e.g. 8.8.8.8).";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _locationData = null;
      _errorMessage = null;
    });

    try {
      final response = await http.get(Uri.parse('http://ip-api.com/json/$ip'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          setState(() {
            _locationData = data;
          });
        } else {
          setState(() {
            if (data['message'] == "private range") {
              _errorMessage =
                  "❌ This is a private/local IP ($ip). Please use a public IP.";
            } else {
              _errorMessage = data['message'] ?? "Invalid IP address.";
            }
          });
        }
      } else {
        setState(() {
          _errorMessage =
              "Failed to fetch location. Status code: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "An error occurred: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _launchMap() async {
    if (_locationData != null &&
        _locationData!['lat'] != null &&
        _locationData!['lon'] != null) {
      final lat = _locationData!['lat'];
      final lon = _locationData!['lon'];
      final url = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=$lat,$lon",
      );
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Could not open map.')));
      }
    }
  }

  @override
  void dispose() {
    _ipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF222831),
      appBar: AppBar(
        title: const Text(
          "Location Finder",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF283244),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Enter an IP Address to find its location.\n(Leave empty to detect your own IP)",
              style: TextStyle(color: Colors.white70, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF394867),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _ipController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'e.g., 8.8.8.8',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _getLocation,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF66FCF1),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Color(0xFF222831))
                  : const Text(
                      "Find Location",
                      style: TextStyle(
                        color: Color(0xFF222831),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            if (_locationData != null) ...[
              const SizedBox(height: 20),
              Card(
                color: const Color(0xFF283244),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLocationDetail(
                        'IP Address',
                        _locationData!['query'],
                      ),
                      _buildLocationDetail(
                        'Country',
                        _locationData!['country'],
                      ),
                      _buildLocationDetail(
                        'Region',
                        _locationData!['regionName'],
                      ),
                      _buildLocationDetail('City', _locationData!['city']),
                      _buildLocationDetail('ISP', _locationData!['isp']),
                      _buildLocationDetail(
                        'Latitude',
                        _locationData!['lat'].toString(),
                      ),
                      _buildLocationDetail(
                        'Longitude',
                        _locationData!['lon'].toString(),
                      ),
                      _buildLocationDetail(
                        'Timezone',
                        _locationData!['timezone'],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _launchMap,
                        icon: const Icon(Icons.map, color: Color(0xFF222831)),
                        label: const Text(
                          "View on Map",
                          style: TextStyle(color: Color(0xFF222831)),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF66FCF1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLocationDetail(String title, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title:',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
