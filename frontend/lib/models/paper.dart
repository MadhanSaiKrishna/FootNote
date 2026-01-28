class Paper {
  final int id;
  final String title;
  final List<String> summaryPoints;
  final List<String> authors;
  final String publishedDate;
  final String sourceUrl;
  final String? pdfUrl;
  final List<String> categories;

  Paper({
    required this.id,
    required this.title,
    required this.summaryPoints,
    required this.authors,
    required this.publishedDate,
    required this.sourceUrl,
    this.pdfUrl,
    required this.categories,
  });

  factory Paper.fromJson(Map<String, dynamic> json) {
    return Paper(
      id: json['id'],
      title: json['title'],
      summaryPoints: List<String>.from(json['summary_points'] ?? []),
      authors: List<String>.from(json['authors'] ?? []),
      publishedDate: json['published_date'],
      sourceUrl: json['source_url'],
      pdfUrl: json['pdf_url'],
      categories: List<String>.from(json['categories'] ?? []),
    );
  }
}
