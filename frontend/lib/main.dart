import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/feed_screen.dart';

void main() {
  runApp(const AstrolitApp());
}

class AstrolitApp extends StatelessWidget {
  const AstrolitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Footnote',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750A4),
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.interTextTheme(
          ThemeData.dark().textTheme,
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      home: const FeedScreen(),
    );
  }
}
