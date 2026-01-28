import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/paper.dart';

class PaperCard extends StatelessWidget {
  final Paper paper;

  const PaperCard({super.key, required this.paper});

  Future<void> _launchUrl(String? url) async {
    if (url == null) return;
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 0,
      color: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Categories
            Wrap(
              spacing: 8,
              children: paper.categories.map((tag) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    fontSize: 10,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )).toList(),
            ),
            const SizedBox(height: 12),
            // Title
            Text(
              paper.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            // Authors & Date
            Text(
              "${paper.authors.join(', ')} • ${paper.publishedDate}",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(height: 16),
            // Summary Points
            ...paper.summaryPoints.map((point) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("• ", style: TextStyle(color: Colors.white70)),
                  Expanded(
                    child: Text(
                      point,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            )),
            const SizedBox(height: 16),
            // Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (paper.pdfUrl != null)
                  TextButton.icon(
                    onPressed: () => _launchUrl(paper.pdfUrl),
                    icon: const Icon(Icons.picture_as_pdf),
                    label: const Text("PDF"),
                  ),
                const SizedBox(width: 8),
                FilledButton.icon(
                  onPressed: () => _launchUrl(paper.sourceUrl),
                  icon: const Icon(Icons.open_in_new),
                  label: const Text("Read More"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
