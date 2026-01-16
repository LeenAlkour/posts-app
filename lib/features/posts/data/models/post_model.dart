import 'comment_model.dart';

class PostModel {
  final String id;
  final String author;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String title;
  final String image;
  final String content;
  final int commentsCount;
  final List<CommentModel> comments;

  PostModel({
    required this.id,
    required this.author,
    required this.createdAt,
    this.updatedAt,
    required this.title,
    required this.image,
    required this.content,
    required this.commentsCount,
    required this.comments,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    var commentList =
        (json['comments'] as List<dynamic>?)
            ?.map((e) => CommentModel.fromJson(e))
            .toList() ??
        [];

    return PostModel(
      id: json['id'] ?? '',
      author: json['author'] ?? 'Unknown Author',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      image: json['image'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      commentsCount: json['commentsCount'] ?? commentList.length,
      comments: commentList,
    );
  }

  Map<String, dynamic> toJson() {
    return {'author': author, 'title': title, 'content': content};
  }
}
