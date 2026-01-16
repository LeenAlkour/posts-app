// posts_api.dart
import 'package:dio/dio.dart';
import '../models/post_model.dart';

class PostsApi {
  final Dio dio;

  PostsApi(this.dio);

  Future<List<PostModel>> fetchPosts() async {
    try {
      final response = await dio.get('/posts');
      return (response.data as List)
          .map((json) => PostModel.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<PostModel> createPost({
    required String author,
    required String title,
    required String content,
  }) async {
    try {
      final response = await dio.post(
        '/posts',
        data: {
          'author': author,
          'title': title,
          'content': content,
          'commentsCount': 0,
          'comments': [],
        },
      );
      return PostModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<PostModel> addComment({
    required String postId,
    required String author,
    required String email,
    required String content,
  }) async {
    try {
      final response = await dio.post(
        '/posts/$postId/comments',
        data: {'author': author, 'email': email, 'content': content},
      );
      return PostModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      await dio.delete('/posts/$postId');
    } catch (e) {
      rethrow;
    }
  }
}
