import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/paper.dart';

class ApiService {
  ApiService();

  // TODO: Update this to your computer's LAN IP if running on a physical phone.
  // Run `hostname -I` in terminal to find it.
  static const String serverIp = '172.22.160.200';

  String get baseUrl {
    if (kIsWeb) return 'http://localhost:8000';
    if (Platform.isAndroid) {
      // Use 10.0.2.2 for Android Emulator, but physical device needs real LAN IP
      const bool isEmulator = false; // Set to true if using emulator
      if (isEmulator) return 'http://10.0.2.2:8000';
      return 'http://$serverIp:8000';
    }
    return 'http://localhost:8000'; // Linux, macOS, Windows
  }

  Future<List<Paper>> fetchFeed() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/feed'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Paper.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load feed');
      }
    } catch (e) {
      // Fallback or rethrow based on UX preference
      print('Error fetching feed: $e');
      // Rethrowing to let the UI handle the error state
      throw e;
    }
  }
}
