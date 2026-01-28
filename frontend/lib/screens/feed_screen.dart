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
  late Future<List<Paper>> _feedFuture;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _loadFeed();
  }

  void _loadFeed() {
    setState(() {
      _feedFuture = _apiService.fetchFeed();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      body: Row(
        children: [
          if (isDesktop)
            NavigationRail(
              backgroundColor: Colors.black,
              selectedIndex: 0,
              onDestinationSelected: (int index) {},
              labelType: NavigationRailLabelType.all,
              leading: const Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0),
                child: Icon(Icons.auto_stories, color: Colors.deepPurpleAccent, size: 32),
              ),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.newspaper),
                  label: Text('Feed'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.bookmark_border),
                  label: Text('Saved'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.settings_outlined),
                  label: Text('Settings'),
                ),
              ],
            ),
          if (isDesktop) const VerticalDivider(thickness: 1, width: 1, color: Colors.white10),
          Expanded(
            child: Scaffold(
               // Nested scaffold to keep AppBar behavior for the content area or just use Column
               appBar: AppBar(
                title: const Text("Footnote", style: TextStyle(fontWeight: FontWeight.bold)),
                centerTitle: !isDesktop,
                actions: [
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
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                          itemBuilder: (context, index) {
                            return PaperCard(paper: papers[index]);
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
