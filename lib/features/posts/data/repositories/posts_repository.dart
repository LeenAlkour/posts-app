// posts_repository.dart
import 'package:dartz/dartz.dart';
import 'package:ebtech_task_flutter/core/error_handler/api_error_handler.dart';
import 'package:ebtech_task_flutter/core/error_handler/failure.dart';
import '../models/post_model.dart';
import '../services/posts_api.dart';

abstract class Repository {
  Future<Either<Failure, List<PostModel>>> getPosts();
  Future<Either<Failure, PostModel>> addComment({
    required String postId,
    required String author,
    required String email,
    required String content,
  });
  Future<Either<Failure, PostModel>> createPost({
    required String author,
    required String title,
    required String content,
  });
  Future<Either<Failure, void>> deletePost(String postId);
}

class PostsRepository implements Repository {
  final PostsApi api;

  PostsRepository(this.api);

  @override
  Future<Either<Failure, List<PostModel>>> getPosts() async {
    try {
      final posts = await api.fetchPosts();
      return Right(posts);
    } catch (error) {
      return Left(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<Failure, PostModel>> createPost({
    required String author,
    required String title,
    required String content,
  }) async {
    try {
      final post = await api.createPost(
        author: author,
        title: title,
        content: content,
      );
      return Right(post);
    } catch (error) {
      return Left(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<Failure, PostModel>> addComment({
    required String postId,
    required String author,
    required String email,
    required String content,
  }) async {
    try {
      final post = await api.addComment(
        postId: postId,
        author: author,
        email: email,
        content: content,
      );
      return Right(post);
    } catch (error) {
      return Left(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<Failure, void>> deletePost(String postId) async {
    try {
      await api.deletePost(postId);
      return const Right(null);
    } catch (error) {
      return Left(ApiErrorHandler.handle(error));
    }
  }
}
