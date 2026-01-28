import 'package:flutter/material.dart';
import '../models/paper.dart';
import '../services/api_service.dart';
import '../widgets/paper_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  // Toggle this to true to force mock data usage
  bool _useMockData = false; 
  late Future<List<Paper>> _feedFuture;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _loadFeed();
  }

  void _loadFeed() {
    setState(() {
      _feedFuture = ApiService(useMockData: _useMockData).fetchFeed();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Footnote"),
        backgroundColor: Colors.transparent,
        actions: [
          // Hidden debug toggle for mock mode
          IconButton(
            icon: Icon(_useMockData ? Icons.bug_report : Icons.bug_report_outlined),
            tooltip: 'Toggle Mock Data',
            onPressed: () {
              setState(() {
                _useMockData = !_useMockData;
                _loadFeed();
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Mock Data: ${_useMockData ? 'ON' : 'OFF'}')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadFeed,
          )
        ],
      ),
      body: FutureBuilder<List<Paper>>(
        future: _feedFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
             return Center(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   const Icon(Icons.error_outline, size: 48, color: Colors.red),
                   const SizedBox(height: 16),
                   Text("Error loading feed.\n${snapshot.error}", textAlign: TextAlign.center),
                   const SizedBox(height: 16),
                   ElevatedButton(
                     onPressed: () {
                        setState(() {
                          _useMockData = true; // Suggest switching to mock data on error
                          _loadFeed();
                        });
                     }, 
                     child: const Text("Try Mock Data Mode")
                   ),
                   TextButton(onPressed: _loadFeed, child: const Text("Retry"))
                 ],
               ),
             );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No papers found."));
          }

          final papers = snapshot.data!;
          return SelectionArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: ListView.builder(
                  itemCount: papers.length,
                  padding: const EdgeInsets.only(bottom: 20),
                  itemBuilder: (context, index) {
                    return PaperCard(paper: papers[index]);
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
