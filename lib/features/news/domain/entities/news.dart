class News {
  final String title;
  final String? description;
  final DateTime? date;
  final String? imageUrl;
  final String source;
  final String text;

  News({
    required this.title,
    this.description,
    this.date,
    this.imageUrl,
    required this.source,
    required this.text
  });
}
