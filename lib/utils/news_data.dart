class News {
  final String title;
  final String description;
  final String imageUrl;
  final String content;

  News({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.content,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['urlToImage'] ??
          '', // Make sure 'urlToImage' is properly set in API response
      content: json['content'] ?? '',
    );
  }
}
