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
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      color: const Color(0xFF111111), // Subtle contrast against black background
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Colors.white10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Categories
            Wrap(
              spacing: 8,
              children: paper.categories.map((tag) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    fontSize: 11,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )).toList(),
            ),
            const SizedBox(height: 16),
            // Title
            SelectableText(
              paper.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 12),
            // Authors & Date
            Text(
              "${paper.authors.join(', ')} • ${paper.publishedDate}",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(height: 24),
            // Summary Points
            ...paper.summaryPoints.map((point) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Padding(
                     padding: const EdgeInsets.only(top: 6.0),
                     child: Icon(Icons.circle, size: 6, color: Colors.grey[600]),
                   ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SelectableText(
                      point,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey[300],
                        height: 1.6,
                      ),
                    ),
                  ),
                ],
              ),
            )),
            const SizedBox(height: 20),
            // Actions
            Divider(color: Colors.white.withOpacity(0.05)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (paper.pdfUrl != null)
                  TextButton.icon(
                    onPressed: () => _launchUrl(paper.pdfUrl),
                    icon: const Icon(Icons.picture_as_pdf_outlined, size: 20),
                    label: const Text("PDF"),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.grey[400],
                    ),
                  ),
                const SizedBox(width: 12),
                FilledButton.icon(
                  onPressed: () => _launchUrl(paper.sourceUrl),
                  icon: const Icon(Icons.open_in_new, size: 18),
                  label: const Text("Read Source"),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
