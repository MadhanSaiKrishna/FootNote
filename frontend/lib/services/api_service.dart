import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/paper.dart';

class ApiService {
  final bool useMockData;

  ApiService({this.useMockData = false});

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
    if (useMockData) {
      return _getMockPapers();
    }

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
      // For now, if connection fails, we might want to show mock data or empty state
      // Rethrowing to let the UI handle the error state
      throw e;
    }
  }

  List<Paper> _getMockPapers() {
    return [
      Paper(
        id: 1,
        title: "VGGT-SLAM 2.0: Real time Dense Feed-forward Scene Reconstruction",
        summaryPoints: [
          "Uses dense feed-forward scene reconstruction.",
          "Improves real-time performance on various datasets.",
          "Citation: [Maggio et al., 2026]"
        ],
        authors: ["Dominic Maggio", "Luca Carlone"],
        publishedDate: "2026-01-27",
        sourceUrl: "http://arxiv.org/abs/2601.19887v1",
        pdfUrl: "https://arxiv.org/pdf/2601.19887v1",
        categories: ["cs.CV", "cs.RO"],
      ),
      Paper(
        id: 2,
        title: "Interstellar Propulsion via Laser Arrays",
        summaryPoints: [
          "Proposes a new laser array configuration for light sails.",
          "Achieves 20% efficiency gain over previous models.",
          "Requires new material science breakthroughs [Smith, 2025]."
        ],
        authors: ["J. Doe", "A. Einstein"],
        publishedDate: "2026-01-28",
        sourceUrl: "http://nasa.gov",
        pdfUrl: null,
        categories: ["physics.space-ph"],
      ),
    ];
  }
}
