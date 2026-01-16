class CommentModel {
  final String id;
  final String image;
  final String author;
  final DateTime createdAt;
  final String content;

  CommentModel({
    required this.id,
    required this.image,
    required this.author,
    required this.createdAt,
    required this.content,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] ?? '',
      image: json['image'],
      author: json['author'] ?? 'Unknown User',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      content: json['content'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': author,
      'createdAt': createdAt.toIso8601String(),
      'content': content,
    };
  }
}
