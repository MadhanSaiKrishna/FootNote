import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/feed_screen.dart';

void main() {
  runApp(const FootnoteApp());
}

class FootnoteApp extends StatelessWidget {
  const FootnoteApp({super.key});

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
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
          surface: const Color(0xFF000000), // OLED Black
        ),
        textTheme: GoogleFonts.interTextTheme(
          ThemeData.dark().textTheme,
        ),
        scaffoldBackgroundColor: const Color(0xFF000000), // OLED Black
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF000000),
          surfaceTintColor: Colors.transparent,
        ),
      ),
      home: const FeedScreen(),
    );
  }
}
